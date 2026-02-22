# Exercise 2.1: Functions

## Objective

Practice writing functions with typed parameters and return values.

## Requirements

1. Implement `multiply` - takes two `i32` values, returns their product
2. Implement `isPositive` - takes an `i32`, returns `bool`
3. Implement `average` - takes a slice of `f64`, returns the average
4. Implement `divmod` - takes two `i32` values, returns quotient and remainder in a struct

## Expected Output

```
5 * 3 = 15
5 is positive: true
-3 is positive: false
Average: 3.0
17 / 5 = 3 remainder 2
```

## Concepts Tested

- Function declaration syntax
- Parameter types
- Return types
- Struct returns for multiple values

## Verification

```bash
zig build test-ex-02-01
```
