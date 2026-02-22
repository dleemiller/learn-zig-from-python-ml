# Lesson 2.6: Comptime Basics

## Learning Objectives

- [ ] Understand what comptime means
- [ ] Use comptime for constant evaluation
- [ ] Recognize comptime in generic functions
- [ ] Know when comptime is useful (and when it's not)

## Prerequisites

- Completed Lesson 2.5
- Understand functions and types

## What is Comptime?

"Comptime" means "compile time" - code that runs during compilation, not at runtime.

In Python, everything runs at runtime. In Zig, some things can be computed while compiling:

```zig
const x = 5 + 3;  // Computed at compile time
// The binary contains 8, not "5 + 3"
```

This is already comptime - the compiler evaluates constant expressions.

## The `comptime` Keyword

Force evaluation at compile time:

```zig
comptime var sum: i32 = 0;
comptime {
    for (0..10) |i| {
        sum += i;
    }
}
// sum is 45, computed at compile time
```

## Comptime Parameters

This is where comptime gets powerful - type parameters:

```zig
fn Vector(comptime T: type, comptime size: usize) type {
    return struct {
        data: [size]T,

        fn zero() @This() {
            return .{ .data = [_]T{0} ** size };
        }
    };
}

const Vec3f = Vector(f32, 3);  // Creates a new type!
var v = Vec3f.zero();
```

The compiler generates a specialized type `Vec3f` with a `[3]f32` array.

## Why This Matters

In Python, you'd write:
```python
class Vector:
    def __init__(self, size, dtype):
        self.data = [0] * size  # Runtime allocation
```

In Zig, the size and type are known at compile time, so:
- No runtime overhead for type checking
- Array size is part of the type
- Compiler can optimize perfectly

## Generic Functions with `anytype`

You've seen this:

```zig
fn print(value: anytype) void {
    std.debug.print("{any}\n", .{value});
}
```

Under the hood, `anytype` triggers comptime specialization. The compiler generates different versions for different types.

## Comptime Conditionals

```zig
fn process(comptime T: type, value: T) void {
    if (T == i32) {
        // Integer-specific code
    } else if (T == f64) {
        // Float-specific code
    }
}
```

These branches are evaluated at compile time - only the relevant branch exists in the binary.

## Type Introspection

Query types at compile time:

```zig
fn isInteger(comptime T: type) bool {
    return switch (@typeInfo(T)) {
        .int => true,
        else => false,
    };
}

const check1 = isInteger(i32);   // true
const check2 = isInteger(f64);   // false
```

## Practical Example: Type-Safe Array Sum

```zig
fn sum(comptime T: type, items: []const T) T {
    var total: T = 0;
    for (items) |item| {
        total += item;
    }
    return total;
}

pub fn main() void {
    const ints = [_]i32{ 1, 2, 3, 4, 5 };
    const floats = [_]f64{ 1.5, 2.5, 3.5 };

    std.debug.print("{d}\n", .{sum(i32, &ints)});    // 15
    std.debug.print("{d}\n", .{sum(f64, &floats)});  // 7.5
}
```

## Comptime Strings

String manipulation at compile time:

```zig
fn fieldName(comptime prefix: []const u8, comptime name: []const u8) []const u8 {
    return prefix ++ "_" ++ name;
}

const name = fieldName("user", "id");  // "user_id" at compile time
```

## For Python Developers

| Python | Zig |
|--------|-----|
| Generics (`List[T]`) | `comptime T: type` |
| Runtime type checks | Compile-time specialization |
| Metaclasses | Comptime type generation |
| `eval()` at runtime | Comptime evaluation |

### Key Insight

Python's generics are hints; Zig's are real:

```python
# Python - T is just a hint
def first(items: List[T]) -> T:
    return items[0]
```

```zig
// Zig - T generates specialized code
fn first(comptime T: type, items: []const T) T {
    return items[0];
}
```

## What Can Run at Comptime?

- Arithmetic, logic, comparisons
- Loops (with comptime bounds)
- Function calls (if all inputs are comptime)
- Type construction

## What Cannot Run at Comptime?

- Anything requiring runtime state
- Reading files
- User input
- Anything with side effects on the system

## Don't Overuse Comptime

Comptime is powerful but:
- Can increase compile times
- Can increase binary size (multiple specializations)
- Can make code harder to read

Use it when:
- You need type-level programming
- You want zero-cost abstractions
- You're building reusable libraries

Don't use it just because you can.

## Common Mistakes

### Comptime vs Runtime Confusion

```zig
fn bad(n: usize) void {
    var arr: [n]i32 = undefined;  // Error! n is runtime, can't size array
}

fn good(comptime n: usize) void {
    var arr: [n]i32 = undefined;  // OK - n is comptime
}
```

### Expecting Runtime Values at Comptime

```zig
pub fn main() void {
    var x: i32 = getUserInput();
    comptime var y = x;  // Error! x is runtime
}
```

## Self-Check

1. What does "comptime" mean?
2. How is `anytype` related to comptime?
3. What's the benefit of computing values at compile time?
4. Can you read a file at comptime?

## Exercises

Complete Exercise 2.6: Comptime

## Module Complete!

You've completed Module 2! You now understand:
- Function parameters and return values
- Error unions and explicit error handling
- Defer/errdefer for resource cleanup
- Optional types for nullable values
- Tagged unions for type-safe variants
- Basic comptime for generic programming

→ Continue to [Module 3: Memory Management](../../03_memory/README.md)
