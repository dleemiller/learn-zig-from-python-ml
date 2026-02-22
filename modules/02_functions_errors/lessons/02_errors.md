# Lesson 2.2: Error Unions

## Learning Objectives

- [ ] Understand error unions (`!T`)
- [ ] Define custom error sets
- [ ] Use `try` to propagate errors
- [ ] Use `catch` to handle errors

## Prerequisites

- Completed Lesson 2.1
- Understand functions and return types

## The Problem

In Python, functions can raise exceptions at any time:

```python
def divide(a, b):
    return a / b  # Might raise ZeroDivisionError!

result = divide(10, 0)  # Crashes if not in try/except
```

Zig makes errors explicit in the type system.

## Error Unions

An error union `!T` means "either an error OR a value of type T":

```zig
fn divide(a: f64, b: f64) !f64 {
    if (b == 0) {
        return error.DivisionByZero;
    }
    return a / b;
}
```

The `!` before the return type indicates this function can fail.

## Error Sets

Errors are defined in error sets:

```zig
const MathError = error{
    DivisionByZero,
    Overflow,
    InvalidInput,
};

fn divide(a: f64, b: f64) MathError!f64 {
    if (b == 0) {
        return error.DivisionByZero;
    }
    return a / b;
}
```

If you just use `!T`, Zig infers the error set from the function body.

## Using `try`

`try` propagates errors to the caller:

```zig
fn calculate(a: f64, b: f64) !f64 {
    const result = try divide(a, b);  // Returns error if divide fails
    return result * 2;
}
```

`try x` is shorthand for:
```zig
x catch |err| return err;
```

## Using `catch`

`catch` handles errors locally:

```zig
pub fn main() void {
    const result = divide(10, 0) catch |err| {
        std.debug.print("Error: {}\n", .{err});
        return;
    };
    std.debug.print("Result: {d}\n", .{result});
}
```

### Catch with Default Value

```zig
const result = divide(10, 0) catch 0;  // Use 0 if error
```

### Catch with Unreachable

If you're certain an error won't occur:

```zig
const result = divide(10, 2) catch unreachable;  // Panics if error occurs
```

Use sparingly - only when you can prove no error is possible.

## Returning from Catch

```zig
fn safeDivide(a: f64, b: f64) f64 {
    return divide(a, b) catch {
        return 0;  // Return from safeDivide, not just catch
    };
}
```

## Error Payloads

Capture the error value with `|err|`:

```zig
const result = divide(10, 0) catch |err| {
    switch (err) {
        error.DivisionByZero => std.debug.print("Can't divide by zero\n", .{}),
        else => std.debug.print("Unknown error\n", .{}),
    }
    return;
};
```

## Combining Error Sets

```zig
const FileError = error{ NotFound, PermissionDenied };
const ParseError = error{ InvalidFormat, UnexpectedEof };

// Function can return either
fn loadAndParse(path: []const u8) (FileError || ParseError)!Data {
    // ...
}
```

## The `anyerror` Type

`anyerror` matches any error:

```zig
fn handleAny(err: anyerror) void {
    std.debug.print("Got error: {}\n", .{err});
}
```

## For Python Developers

| Python | Zig |
|--------|-----|
| `raise ValueError` | `return error.ValueError` |
| `try: ... except:` | `catch` |
| Exception bubbles up | Must use `try` to propagate |
| `except Exception as e:` | `catch \|err\|` |
| No indication in signature | `!T` shows function can fail |

### Key Difference

Python:
```python
def process():
    data = load_file()  # Might raise, caller doesn't know
    return transform(data)
```

Zig:
```zig
fn process() !Data {
    const data = try loadFile();  // Explicit: this can fail
    return transform(data);
}
```

## Standard Library Errors

Many std functions return errors:

```zig
const file = std.fs.cwd().openFile("data.txt", .{}) catch |err| {
    std.debug.print("Failed to open: {}\n", .{err});
    return;
};
```

## Common Mistakes

### Ignoring Errors

```zig
divide(10, 0);  // Error! Must handle the error union
```

### Forgetting `try` in Error-Returning Function

```zig
fn process() !i32 {
    const x = divide(10, 2);  // Error! x is !f64, not f64
    return @intFromFloat(x);
}

// Correct:
fn process() !i32 {
    const x = try divide(10, 2);  // Now x is f64
    return @intFromFloat(x);
}
```

## Boolean Operators and Character Arithmetic

Before tackling the exercise, you'll need two pieces of syntax that haven't appeared yet in this course.

### Boolean Operators: `and`, `or`, `!`

Zig uses keywords for boolean logic, not symbols like Python's `and`/`or` or C's `&&`/`||`:

```zig
const in_range = x >= 0 and x <= 100;  // both conditions must be true
const either = a or b;                  // at least one must be true
const negated = !is_valid;              // flip a bool
```

These short-circuit just like Python's: `and` stops if the left side is false, `or` stops if the left side is true.

### Character Arithmetic

Characters in Zig are just `u8` values (their ASCII code). You can do arithmetic on them:

```zig
const c: u8 = '7';
const digit = c - '0';  // '7' is 55, '0' is 48, so digit = 7
```

This is a standard pattern for converting a digit character to its numeric value. It works because `'0'` through `'9'` are consecutive in ASCII (48–57).

### Widening with `@as`

When you have a `u8` value but need to use it in `i32` arithmetic, widen it with `@as`:

```zig
const small: u8 = 5;
const big: i32 = @as(i32, small) + 10;  // u8 → i32, then add
```

## Self-Check

1. What does `!T` mean as a return type?
2. What does `try` do?
3. How do you provide a default value when an error occurs?
4. How do you access the actual error value in a catch?

## Exercises

Complete Exercise 2.2: Errors
