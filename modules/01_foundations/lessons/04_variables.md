# Lesson 1.4: Variables and Constants

## Learning Objectives

- [ ] Declare variables with `var`
- [ ] Declare constants with `const`
- [ ] Understand type inference vs explicit types
- [ ] Know when to use `var` vs `const`
- [ ] Understand `undefined` and initialization

## Prerequisites

- Completed Lesson 1.3
- Can write and run basic Zig programs

## Constants with `const`

Most values in Zig are constants:

```zig
const x = 5;              // Type inferred as comptime_int
const y: i32 = 5;         // Explicit type: i32
const name = "Alice";     // Type: []const u8 (string slice)
const pi: f64 = 3.14159;  // Explicit float type
```

Constants:
- Cannot be reassigned
- Value known at compile time (usually)
- Preferred in Zig - use by default

### Attempting to Modify a Constant

```zig
const x = 5;
x = 10;  // Compile error: cannot assign to constant
```

## Variables with `var`

Use `var` when you need to modify a value:

```zig
var counter: i32 = 0;
counter = counter + 1;  // OK
counter += 1;           // Also OK

var name: []const u8 = "Alice";
name = "Bob";           // OK - reassigning the slice
```

Variables:
- Can be reassigned
- Must have explicit type OR be initialized
- Use only when needed

## Type Inference

Zig infers types when possible:

```zig
const x = 5;           // comptime_int (special compile-time type)
const y = 5.0;         // comptime_float
const z: i32 = 5;      // Explicit: i32

var a = 5;             // Error! Variables need type or initializer that gives type
var b: i32 = 5;        // OK
var c: i32 = x;        // OK - x coerces to i32
```

### Why Explicit Types for Variables?

```zig
var x = 5;  // What type? i8? i32? u64?
```

Without context, Zig doesn't know what integer size you want. Be explicit:

```zig
var x: i32 = 5;  // Clear: 32-bit signed integer
```

## The `undefined` Value

Sometimes you want to declare without initializing:

```zig
var buffer: [100]u8 = undefined;
// buffer contents are undefined - reading before writing is illegal
```

**Warning**: Using `undefined` values before initialization is undefined behavior!

```zig
var x: i32 = undefined;
const y = x + 1;  // UNDEFINED BEHAVIOR - x was never set
```

Use `undefined` only when you're certain you'll write before reading.

## Shadowing

You can redeclare a name in an inner scope:

```zig
const x: i32 = 5;
{
    const x: i32 = 10;  // Shadows outer x
    std.debug.print("{d}\n", .{x});  // Prints 10
}
std.debug.print("{d}\n", .{x});  // Prints 5
```

But you cannot shadow in the same scope:

```zig
const x = 5;
const x = 10;  // Error: redefinition
```

## Naming Conventions

```zig
// Variables and constants: camelCase
const maxValue: i32 = 100;
var currentIndex: usize = 0;

// Types: PascalCase
const MyStruct = struct { ... };

// Constants that are truly constant: still camelCase
const maxBufferSize = 1024;

// Avoid: ALL_CAPS (used in C, not Zig style)
```

## For Python Developers

| Python | Zig | Notes |
|--------|-----|-------|
| `x = 5` | `var x: i32 = 5;` | Mutable variable |
| `x = 5` | `const x = 5;` | Immutable (most cases) |
| `PI = 3.14` | `const PI = 3.14;` | Actually immutable in Zig |
| `x: int = 5` | `const x: i32 = 5;` | Type annotation syntax differs |

Key differences:
1. **Zig distinguishes `var`/`const`** - Python relies on convention
2. **Explicit mutability** - You must choose
3. **Types are explicit or inferred** - No duck typing
4. **Semicolons required** - Every statement ends with `;`

## Comptime Values

Zig has compile-time computation:

```zig
const x = 5;          // This is a comptime value
const y = x * 2;      // Computed at compile time (y = 10)
const z = x + y;      // Also compile time (z = 15)
```

Variables can't be comptime:

```zig
var runtime_value: i32 = 5;
const sum = runtime_value + 5;  // Error: runtime_value not comptime known
```

We'll explore comptime deeply in Module 2.

## Common Patterns

### Swapping Values

```zig
var a: i32 = 1;
var b: i32 = 2;

const temp = a;
a = b;
b = temp;
```

### Accumulating

```zig
var sum: i32 = 0;
sum += 10;
sum += 20;
// sum is now 30
```

### Conditional Assignment

```zig
const max_size = 1024;
var actual_size: usize = undefined;

if (condition) {
    actual_size = max_size;
} else {
    actual_size = max_size / 2;
}
```

Or more idiomatically:

```zig
const actual_size: usize = if (condition) max_size else max_size / 2;
```

## Common Mistakes

### Using `var` when `const` works

```zig
// BAD - unnecessary mutability
var x: i32 = 5;
std.debug.print("{d}\n", .{x});

// GOOD - x never changes
const x: i32 = 5;
std.debug.print("{d}\n", .{x});
```

### Forgetting type annotation

```zig
// BAD - what type is this?
var count = 0;  // Error

// GOOD
var count: i32 = 0;
```

### Reading undefined

```zig
// BAD - undefined behavior
var x: i32 = undefined;
const y = x;  // Reading before writing!

// GOOD
var x: i32 = 0;  // Initialize properly
```

## Self-Check

1. When should you use `var` vs `const`?
2. Why must variables have explicit types?
3. What happens if you read an `undefined` variable?
4. Can you shadow a variable in Zig?

## Exercises

Complete Exercise 1.2: Variables in the exercises folder.

## Next Steps

Now that you understand variables, let's explore Zig's type system.

→ Continue to [Lesson 1.5: Primitive Types](05_types.md)
