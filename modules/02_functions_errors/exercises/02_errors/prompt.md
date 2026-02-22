# Exercise 2.2: Error Handling

## Objective

Practice Zig's error handling with error unions, try, and catch.

## Requirements

1. Implement `safeDivide` - divides two numbers, returns error on divide by zero
2. Implement `parseDigit` - converts a character to its numeric value (0-9), returns error for non-digits
3. Implement `processValue` - chains together multiple fallible operations using `try`

## Expected Output

```
10 / 2 = 5
10 / 0 = Error: DivisionByZero
parseDigit('5') = 5
parseDigit('x') = Error: InvalidDigit
Processed: 14
```

## Concepts Tested

- Error unions (`!T`)
- Returning errors
- Using `try` to propagate
- Using `catch` to handle

## Verification

```bash
zig build test-ex-02-02
```
