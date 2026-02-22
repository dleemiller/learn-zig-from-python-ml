# Exercise 2.3: Defer and Errdefer

## Objective

Practice using defer and errdefer for resource cleanup.

## Requirements

1. Implement `Counter` struct with proper cleanup tracking
2. Use defer to ensure cleanup happens
3. Use errdefer for partial initialization cleanup
4. Understand LIFO ordering

## Expected Output

```
Creating counter...
Counter value: 5
Cleanup called
Partial init: Cleanup called
LIFO order: 3, 2, 1
```

## Note on Pointers

The `Counter` struct in the starter code uses pointers (`*bool`, `*Counter`). Pointers are a Module 3 topic — the pointer code is pre-written for you. **You do not need to modify the Counter struct or understand pointer syntax to complete this exercise.** Focus only on adding `defer` and `errdefer` lines.

## Concepts Tested

- defer for guaranteed cleanup
- errdefer for error-path cleanup
- LIFO ordering of multiple defers
- Resource management patterns

## Verification

```bash
zig build test-ex-02-03
```
