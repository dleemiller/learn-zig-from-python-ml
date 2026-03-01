# Lesson 3.5: ArenaAllocator

## Learning Objectives

- [ ] Understand the "allocate many, free all at once" pattern
- [ ] Create an `ArenaAllocator` wrapping a backing allocator
- [ ] Use `arena.deinit()` for bulk deallocation
- [ ] Use `arena.reset()` for reuse without reallocation
- [ ] Apply the two-allocator pattern (arena scratch + backing result)

## Prerequisites

- Completed Lesson 3.3 (allocator interface)
- Completed Lesson 3.4 (GPA as backing allocator)
- Comfortable with `defer`

## The Problem: Too Many Individual Frees

Imagine processing a batch of data:

```zig
fn processBatch(allocator: std.mem.Allocator, items: []const Item) !void {
    for (items) |item| {
        const temp1 = try allocator.alloc(u8, item.size);
        defer allocator.free(temp1);

        const temp2 = try allocator.alloc(f64, 100);
        defer allocator.free(temp2);

        const temp3 = try allocator.alloc(i32, 50);
        defer allocator.free(temp3);

        // ... process ...
    }
    // Each iteration: 3 allocs + 3 frees. For 10,000 items = 60,000 operations!
}
```

All that allocation bookkeeping is wasteful when you know all the temporaries die together.

## Arena: Allocate Many, Free All at Once

An `ArenaAllocator` batches allocations and frees them all with one `deinit()`:

```zig
fn processBatch(backing: std.mem.Allocator, items: []const Item) !void {
    var arena = std.heap.ArenaAllocator.init(backing);
    defer arena.deinit();  // Frees EVERYTHING allocated from this arena

    const alloc = arena.allocator();

    for (items) |item| {
        const temp1 = try alloc.alloc(u8, item.size);
        const temp2 = try alloc.alloc(f64, 100);
        const temp3 = try alloc.alloc(i32, 50);
        // No individual frees needed!
        _ = temp1;
        _ = temp2;
        _ = temp3;
    }
}
// arena.deinit() frees all allocations in one shot
```

**How it works**: The arena allocates large blocks from the backing allocator and sub-allocates from those blocks. `deinit()` frees the large blocks — instant cleanup regardless of how many individual allocations were made.

## Creating an Arena

```zig
const std = @import("std");

pub fn main() !void {
    // 1. Create the backing allocator (GPA, or whatever you want)
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const check = gpa.deinit();
        if (check == .leak) std.debug.print("leak!\n", .{});
    }

    // 2. Create the arena, backed by GPA
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    // 3. Get the allocator interface
    const alloc = arena.allocator();

    // 4. Allocate freely — no individual frees needed
    const a = try alloc.alloc(u8, 100);
    const b = try alloc.alloc(i32, 50);
    const c = try alloc.alloc(f64, 200);
    _ = a;
    _ = b;
    _ = c;
    // All freed when arena.deinit() runs
}
```

## Resetting an Arena

If you want to reuse the arena (e.g., processing multiple batches), use `reset()`:

```zig
var arena = std.heap.ArenaAllocator.init(backing);
defer arena.deinit();

const alloc = arena.allocator();

// Process batch 1
const data1 = try alloc.alloc(i32, 1000);
_ = data1;
// ... work with data1 ...

// Reset: free all allocations, keep the underlying buffer
arena.reset(.retain_capacity);

// Process batch 2 — reuses the same memory
const data2 = try alloc.alloc(i32, 1000);
_ = data2;
// ... work with data2 ...
```

`reset(.retain_capacity)` frees all arena allocations but keeps the memory from the backing allocator for reuse. This avoids repeatedly asking the backing allocator for memory.

## The Two-Allocator Pattern

This is one of the most important patterns in Zig — and it directly applies to ML:

> Use an **arena** for temporary/scratch work. Use the **backing allocator** for results that outlive the arena.

```zig
fn computeResult(backing: std.mem.Allocator, input: []const i32) ![]i32 {
    // Arena for scratch work
    var arena = std.heap.ArenaAllocator.init(backing);
    defer arena.deinit();
    const scratch = arena.allocator();

    // Scratch work: temporary buffers, intermediate results
    const temp = try scratch.alloc(i32, input.len);
    for (input, 0..) |val, i| {
        temp[i] = val * 2;
    }

    // Final result: allocated from BACKING allocator (survives arena.deinit)
    const result = try backing.alloc(i32, input.len);
    errdefer backing.free(result);
    @memcpy(result, temp);

    return result;  // Caller owns this — allocated from backing, not arena
}
```

**Why this works**:
- Scratch memory (`temp`) is freed automatically by `arena.deinit()`
- The result is allocated from `backing`, so it survives the arena cleanup
- The caller gets a clean result without worrying about the scratch work

## When to Use Arenas

| Scenario | Arena? | Why |
|----------|--------|-----|
| Many small temporary allocations | Yes | Batch free is faster |
| Request/response processing | Yes | All temps die together |
| Per-inference ML scratch work | Yes | Clean slate each inference |
| Long-lived data (weights, config) | No | Use GPA or backing allocator |
| Single allocation | No | Overhead not worth it |

## For Python Developers

| Python | Zig | Notes |
|--------|-----|-------|
| GC reclaims objects in batches | `arena.deinit()` — explicit batch free | You control when |
| `gc.collect()` | `arena.reset(.retain_capacity)` | Explicit cleanup |
| No concept of scratch memory | Arena for temporaries | Clean separation |
| All memory is equal | Scratch (arena) vs persistent (backing) | Different lifetimes |

### Key Insight

In Python, the GC eventually cleans up short-lived objects. In Zig, the arena gives you the same convenience — make as many allocations as you want, then free them all with one call. The difference: you choose *when* the cleanup happens.

## Common Mistakes

1. **Returning arena-allocated memory** — If you return data allocated from an arena, it becomes invalid when the arena is freed. Use the backing allocator for returned data.
2. **Calling `free()` on arena allocations** — Arena `free()` is a no-op. It doesn't reclaim memory until `deinit()` or `reset()`. This is by design.
3. **Forgetting `arena.deinit()`** — The backing allocator's memory leaks if you don't deinit the arena.
4. **Using one giant arena for everything** — Arenas work best for scoped, short-lived allocations. Long-lived data should use the backing allocator.

## Self-Check Questions

1. What problem does the arena allocator solve?
2. What happens to all arena allocations when you call `arena.deinit()`?
3. What does `arena.reset(.retain_capacity)` do differently from `arena.deinit()`?
4. In the two-allocator pattern, which allocator holds the result?
5. Why is it dangerous to return data allocated from an arena?

## Exercises

Practice these concepts in [Exercise 3.5](../exercises/05_arena/prompt.md).
