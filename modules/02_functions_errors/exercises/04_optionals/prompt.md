# Exercise 2.4: Optionals

## Objective

Practice working with optional types (`?T`) safely.

## Requirements

1. Implement `findFirst` - find first element matching a condition, return optional
2. Implement `getWithDefault` - get optional value or return default
3. Implement `doubleOrZero` - if value is present, double it; otherwise return 0

## Expected Output

```
First even: 2
First > 100: (not found, using default 0)
Value: 84
No value: 0
```

## Concepts Tested

- Optional types `?T`
- `orelse` for defaults
- `if (opt) |val|` for safe unwrapping
- Distinguishing optionals from error unions

## Verification

```bash
zig build test-ex-02-04
```
