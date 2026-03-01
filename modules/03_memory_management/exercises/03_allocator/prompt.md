# Exercise 3.3: Allocator Interface

## Objective

Practice heap allocation, the defer/free pattern, two-pass filtering, and slice concatenation using the `std.mem.Allocator` interface.

## Requirements

1. Implement `createFilled` — allocate a slice of `n` items, fill with `value`, return it
2. Implement `filterEvens` — return a new slice containing only even numbers from `data` (two-pass pattern)
3. Implement `concat` — concatenate two slices into a new allocated slice

## Details

### `createFilled(allocator, n, value) ![]i32`
- Allocate a slice of `n` i32 values
- Fill every element with `value`
- Return the slice (caller owns the memory)

### `filterEvens(allocator, data) ![]i32`
- Count how many elements in `data` are even
- Allocate a result slice of exactly that size
- Fill it with the even elements (preserving order)
- Return the result (caller owns the memory)

### `concat(allocator, a, b) ![]i32`
- Allocate a result slice of size `a.len + b.len`
- Copy `a` into the first part, `b` into the second part
- Return the result (caller owns the memory)

## Syntax Reference

- `try allocator.alloc(i32, n)` — allocate n items (Lesson 3.3)
- `allocator.free(slice)` — free allocated memory (Lesson 3.3)
- `@memset(slice, value)` — fill slice with a value (Lesson 3.3)
- `@memcpy(dest, src)` — copy memory between slices (Lesson 3.3)
- `errdefer allocator.free(slice)` — free on error (Module 2 + Lesson 3.3)
- `@intCast(value)` — integer type conversion (Module 1)
- `@rem(a, b)` — remainder for even check (Module 2)

## Concepts Tested

- Heap allocation with `alloc`/`free`
- "Caller owns returned memory" pattern
- Two-pass pattern (count then allocate)
- `errdefer` for error-path cleanup
- `@memset` and `@memcpy` usage

## Verification

```bash
zig test tests.zig
```
