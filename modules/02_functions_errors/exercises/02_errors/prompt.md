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

## Syntax Reference

These are needed for this exercise. If any are unfamiliar, review the "Boolean Operators and Character Arithmetic" section at the end of Lesson 2.2.

- `and` — boolean AND keyword (e.g., `c >= '0' and c <= '9'`), used for range checks
- Character arithmetic: `c - '0'` — converts a digit character to its numeric value (Lesson 2.2)
- `@as(i32, u8_value)` — widen a `u8` to `i32` for mixed-type arithmetic (Module 1, Lesson 1.5)
- `@divTrunc(a, b)` — truncated integer division (Lesson 2.1)

## Concepts Tested

- Error unions (`!T`)
- Returning errors
- Using `try` to propagate
- Using `catch` to handle

## Verification

```bash
zig build test-ex-02-02
```
