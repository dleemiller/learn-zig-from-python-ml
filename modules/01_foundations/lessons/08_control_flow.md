# Lesson 1.8: Control Flow

## Learning Objectives

- [ ] Use `if`/`else` as expressions
- [ ] Master `switch` for pattern matching
- [ ] Use `for` loops with iterators
- [ ] Understand `while` loops and breaks
- [ ] Use labeled blocks and breaks

## Prerequisites

- Completed Lesson 1.7
- Understand basic Zig syntax

## If/Else

Basic conditional:

```zig
const x: i32 = 10;

if (x > 0) {
    std.debug.print("positive\n", .{});
} else if (x < 0) {
    std.debug.print("negative\n", .{});
} else {
    std.debug.print("zero\n", .{});
}
```

### If as Expression

Unlike Python, Zig's `if` can return a value:

```zig
const x: i32 = -5;
const abs_value = if (x < 0) -x else x;

const description: []const u8 = if (x > 0) "positive" else "non-positive";
```

This is like Python's ternary: `abs_value = -x if x < 0 else x`

### Conditions Must Be Bool

```zig
const count: i32 = 0;

if (count) { }  // Error! Expected bool, got i32

// Correct:
if (count != 0) { }
if (count > 0) { }
```

No truthy/falsy in Zig.

## Switch

Pattern matching that's exhaustive:

```zig
const x: i32 = 5;

const result = switch (x) {
    1 => "one",
    2 => "two",
    3, 4, 5 => "three to five",  // Multiple values
    6...10 => "six to ten",       // Range
    else => "other",
};
```

### Switch Must Be Exhaustive

```zig
const value: u8 = 100;

// Error: switch must handle all 256 possible u8 values
const name = switch (value) {
    0 => "zero",
    1 => "one",
    // Missing: 2-255!
};

// Fixed with else:
const name = switch (value) {
    0 => "zero",
    1 => "one",
    else => "other",
};
```

### Switch on Enums

```zig
const Color = enum { red, green, blue };
const c = Color.green;

const hex = switch (c) {
    .red => "#FF0000",
    .green => "#00FF00",
    .blue => "#0000FF",
    // No else needed - all cases covered!
};
```

### Capturing Values

```zig
const optional: ?i32 = 42;

switch (optional) {
    null => std.debug.print("no value\n", .{}),
    |value| => std.debug.print("value: {d}\n", .{value}),
}
```

## For Loops

### Iterating Slices

```zig
const numbers = [_]i32{ 1, 2, 3, 4, 5 };

for (numbers) |num| {
    std.debug.print("{d}\n", .{num});
}
```

### With Index

```zig
for (numbers, 0..) |num, idx| {
    std.debug.print("[{d}] = {d}\n", .{idx, num});
}
```

### Multiple Slices

```zig
const a = [_]i32{ 1, 2, 3 };
const b = [_]i32{ 10, 20, 30 };

for (a, b) |x, y| {
    std.debug.print("{d} + {d} = {d}\n", .{ x, y, x + y });
}
```

### Range Iteration

```zig
// 0 to 9
for (0..10) |i| {
    std.debug.print("{d}\n", .{i});
}
```

### Modifying During Iteration

For mutable slices, use pointer capture:

```zig
var numbers = [_]i32{ 1, 2, 3, 4, 5 };

for (&numbers) |*num| {
    num.* *= 2;  // Double each element
}
// numbers is now { 2, 4, 6, 8, 10 }
```

## While Loops

```zig
var i: i32 = 0;
while (i < 10) {
    std.debug.print("{d}\n", .{i});
    i += 1;
}
```

### While with Increment Clause

```zig
var i: i32 = 0;
while (i < 10) : (i += 1) {
    std.debug.print("{d}\n", .{i});
}
```

The expression after `:` runs **after each iteration**, before the next condition check. This is similar to C's `for` loop:

```c
// C equivalent
for (int i = 0; i < 10; i++) { ... }
```

The Zig docs call this a "continue expression" because it runs when the loop *continues* to the next iteration - not related to the `continue` keyword.

