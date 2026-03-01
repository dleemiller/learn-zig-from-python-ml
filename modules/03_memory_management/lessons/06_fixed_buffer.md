# Lesson 3.6: FixedBufferAllocator

## Learning Objectives

- [ ] Allocate memory from a pre-existing stack buffer (no heap)
- [ ] Create and use a `FixedBufferAllocator`
- [ ] Handle `OutOfMemory` when the buffer is full
- [ ] Understand that the allocator interface works the same regardless of backing

## Prerequisites

- Completed Lesson 3.3 (allocator interface)
- Understand that `alloc` can return `error.OutOfMemory`
- Comfortable with stack-allocated arrays

## The No-Heap Allocator

Sometimes you don't want (or can't use) the heap:
- Embedded systems with no OS
- Hot paths where heap allocation is too slow
- Bounded scratch space where you know the maximum size

The `FixedBufferAllocator` (FBA) allocates from a buffer you provide — typically on the stack:

```zig
var buf: [4096]u8 = undefined;
var fba = std.heap.FixedBufferAllocator.init(&buf);
const allocator = fba.allocator();

// Allocations come from buf, not the heap
const data = try allocator.alloc(i32, 10);  // 40 bytes from buf
_ = data;
```

No heap, no GPA, no OS calls. Just carving up a buffer you already have.

## Creating an FBA

```zig
const std = @import("std");

pub fn main() !void {
    // Step 1: Provide the buffer (stack-allocated)
    var buffer: [1024]u8 = undefined;

    // Step 2: Create the FBA from that buffer
    var fba = std.heap.FixedBufferAllocator.init(&buffer);

    // Step 3: Get the standard allocator interface
    const allocator = fba.allocator();

    // Step 4: Use it like any other allocator
    const data = try allocator.alloc(u8, 100);
    @memset(data, 0);
    _ = data;
}
```

The magic: the allocator interface is **identical**. Code that takes `std.mem.Allocator` doesn't know or care whether it's backed by GPA, arena, or FBA. This is the power of the interface.

## What Happens When the Buffer Is Full?

```zig
var buf: [100]u8 = undefined;
var fba = std.heap.FixedBufferAllocator.init(&buf);
const allocator = fba.allocator();

const a = try allocator.alloc(u8, 80);   // OK — 80 bytes used
_ = a;
const b = allocator.alloc(u8, 50);        // Error! Only ~20 bytes left
// b is error.OutOfMemory
```

FBA can't grow. When the buffer is full, you get `error.OutOfMemory` — the same error any allocator can return. Your error handling code works the same way.

## Resetting an FBA

Like arenas, you can reset an FBA to reuse the buffer:

```zig
var buf: [1024]u8 = undefined;
var fba = std.heap.FixedBufferAllocator.init(&buf);
const allocator = fba.allocator();

// First use
const data1 = try allocator.alloc(i32, 100);
_ = data1;
// ... work with data1 ...

// Reset — all previous allocations are invalidated
fba.reset();

// Second use — full buffer available again
const data2 = try allocator.alloc(i32, 100);
_ = data2;
```

## FBA vs Arena vs GPA

| Feature | GPA | Arena | FBA |
|---------|-----|-------|-----|
| Memory source | OS heap | Backing allocator | Your buffer |
| Individual free | Yes | No-op | Limited |
| Bulk free | deinit | deinit / reset | reset |
| Grows | Yes | Yes (from backing) | No — fixed size |
| Leak detection | Yes | No | No |
| Best for | General use | Temp/scratch | Bounded, no-heap |

## The Allocator Interface Payoff

Here's the real insight. This function works with ANY allocator:

```zig
fn buildArray(allocator: std.mem.Allocator, n: usize) ![]i32 {
    const data = try allocator.alloc(i32, n);
    for (data, 0..) |*v, i| {
        v.* = @intCast(i);
    }
    return data;
}
```

You can call it with:
- `buildArray(gpa.allocator(), 100)` — heap allocation
- `buildArray(arena.allocator(), 100)` — arena allocation
- `buildArray(fba.allocator(), 100)` — stack buffer allocation

Same function, different strategies. The caller decides.

## For Python Developers

| Python | Zig | Notes |
|--------|-----|-------|
| `io.BytesIO(b'\x00' * 1024)` | `var buf: [1024]u8 = undefined;` | Pre-sized buffer |
| Always heap | FBA uses stack or static buffer | No heap needed |
| Never runs out of memory (practically) | `error.OutOfMemory` when buffer full | Bounded |
| No equivalent | Same `Allocator` interface for all | Polymorphism |

### Key Insight

Python always allocates from the heap — there's no way to say "use this pre-existing buffer." Zig's allocator interface lets you swap strategies without changing any of the code that uses the allocator.

## Common Mistakes

1. **Buffer too small** — Calculate how much space you need. Remember alignment can add padding.
2. **Using FBA data after reset** — Like arena reset, all prior allocations become invalid.
3. **Expecting FBA to grow** — It can't. If you might need more space, use an arena (which can grow from its backing allocator).
4. **Forgetting alignment overhead** — FBA respects alignment, so you may get slightly less usable space than the buffer size.

## Self-Check Questions

1. Where does FBA's memory come from?
2. What happens when you try to allocate more than the buffer can hold?
3. Why might you choose FBA over GPA?
4. If a function takes `std.mem.Allocator`, does it know whether it's backed by GPA, arena, or FBA?
5. What does `fba.reset()` do?

## Exercises

Practice these concepts in [Exercise 3.6](../exercises/06_fixed_buffer/prompt.md).
