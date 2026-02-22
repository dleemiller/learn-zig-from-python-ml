# Lesson 2.1: Functions Deep Dive

## Learning Objectives

- [ ] Declare functions with typed parameters and return values
- [ ] Understand pass-by-value vs pass-by-reference
- [ ] Use `anytype` for generic parameters
- [ ] Return multiple values with structs

## Prerequisites

- Completed Module 1
- Understand basic types and control flow

## Function Basics

```zig
fn add(a: i32, b: i32) i32 {
    return a + b;
}

pub fn main() void {
    const result = add(3, 5);
    std.debug.print("{d}\n", .{result});  // 8
}
```

Key points:
- `fn` keyword declares a function
- Parameters require explicit types
- Return type comes after the parameter list
- `pub` makes a function visible outside the file

## Void Return Type

Functions that don't return a value use `void`:

```zig
fn greet(name: []const u8) void {
    std.debug.print("Hello, {s}!\n", .{name});
}
```

## Pass-by-Value

Zig passes arguments by value (copies them):

```zig
fn double(x: i32) i32 {
    return x * 2;  // x is a copy
}

pub fn main() void {
    var num: i32 = 5;
    const result = double(num);
    // num is still 5, result is 10
}
```

## Pass-by-Reference with Pointers

To modify the original value, pass a pointer:

```zig
fn doubleInPlace(x: *i32) void {
    x.* *= 2;  // Modify through pointer
}

pub fn main() void {
    var num: i32 = 5;
    doubleInPlace(&num);  // Pass address with &
    // num is now 10
}
```

We'll cover pointers in depth in Module 3.

## Const Parameters

Slice parameters are often `const` when you only read:

```zig
fn sumSlice(values: []const i32) i32 {
    var total: i32 = 0;
    for (values) |v| {
        total += v;
    }
    return total;
}
```

## Using `anytype`

For generic functions, use `anytype`:

```zig
fn debugPrint(value: anytype) void {
    std.debug.print("{any}\n", .{value});
}

pub fn main() void {
    debugPrint(42);        // Works with i32
    debugPrint(3.14);      // Works with f64
    debugPrint("hello");   // Works with string
}
```

The compiler generates specialized versions for each type used.

## Integer Division and Remainder

Python's `//` and `%` operators "just work" for integer division and modulus. In Zig, the standard `/` and `%` operators don't work on all integer types the way you might expect — Zig provides built-in functions instead:

```zig
const a: i32 = 17;
const b: i32 = 5;

const quotient = @divTrunc(a, b);  // 3 (truncates toward zero, like Python's int(17/5))
const remainder = @rem(a, b);      // 2 (remainder after truncated division)
```

- `@divTrunc(a, b)` — divides and truncates toward zero. This is what Python's `int(a/b)` does.
- `@rem(a, b)` — the remainder after `@divTrunc`. The sign follows the numerator.

Zig has these as built-ins because it offers multiple division behaviors (truncated, floored, exact) and makes you choose explicitly. For most cases, `@divTrunc` and `@rem` are what you want.

## Multiple Return Values

Zig doesn't have tuples, but you can return a struct:

```zig
const DivResult = struct {
    quotient: i32,
    remainder: i32,
};

fn divmod(a: i32, b: i32) DivResult {
    return .{
        .quotient = @divTrunc(a, b),
        .remainder = @rem(a, b),
    };
}

pub fn main() void {
    const result = divmod(17, 5);
    std.debug.print("{d} remainder {d}\n", .{ result.quotient, result.remainder });
    // 3 remainder 2
}
```

## Anonymous Struct Returns

You can also return an anonymous struct:

```zig
fn minMax(values: []const i32) struct { min: i32, max: i32 } {
    var min = values[0];
    var max = values[0];
    for (values[1..]) |v| {
        if (v < min) min = v;
        if (v > max) max = v;
    }
    return .{ .min = min, .max = max };
}
```

## For Python Developers

| Python | Zig |
|--------|-----|
| `def f(x):` | `fn f(x: i32) i32` |
| `def f(x=5):` | No default args (use overloads or comptime) |
| `*args` | Slices: `values: []const i32` |
| `**kwargs` | Not supported (use structs) |
| `return a, b` | Return a struct |
| Type hints optional | Types required |

## Common Mistakes

### Forgetting Return Type

```zig
fn add(a: i32, b: i32) {  // Error! Missing return type
    return a + b;
}
```

### Returning Local Pointer

```zig
fn bad() *i32 {
    var x: i32 = 42;
    return &x;  // Error! x is stack-allocated, gone after return
}
```

## Self-Check

1. What happens if you omit the return type on a function?
2. How do you modify a value passed to a function?
3. What is `anytype` used for?
4. How do you return multiple values?

## Exercises

Complete Exercise 2.1: Functions
