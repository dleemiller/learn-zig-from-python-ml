# Exercise 1.5: Arrays and Slices

## Objective

Practice working with arrays and slices, understanding the difference between them.

## Requirements

1. Create an array of integers
2. Create slices pointing to different parts of the array
3. Iterate over a slice and calculate the sum
4. Understand that modifying a mutable slice modifies the underlying array

## Expected Output

```
Array: { 1, 2, 3, 4, 5 }
Full slice sum: 15
Middle slice [1..4]: { 2, 3, 4 }
Middle sum: 9
After doubling: { 2, 4, 6, 8, 10 }
```

## Concepts Tested

- Array declaration
- Slice creation with `&` and `[start..end]`
- Iteration with for loops
- Mutable slice modification

## Verification

```bash
zig build test-ex-01-05
```
