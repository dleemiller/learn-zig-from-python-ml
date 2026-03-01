# Lesson 3.4: GeneralPurposeAllocator

## Learning Objectives

- [ ] Create and use a `GeneralPurposeAllocator`
- [ ] Use `gpa.deinit()` for leak detection
- [ ] Build resource-owning structs with `init`/`deinit` methods
- [ ] Apply `errdefer` for partial initialization cleanup
- [ ] Understand GPA's safety features

## Prerequisites

- Completed Lesson 3.3 (allocator interface, alloc/free)
- Comfortable with `defer` and `errdefer`
- Understand structs from Module 2

## From Interface to Implementation

In Lesson 3.3, you used `std.mem.Allocator` — the **interface**. But where does an allocator actually come from?

The `GeneralPurposeAllocator` (GPA) is Zig's general-purpose heap allocator. It's the closest thing to Python's memory manager — suitable for most tasks.

## Creating a GPA

```zig
const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const check = gpa.deinit();
        if (check == .leak) {
            std.debug.print("Memory leak detected!\n", .{});
        }
    }

    const allocator = gpa.allocator();

    // Now use allocator.alloc(), allocator.free(), etc.
    const data = try allocator.alloc(u8, 100);
    defer allocator.free(data);
}
```

Breaking this down:
- `GeneralPurposeAllocator(.{}){}` — create with default config
- `gpa.allocator()` — get the `std.mem.Allocator` interface
- `gpa.deinit()` — returns `.ok` or `.leak`

## Leak Detection Built In

The most valuable feature of GPA: it tells you about leaks when you call `deinit()`.

```zig
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const check = gpa.deinit();
        if (check == .leak) {
            std.debug.print("LEAK!\n", .{});
        }
    }

    const allocator = gpa.allocator();

    const data = try allocator.alloc(u8, 100);
    // Oops — forgot allocator.free(data)!
    _ = data;
}
// At deinit: "LEAK!" — GPA detected the unfree'd allocation
```

This is like Python's `tracemalloc`, but built into the allocator itself.

## GPA Safety Features

GPA catches common memory bugs in debug/safe builds:

1. **Leak detection** — `deinit()` reports unfree'd memory
2. **Double-free detection** — freeing the same memory twice is caught
3. **Use-after-free detection** — memory is poisoned after free

These safety checks only run in debug mode. Release builds are fast.

## Resource-Owning Structs

As your programs get more complex, you'll create **structs that own memory**. The pattern is:

```zig
const Buffer = struct {
    data: []u8,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, size: usize) !Buffer {
        const data = try allocator.alloc(u8, size);
        @memset(data, 0);
        return .{
            .data = data,
            .allocator = allocator,
        };
    }

    pub fn deinit(self: *Buffer) void {
        self.allocator.free(self.data);
    }

    pub fn len(self: Buffer) usize {
        return self.data.len;
    }
};
```

Usage:

```zig
var buf = try Buffer.init(allocator, 1024);
defer buf.deinit();

// Use buf.data[0..buf.len()]...
```

This is the Zig equivalent of a Python class with `__init__` and `__del__`:

```python
class Buffer:
    def __init__(self, size):
        self.data = bytearray(size)   # GC handles cleanup

    # No need for __del__ — GC does it
```

In Zig, you always pair `init` with `deinit`.

## `errdefer` for Partial Initialization

When `init` allocates multiple things, some may succeed before one fails:

```zig
const TwoBuffers = struct {
    first: []u8,
    second: []u8,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, size: usize) !TwoBuffers {
        const first = try allocator.alloc(u8, size);
        errdefer allocator.free(first);   // Free first if second fails

        const second = try allocator.alloc(u8, size);
        // No errdefer needed for second — if we got here, both succeeded

        return .{
            .first = first,
            .second = second,
            .allocator = allocator,
        };
    }

    pub fn deinit(self: *TwoBuffers) void {
        self.allocator.free(self.first);
        self.allocator.free(self.second);
    }
};
```

Without `errdefer`: if the second `alloc` fails, the first allocation leaks. With `errdefer`: it's automatically freed on the error path.

## Multi-Statement `defer` Blocks

Sometimes you need multiple statements in a `defer`:

```zig
defer {
    const check = gpa.deinit();
    if (check == .leak) {
        std.debug.print("Memory leak detected!\n", .{});
    }
}
```

The braces `{ ... }` let you put any number of statements in a single `defer`.

## For Python Developers

| Python | Zig | Notes |
|--------|-----|-------|
| `tracemalloc.start()` | GPA is always tracking | No opt-in needed |
| `tracemalloc.get_traced_memory()` | `gpa.deinit()` | Check at shutdown |
| `class Foo: def __init__` | `pub fn init(...) !Foo` | Can fail explicitly |
| GC calls `__del__` eventually | `defer buf.deinit()` | Deterministic cleanup |
| Memory profiler (pip install) | GPA built-in leak detection | No extra tools |

### Key Insight

Python's GC means you never see leaks (usually). Zig's GPA means you see leaks **immediately** — which is actually better. You find and fix bugs during development, not in production.

## Common Mistakes

1. **Forgetting `gpa.deinit()`** — Without it, you lose leak detection. Always `defer` it.
2. **Not checking the `deinit()` result** — `deinit()` returns `.ok` or `.leak`. Check it!
3. **Using the allocator after `deinit()`** — After `gpa.deinit()`, the allocator is invalid.
4. **Missing `errdefer` in multi-allocation init** — If the second allocation fails, the first leaks.
5. **Storing the allocator vs the GPA** — Store the `std.mem.Allocator` interface in structs, not the GPA itself.

## Self-Check Questions

1. What does `GeneralPurposeAllocator(.{}){}` create?
2. What does `gpa.deinit()` return and why should you check it?
3. Why do resource-owning structs need both `init` and `deinit`?
4. When do you use `errdefer` inside an `init` function?
5. What safety features does GPA provide in debug builds?

## Exercises

Practice these concepts in [Exercise 3.4](../exercises/04_gpa/prompt.md).
