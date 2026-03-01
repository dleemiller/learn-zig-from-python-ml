# Lesson 3.3: The Allocator Interface

## Learning Objectives

- [ ] Understand what an allocator does and why Zig uses them
- [ ] Use `allocator.alloc()` and `allocator.free()` for slices
- [ ] Use `allocator.create()` and `allocator.destroy()` for single items
- [ ] Apply the `defer allocator.free()` cleanup pattern
- [ ] Understand the "caller owns returned memory" convention
- [ ] Use `@memset` to initialize allocated memory

## Prerequisites

- Completed Lesson 3.1 (understand when heap is needed)
- Completed Lesson 3.2 (understand pointers)
- Comfortable with `defer` and `errdefer` from Module 2

## Why Allocators?

In Python, `malloc` is hidden behind every object creation:

```python
data = [0] * 1000000  # Heap allocation — you never see it
```

In C, you call `malloc` directly:
```c
int* data = malloc(1000000 * sizeof(int));  // One global allocator
```

Zig takes a different approach: **the allocator is a parameter**. Functions that need heap memory receive an allocator from their caller:

```zig
fn createData(allocator: std.mem.Allocator, n: usize) ![]i32 {
    const data = try allocator.alloc(i32, n);
    @memset(data, 0);
    return data;
}
```

Why is this better?
- **Testability**: Pass a testing allocator that detects leaks
- **Flexibility**: Choose stack, heap, arena, or custom allocators
- **Transparency**: The function signature tells you it allocates
- **No global state**: No hidden dependency on a global malloc

## Allocating Slices: `alloc` and `free`

```zig
const std = @import("std");

fn example(allocator: std.mem.Allocator) !void {
    // Allocate 10 i32s on the heap
    const data = try allocator.alloc(i32, 10);
    defer allocator.free(data);   // Free when scope exits

    // Use the memory
    @memset(data, 0);         // Fill with zeros
    data[0] = 42;
    data[1] = 100;
}
```

Key points:
- `alloc` returns `![]T` — it can fail with `error.OutOfMemory`
- `free` takes the same slice that `alloc` returned
- `defer free` ensures cleanup even if the function returns early

## `@memset`: Initialize Memory

Allocated memory contains garbage (whatever was there before). Always initialize it:

```zig
const data = try allocator.alloc(i32, 5);
@memset(data, 0);     // All elements are now 0
```

Or fill with a specific value:

```zig
const ones = try allocator.alloc(f64, 100);
@memset(ones, 1.0);   // All elements are now 1.0
```

## Allocating Single Items: `create` and `destroy`

For a single value (not a slice):

```zig
const Point = struct {
    x: f64,
    y: f64,
};

fn makePoint(allocator: std.mem.Allocator) !*Point {
    const p = try allocator.create(Point);
    p.* = .{ .x = 1.0, .y = 2.0 };
    return p;
}

// Caller frees:
const p = try makePoint(allocator);
defer allocator.destroy(p);
```

- `create(T)` returns `!*T` — a pointer to a single heap-allocated item
- `destroy(ptr)` frees a single item

## The Cleanup Pattern: `defer` and `errdefer`

You learned `defer` and `errdefer` in Module 2. They're essential for memory management:

```zig
fn processData(allocator: std.mem.Allocator, n: usize) ![]i32 {
    const buffer = try allocator.alloc(i32, n);
    errdefer allocator.free(buffer);   // Free if we return an error

    // ... do work that might fail ...
    try validate(buffer);

    return buffer;   // Caller takes ownership — no free here
}
```

- `defer allocator.free(x)` — always free (for local scratch data)
- `errdefer allocator.free(x)` — free only on error (for data you'll return on success)

## Caller Owns Returned Memory

This is a critical convention in Zig:

> **If a function returns allocated memory, the caller is responsible for freeing it.**

```zig
// This function allocates — caller must free
fn duplicate(allocator: std.mem.Allocator, src: []const i32) ![]i32 {
    const copy = try allocator.alloc(i32, src.len);
    @memcpy(copy, src);
    return copy;   // Ownership transfers to caller
}

// Caller:
const copy = try duplicate(allocator, &original);
defer allocator.free(copy);   // Caller frees
```

This is like returning a `new`'d object in C++ — the caller must manage it.

## Two-Pass Pattern: Count Then Allocate

When you don't know the output size upfront, count first:

```zig
fn filterPositive(allocator: std.mem.Allocator, data: []const i32) ![]i32 {
    // Pass 1: count how many items match
    var count: usize = 0;
    for (data) |v| {
        if (v > 0) count += 1;
    }

    // Pass 2: allocate exact size and fill
    const result = try allocator.alloc(i32, count);
    errdefer allocator.free(result);

    var i: usize = 0;
    for (data) |v| {
        if (v > 0) {
            result[i] = v;
            i += 1;
        }
    }

    return result;
}
```

This avoids over-allocating. It's two passes through the data, but you get the exact size.

## For Python Developers

| Python | Zig | Notes |
|--------|-----|-------|
| `[0] * n` | `try allocator.alloc(i32, n)` | Explicit allocation |
| Automatic (GC) | `allocator.free(data)` | Explicit deallocation |
| No OOM in practice | `try` on every alloc | Allocation can fail |
| `del x` (GC hint) | `defer allocator.free(x)` | Deterministic cleanup |
| `copy.copy(x)` | `allocator.dupe(T, x)` | Explicit copy |
| `a + b` (list concat) | Manual: alloc + memcpy | You build it yourself |

### Key Insight

In Python, every `list()`, `dict()`, `str()` is a hidden heap allocation. In Zig, allocations are visible in the code. This means more typing, but you always know where memory comes from and when it's freed.

## Common Mistakes

1. **Forgetting to free** — Every `alloc` needs a matching `free`. Use `defer` immediately after allocating.
2. **Using `defer` instead of `errdefer`** — If you return the allocation to the caller, don't `defer free` it — the caller will free it. Use `errdefer` for the error path.
3. **Using freed memory** — After `free`, the slice is invalid. Don't read from it.
4. **Freeing the wrong slice** — Always free the exact slice returned by `alloc`, not a sub-slice.
5. **Forgetting `try` on `alloc`** — Allocation can fail. The compiler will catch this.

## Self-Check Questions

1. Why does Zig pass allocators as parameters instead of using a global allocator?
2. What's the difference between `alloc`/`free` and `create`/`destroy`?
3. When should you use `defer allocator.free()` vs `errdefer allocator.free()`?
4. What does `@memset(data, 0)` do?
5. In the "caller owns returned memory" pattern, who frees the allocation?

## Exercises

Practice these concepts in [Exercise 3.3](../exercises/03_allocator/prompt.md).
