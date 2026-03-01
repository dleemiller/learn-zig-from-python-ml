# Exercise 3.8: Debugging Memory Issues

## Objective

Find and fix memory bugs in three provided functions. This is a **bug hunt** — the functions are complete but contain specific memory management errors.

## Requirements

Fix the memory bugs in these three functions:

1. **`leakyDouble`** — doubles each value in a new slice, but leaks a temporary buffer
2. **`riskyConcat`** — concatenates two slices, but doesn't clean up on error
3. **`processWithArena`** — uses an arena for scratch work, but returns data from the wrong allocator

## Bug Descriptions

### Bug 1: `leakyDouble(allocator, data) ![]i32`
- Allocates a temporary buffer, copies data into it, doubles each value
- Allocates a result buffer and copies the doubled values
- **Bug**: The temporary buffer is never freed
- **Fix**: Add proper cleanup for the temporary buffer

### Bug 2: `riskyConcat(allocator, a, b) ![]i32`
- Allocates result buffer for a + b
- Copies a into result
- Allocates a temporary buffer for processing b
- **Bug**: If the second allocation fails, the first allocation leaks
- **Fix**: Add error-path cleanup for the first allocation

### Bug 3: `processWithArena(backing, input) ![]i32`
- Creates an arena for scratch work
- Processes input in the arena
- **Bug**: Returns data allocated from the arena (use-after-free on return)
- **Fix**: Allocate the result from the backing allocator, not the arena

## Syntax Reference

- `defer allocator.free(slice)` — free temporary data at scope exit (Lesson 3.3)
- `errdefer allocator.free(slice)` — free on error only (Module 2, Lesson 3.3)
- `try backing.alloc(T, n)` — allocate from backing (Lesson 3.5)
- `@memcpy(dest, src)` — copy memory (Lesson 3.3)

## Concepts Tested

- Identifying memory leaks (missing `defer`)
- Identifying error-path leaks (missing `errdefer`)
- Identifying use-after-free (wrong allocator for returned data)
- Systematic debugging of memory issues

## Verification

```bash
zig test tests.zig
```
