# Exercise 1.8: Simple Calculator

## Objective

Build a simple calculator that performs basic arithmetic operations, putting together everything from Module 1.

## Requirements

Implement a `calculate` function that:
1. Takes two numbers (f64) and an operator (u8 character)
2. Supports: '+', '-', '*', '/'
3. Returns the result

## Expected Output

```
10.0 + 5.0 = 15.0
10.0 - 5.0 = 5.0
10.0 * 5.0 = 50.0
10.0 / 5.0 = 2.0
```

## Concepts Tested

- Functions (preview of Module 2, but keep it simple)
- Switch on character values
- Floating-point arithmetic
- Type conversions

## Implementation Notes

- Use switch to handle different operators
- For division by zero, you can return 0 or a special value (we'll handle errors properly in Module 2)
- The function signature is provided in the starter

## Verification

```bash
zig build test-ex-01-08
```
