# Module 1: Syntax Inventory

Cumulative list of all syntax the student can **recognize and produce** after completing Module 1. This serves as the prerequisite baseline for Module 2.

## Lesson 1.1 — Why Zig (Conceptual)

No new syntax to produce. Student reads motivational examples only.

## Lesson 1.2 — Environment Setup

No new syntax to produce. Student runs CLI commands only.

## Lesson 1.3 — Hello Zig

- **Introduced**
  - `const std = @import("std");` — importing the standard library
  - `pub fn main() void { }` — program entry point
  - `std.debug.print("...\n", .{});` — formatted debug output
  - `.{}` and `.{value1, value2}` — anonymous struct (tuple) for format args
  - Format specifiers: `{s}` (string), `{d}` (decimal int), `{any}` (debug)
  - `//` single-line comments, `///` doc comments
  - Semicolons to end statements
  - `\n`, `\t`, `\"`, `\\` — escape sequences

## Lesson 1.4 — Variables and Constants

- **Introduced**
  - `const x = 5;` — constant with inferred type
  - `const x: i32 = 5;` — constant with explicit type
  - `var counter: i32 = 0;` — mutable variable (requires explicit type)
  - `+=`, `-=`, `*=` — compound assignment operators
  - `undefined` — uninitialized value (dangerous, use with care)
  - Block scopes `{ }` with shadowing
  - `if (condition) value else value` — inline if-expression (preview)
  - camelCase naming convention for variables/constants

## Lesson 1.5 — Primitive Types

- **Introduced**
  - Integer types: `i8`, `i16`, `i32`, `i64`, `u8`, `u16`, `u32`, `u64`, `usize`
  - Float types: `f16`, `f32`, `f64`
  - `bool` with `true` / `false`
  - No truthy/falsy: conditions must be `bool` (e.g., `count != 0`)
  - `@as(TargetType, value)` — explicit type coercion
  - `@intCast(value)` — cast between integer types
  - `@intFromFloat(value)` — float to int (truncates)
  - `@floatFromInt(value)` — int to float
  - `@floatCast(value)` — cast between float precisions
  - `@TypeOf(x)`, `@sizeOf(Type)` — type introspection
  - Number literals: decimal, `0xFF` hex, `0o77` octal, `0b1010` binary
  - `1_000_000` — underscores in number literals
  - `1.5e10` — scientific notation

## Lesson 1.6 — Strings and Slices

- **Introduced**
  - `[]const u8` — string type (byte slice)
  - `.len` — slice/array length field
  - `str[0]` — byte indexing (returns `u8`)
  - `str[0..5]`, `str[7..]` — slicing with `..`
  - `std.mem.eql(u8, a, b)` — content comparison (not `==`)
  - `\\` multi-line string literals
  - `++` — compile-time string/array concatenation

## Lesson 1.7 — Arrays vs Slices

- **Introduced**
  - `[5]i32` — fixed-size array type (size is part of the type)
  - `[_]i32{ 1, 2, 3 }` — array with inferred size
  - `.{ 1, 2, 3, 4, 5 }` — array initializer syntax
  - `.{ 0 } ** 5` — repeat initializer
  - `&arr` — take a slice of an array
  - `[]const i32` / `[]i32` — slice types (for function parameters)
  - `arr[0..3]`, `arr[2..]` — subslicing
  - `@memcpy(&dst, &src)` — array copy
  - `[3][4]i32` — multi-dimensional arrays
  - `[:0]const u8` — sentinel-terminated slices (for C interop)

## Lesson 1.8 — Control Flow

- **Introduced**
  - `if (cond) { } else if (cond) { } else { }` — conditionals
  - `if (cond) value else value` — if as expression
  - `switch (x) { value => ..., 3, 4, 5 => ..., 6...10 => ..., else => ... }` — switch with values, multi-values, ranges
  - `for (slice) |item| { }` — for loop with capture
  - `for (slice, 0..) |item, idx| { }` — for with index
  - `for (a, b) |x, y| { }` — multi-slice iteration (zip)
  - `for (0..10) |i| { }` — range iteration
  - `for (&arr) |*item| { item.* *= 2; }` — mutable iteration with pointer capture
  - `while (cond) { }` — while loop
  - `while (cond) : (i += 1) { }` — while with continue expression
  - `break` and `continue`
  - `break value` — break with value from loop-expression
  - `blk: { break :blk value; }` — labeled blocks
  - `outer: for ... { break :outer; }` — labeled loops
  - `enum { red, green, blue }` — enum definition (shown in switch examples)

## Cumulative Summary — What the Student Can Produce After Module 1

| Category | Syntax |
|----------|--------|
| Imports | `@import("std")` |
| Functions | `pub fn main() void { }` (entry point only) |
| Variables | `const`, `var`, type annotations, `undefined` |
| Types | `i32`, `u8`, `f64`, `bool`, `usize`, etc. |
| Casts | `@as`, `@intCast`, `@floatFromInt`, `@intFromFloat`, `@floatCast` |
| Strings | `[]const u8`, `.len`, indexing, slicing, `std.mem.eql` |
| Arrays | `[N]T`, `[_]T{...}`, `&arr`, `[]const T` slices |
| Control flow | `if`/`else`, `switch`, `for`, `while`, `break`, `continue` |
| Output | `std.debug.print` with format specifiers |
| Operators | `+`, `-`, `*`, `/`, `%`, `==`, `!=`, `<`, `>`, `<=`, `>=` |
