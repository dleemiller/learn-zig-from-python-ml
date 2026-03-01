# Exercise 2.6: Comptime Basics

## Objective

Practice the core comptime concepts: generic type parameters, functions that return types, type introspection with `@typeInfo`, and compile-time evaluation with labeled blocks.

## Requirements

### Part 1: `max` (warm-up)
1. Implement the generic `max` function
2. It takes a comptime type parameter `T` and two values of type `T`
3. Return the larger of the two values

### Part 2: `Pair` (function returning a type)
4. Fix the `Pair` function so it returns a struct type that actually uses `T`
5. The returned struct should have two fields: `first: T` and `second: T`
6. Currently it hardcodes `u8` — make it generic

### Part 3: `isNumeric` (type introspection)
7. Implement `isNumeric` using `@typeInfo`
8. Return `true` for integer types (`i32`, `u8`, etc.) and float types (`f32`, `f64`, etc.)
9. Return `false` for everything else (`bool`, `[]const u8`, etc.)

### Part 4: `comptime_factorial` (compile-time evaluation)
10. Replace the placeholder `0` with a labeled block that computes 10! at compile time
11. Use a labeled block (`blk: { ... break :blk result; }`) with a loop
12. The result should be 3628800

## Syntax Reference

These concepts are needed. If unfamiliar, review the referenced lesson:

- `comptime T: type` — type parameter for generic functions (Lesson 2.6)
- `fn f(comptime T: type) type { return struct { ... }; }` — returning a type from a function (Lesson 2.6)
- `@typeInfo(T)` — type introspection, returns a tagged union (Lesson 2.6)
- `switch (@typeInfo(T)) { .int => ..., else => ... }` — matching on type info variants (Lesson 2.6)
- `blk: { ... break :blk value; }` — labeled blocks (Module 1)
- `for (1..11) |i| { }` — range-based for loop (Module 1)

## Concepts Tested

- `comptime T: type` — type parameters for generic functions
- Functions that return types
- `@typeInfo(T)` — type introspection with switch
- Labeled blocks with compile-time loops

## Verification

```bash
zig test tests.zig
```
