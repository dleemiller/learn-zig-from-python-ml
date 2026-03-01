# Exercise 3.5: ArenaAllocator

## Objective

Practice arena allocation for batch processing and the two-allocator pattern (arena for scratch work, backing allocator for results).

## Requirements

1. Implement `batchProcess` — allocate multiple buffers, sum their sizes, free all at once with arena
2. Implement `doubleValues` — use an arena for scratch computation, return the result from the backing allocator

## Details

### `batchProcess(backing, sizes) !u64`
- Create an arena backed by `backing`
- For each size in `sizes`, allocate that many `i32`s from the arena
- Fill each allocation with the value 1 using `@memset`
- Sum all elements across all allocations
- Return the total sum (which equals the sum of all sizes)
- Arena `deinit` handles all cleanup

### `doubleValues(backing, input) ![]i32`
- Create an arena backed by `backing`
- Use the arena to allocate scratch space (copy of input)
- Double each value in the scratch space
- Allocate the result from the **backing** allocator (not the arena!)
- Copy the doubled values into the result
- Return the result (caller owns this memory, allocated from backing)

## Syntax Reference

- `std.heap.ArenaAllocator.init(backing)` — create an arena (Lesson 3.5)
- `defer arena.deinit();` — free all arena memory (Lesson 3.5)
- `arena.allocator()` — get allocator interface (Lesson 3.5)
- `try allocator.alloc(T, n)` — allocate (Lesson 3.3)
- `@memset(slice, value)` — fill memory (Lesson 3.3)
- `@memcpy(dest, src)` — copy memory (Lesson 3.3)
- `@intCast(value)` — integer type conversion (Module 1)
- `errdefer allocator.free(slice)` — error cleanup (Module 2)

## Concepts Tested

- Arena allocator creation and bulk deallocation
- "Allocate many, free all at once" pattern
- Two-allocator pattern: scratch (arena) vs result (backing)
- Correct allocator choice for returned memory

## Verification

```bash
zig test tests.zig
```
