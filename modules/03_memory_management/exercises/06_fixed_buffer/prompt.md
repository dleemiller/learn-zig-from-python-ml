# Exercise 3.6: FixedBufferAllocator

## Objective

Practice allocating from a pre-existing buffer (no heap), and handling the `OutOfMemory` error when the buffer is too small.

## Requirements

1. Implement `countingArray` — allocate from a provided buffer and fill with counting values
2. Implement `concatInBuffer` — concatenate two slices using only buffer-backed allocation

## Details

### `countingArray(buffer, n) ![]i32`
- Create a `FixedBufferAllocator` from the provided buffer
- Allocate `n` i32 values from it
- Fill with counting values: `{0, 1, 2, ..., n-1}`
- Return the slice
- If the buffer is too small, return `error.OutOfMemory`

### `concatInBuffer(buffer, a, b) ![]i32`
- Create a `FixedBufferAllocator` from the provided buffer
- Allocate space for `a.len + b.len` items
- Copy `a` then `b` into the allocation
- Return the result
- If the buffer is too small, return `error.OutOfMemory`

## Syntax Reference

- `std.heap.FixedBufferAllocator.init(buf)` — create FBA from buffer (Lesson 3.6)
- `fba.allocator()` — get allocator interface (Lesson 3.6)
- `try allocator.alloc(T, n)` — allocate (Lesson 3.3)
- `@memcpy(dest, src)` — copy memory (Lesson 3.3)
- `@intCast(value)` — integer cast (Module 1)

## Concepts Tested

- FixedBufferAllocator creation and usage
- Same allocator interface, different backing
- Handling `error.OutOfMemory` from bounded allocation
- No-heap allocation patterns

## Verification

```bash
zig test tests.zig
```
