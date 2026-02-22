# Exercise 2.5: Unions and Enums

## Objective

Practice defining and using enums and tagged unions.

## Requirements

1. Define a `Shape` tagged union with circle, rectangle, triangle variants
2. Each variant holds shape-specific dimensions (radius, width/height, base/height)
3. Implement `calculateArea` using exhaustive switch
4. Use payload capture to access union data

## Expected Output

```
Circle area: 78.54
Rectangle area: 24.00
Triangle area: 6.00
```

## Concepts Tested

- Enum definition
- Tagged union with payloads
- Exhaustive switch
- Payload capture with `|value|`

## Verification

```bash
zig build test-ex-02-05
```
