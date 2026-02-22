# Exercise 1.3: Type Conversions

## Objective

Practice working with Zig's type system and explicit conversions.

## Requirements

1. Given an array index as `i32`, convert it to `usize` to access an array
2. Convert a temperature from Celsius (float) to Fahrenheit and truncate to integer
3. Handle a byte value (u8) and convert to i32 for arithmetic

## Expected Output

```
Array value at index 3: 40
25.5 C = 77 F
Byte 200 as signed: 200
```

## Concepts Tested

- Type conversion with @intCast, @floatFromInt, @intFromFloat
- Understanding when conversion is needed
- Choosing appropriate types

## Verification

```bash
zig build test-ex-01-03
```
