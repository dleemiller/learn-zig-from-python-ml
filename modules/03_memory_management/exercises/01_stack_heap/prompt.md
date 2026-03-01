# Exercise 3.1: Stack & Heap Concepts

## Objective

Practice value semantics and stack lifetimes through simple functions that demonstrate how arrays are copied and slices are views.

## Requirements

1. Implement `stackLifetime` — return a computed value from stack variables
2. Implement `arrayOwnership` — return a modified array (demonstrates value semantics / copy on return)
3. Implement `sliceSum` — sum a slice of integers (demonstrates slices as views)

## Details

### `stackLifetime`
- Create a local variable `x` with value 42
- Create a local variable `y` with value `x + 8`
- Return `y` (which should be 50)

### `arrayOwnership`
- Create a local array `[5]i32` with values `{1, 2, 3, 4, 5}`
- Modify the first element to be 99
- Return the entire array (the caller gets a copy)

### `sliceSum`
- Take a `[]const i32` parameter
- Return the sum of all elements
- Return 0 for an empty slice

## Syntax Reference

- `[N]i32` — fixed-size array type (Module 1, Lesson 1.7)
- `[_]i32{...}` — array literal with inferred size (Module 1, Lesson 1.7)
- `[]const i32` — slice type (Module 1, Lesson 1.6)
- `for (slice) |item| { }` — iteration (Module 1, Lesson 1.8)

## Concepts Tested

- Stack variable lifetimes
- Value semantics: arrays are copied on return
- Slices as read-only views into data
- Basic function return values

## Verification

```bash
zig test tests.zig
```