### While as Expression

```zig
fn indexOf(slice: []const i32, target: i32) ?usize {
    var i: usize = 0;
    return while (i < slice.len) : (i += 1) {
        if (slice[i] == target) break i;
    } else null;
}
```

## Break and Continue

### Break (Exit Loop)

```zig
for (0..100) |i| {
    if (i == 5) break;  // Exit when i is 5
    std.debug.print("{d}\n", .{i});
}
// Prints 0, 1, 2, 3, 4
```

### Continue (Skip Iteration)

```zig
for (0..10) |i| {
    if (i % 2 == 0) continue;  // Skip even numbers
    std.debug.print("{d}\n", .{i});
}
// Prints 1, 3, 5, 7, 9
```

### Break with Value

```zig
const result = for (items) |item| {
    if (item == target) break item;
} else null;
```

## Labeled Blocks

For complex control flow:

```zig
const result = blk: {
    const a = calculateA();
    if (a == 0) break :blk 0;
    const b = calculateB();
    break :blk a + b;
};
```

### Labeled Loops

Break out of nested loops:

```zig
outer: for (0..10) |i| {
    for (0..10) |j| {
        if (i * j > 50) break :outer;  // Break outer loop
        std.debug.print("{d},{d}\n", .{ i, j });
    }
}
```

## For Python Developers

| Python | Zig | Notes |
|--------|-----|-------|
| `if x:` | `if (x)` | Parens required |
| `if x > 0:` | `if (x > 0) {` | Braces required |
| `x if cond else y` | `if (cond) x else y` | Same idea |
| `for i in range(10):` | `for (0..10) \|i\|` | |
| `for x in list:` | `for (list) \|x\|` | |
| `for i, x in enumerate(list):` | `for (list, 0..) \|x, i\|` | |
| `while x < 10:` | `while (x < 10) {` | |
| `match x:` (3.10+) | `switch (x)` | More powerful |
| `break` | `break` | Can have value |
| `continue` | `continue` | Same |

### No `for i in range(start, stop, step)`

```zig
// Python: for i in range(0, 10, 2)
var i: usize = 0;
while (i < 10) : (i += 2) {
    std.debug.print("{d}\n", .{i});
}
```

## Common Patterns

### Find First Match

```zig
fn findFirst(slice: []const i32, predicate: fn(i32) bool) ?i32 {
    for (slice) |item| {
        if (predicate(item)) return item;
    }
    return null;
}
```

### Transform All

```zig
fn doubleAll(slice: []i32) void {
    for (slice) |*item| {
        item.* *= 2;
    }
}
```

### Zip and Process

```zig
fn dotProduct(a: []const f32, b: []const f32) f32 {
    var sum: f32 = 0;
    for (a, b) |x, y| {
        sum += x * y;
    }
    return sum;
}
```

## Common Mistakes

### Missing else in expression if
```zig
const x: i32 = 5;
const abs = if (x < 0) -x;  // Error! Missing else
```

### Non-exhaustive switch
```zig
const x: u8 = 100;
switch (x) {
    0 => {},
    1 => {},
}  // Error! Doesn't handle 2-255
```

### Modifying without pointer
```zig
var arr = [_]i32{ 1, 2, 3 };
for (arr) |x| {
    x *= 2;  // Error! x is a copy, not a reference
}

// Correct:
for (&arr) |*x| {
    x.* *= 2;
}
```

## Self-Check

1. How do you use `if` as an expression?
2. Why must `switch` be exhaustive?
3. How do you iterate with both index and value?
4. How do you modify array elements in a `for` loop?

## Exercises

Complete Exercise 1.6: Control Flow
Complete Exercise 1.7: FizzBuzz
Complete Exercise 1.8: Calculator

## Module Complete!

Congratulations! You've completed Module 1: Foundations. You now understand:
- Zig's value proposition for ML
- Variables, constants, and types
- Strings, arrays, and slices
- Control flow patterns

→ Continue to [Module 2: Functions, Errors, and Optionals](../02_functions_errors/README.md)
