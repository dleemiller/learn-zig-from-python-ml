# Exercise 2.6: Comptime Basics

## Objective

Practice basic comptime concepts: compile-time evaluation and type parameters.

## Requirements

1. Understand comptime constants
2. Write a generic function using `comptime T: type`
3. Recognize comptime patterns in existing code

## Expected Output

```
Comptime sum: 55
Max i32: 42
Max f64: 3.14
Array size: 10
```

## Concepts Tested

- Comptime evaluation
- Type parameters (`comptime T: type`)
- Comptime array sizes
- Generic functions

## Verification

```bash
zig build test-ex-02-06
```
