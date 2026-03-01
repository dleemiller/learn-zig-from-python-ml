# Exercise 3.2: Pointers

## Objective

Practice using pointers for mutation, in-place modification of slices, and returning pointers into existing data.

## Requirements

1. Implement `swap` — swap the values of two `*i32` pointers
2. Implement `addToAll` — add a delta to every element of a mutable slice
3. Implement `maxElement` — return a pointer to the maximum element in a mutable slice

## Details

### `swap(a: *i32, b: *i32) void`
- Swap the values pointed to by `a` and `b`
- After the call, `a.*` should hold the old value of `b.*` and vice versa

### `addToAll(values: []i32, delta: i32) void`
- Add `delta` to every element in the slice, modifying them in place

### `maxElement(values: []i32) *i32`
- Return a pointer to the largest element in the slice
- The returned pointer points into the original slice data
- You may assume the slice is non-empty

## Syntax Reference

- `*i32` — mutable pointer type (Lesson 3.2)
- `ptr.*` — dereference a pointer (Lesson 3.2)
- `&variable` — take address of a variable (Lesson 3.2)
- `for (slice) |*item| { }` — iterate with pointer capture for mutation (Lesson 3.2)

## Concepts Tested

- Pointer dereferencing with `.*`
- Mutation through pointers
- Mutable slice parameters
- Returning pointers into existing data

## Verification

```bash
zig test tests.zig
```
