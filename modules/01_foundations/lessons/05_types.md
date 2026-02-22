# Lesson 1.5: Primitive Types

## Learning Objectives

- [ ] Use Zig's integer types (`i32`, `u64`, etc.)
- [ ] Work with floating-point types (`f32`, `f64`)
- [ ] Understand explicit type coercion
- [ ] Know the difference between signed and unsigned

## Prerequisites

- Completed Lesson 1.4
- Understand `const` and `var`

## Integer Types

Unlike Python's arbitrary-precision `int`, Zig has fixed-size integers:

### Signed Integers (can be negative)

| Type | Size | Range |
|------|------|-------|
| `i8` | 8 bits | -128 to 127 |
| `i16` | 16 bits | -32,768 to 32,767 |
| `i32` | 32 bits | -2.1 billion to 2.1 billion |
| `i64` | 64 bits | -9.2 quintillion to 9.2 quintillion |
| `i128` | 128 bits | Very large |

### Unsigned Integers (positive only)

| Type | Size | Range |
|------|------|-------|
| `u8` | 8 bits | 0 to 255 |
| `u16` | 16 bits | 0 to 65,535 |
| `u32` | 32 bits | 0 to 4.3 billion |
| `u64` | 64 bits | 0 to 18 quintillion |
| `usize` | platform | Array indices, sizes |

```zig
const small: i8 = 100;
const medium: i32 = 100000;
const big: i64 = 10000000000;
const index: usize = 42;  // For array indexing
```

### Why `usize`?

`usize` matches your CPU's pointer size (32 or 64 bits). Use it for:
- Array indices
- Sizes and lengths
- Anything that interacts with memory addresses

```zig
const arr = [_]i32{ 10, 20, 30 };
const idx: usize = 1;
const value = arr[idx];  // Array index must be usize
```

## Floating-Point Types

| Type | Size | Precision | Use Case |
|------|------|-----------|----------|
| `f16` | 16 bits | ~3 digits | ML inference (half precision) |
| `f32` | 32 bits | ~7 digits | General ML, graphics |
| `f64` | 64 bits | ~15 digits | Scientific computing |

```zig
const pi: f64 = 3.14159265358979;
const weight: f32 = 0.5;  // Common for ML weights
```

### For ML Developers

You're used to:
- `np.float32` → `f32`
- `np.float64` → `f64`
- `torch.float16` → `f16`

Zig also has `f128` and architecture-specific types for advanced use.

## Boolean Type

```zig
const is_ready: bool = true;
const has_error: bool = false;

// In conditions
if (is_ready) {
    // ...
}
```

Unlike Python, there's no truthy/falsy:
```zig
const count: i32 = 0;
if (count) { }  // Error! Must be bool

// Correct:
if (count != 0) { }
```

## Type Coercion: Explicit Always

Zig does NOT convert types implicitly:

```zig
const a: i32 = 5;
const b: i64 = a;  // Error! Types don't match

// Must be explicit:
const b: i64 = @as(i64, a);  // Using @as
const c: i64 = @intCast(a);  // Using @intCast (deprecated for this)
```

### Common Casts

| Cast | Function | Example |
|------|----------|---------|
| Int to larger int | `@as` or direct | `@as(i64, small_int)` |
| Int to smaller int | `@intCast` | `@intCast(big_value)` |
| Float to int | `@intFromFloat` | `@intFromFloat(3.7)` → 3 |
| Int to float | `@floatFromInt` | `@floatFromInt(5)` → 5.0 |
| Float precision | `@floatCast` | `@floatCast(f64_val)` |

```zig
const f: f64 = 3.7;
const i: i32 = @intFromFloat(f);  // i = 3 (truncates)

const x: i32 = 42;
const y: f64 = @floatFromInt(x);  // y = 42.0
```

## Integer Overflow

Python handles big numbers automatically. Zig doesn't:

```zig
const max: u8 = 255;
const overflow = max + 1;  // Compile error in Debug mode!
```

In release builds, this would wrap (255 + 1 = 0), which is rarely what you want.

### Safe Arithmetic

```zig
const std = @import("std");

// Checked arithmetic (returns error on overflow)
const result = std.math.add(u8, 255, 1) catch |err| {
    // Handle overflow
};

// Saturating (clamps to max)
const saturated = std.math.add(u8, 255, 1) orelse 255;  // Stays at 255
```

## For Python Developers

| Python | Zig | Notes |
|--------|-----|-------|
| `int` | `i32`, `i64`, etc. | Choose your size |
| `float` | `f32`, `f64` | Choose your precision |
| `bool` | `bool` | `true`/`false` |
| `5 + 3.0` | Error | Must match types |
| `int(3.7)` | `@intFromFloat` | Explicit cast |
| `float(5)` | `@floatFromInt` | Explicit cast |

### No Arbitrary Precision

Python:
```python
big = 2 ** 1000  # Works fine
```

Zig:
```zig
const big = 2 ** 1000;  // Compile error: too large for any type
// Use a big integer library if needed
```

## Type Information at Runtime

```zig
const std = @import("std");

const x: i32 = 42;
std.debug.print("Type: {}\n", .{@TypeOf(x)});  // Prints: i32
std.debug.print("Size: {} bytes\n", .{@sizeOf(@TypeOf(x))});  // Prints: 4
```

## Number Literals

```zig
const decimal = 42;
const hex = 0xFF;        // 255
const octal = 0o77;      // 63
const binary = 0b1010;   // 10

const with_underscores = 1_000_000;  // Readable large numbers

const float_literal = 3.14;
const scientific = 1.5e10;  // 15000000000.0
```

## Common Mistakes

### Mixing signed and unsigned
```zig
const signed: i32 = -5;
const unsigned: u32 = 10;
const sum = signed + unsigned;  // Error! Type mismatch
```

### Array index with wrong type
```zig
const arr = [_]i32{ 1, 2, 3 };
const i: i32 = 1;
const val = arr[i];  // Error! Index must be usize

// Fix:
const val = arr[@intCast(i)];
```

### Forgetting coercion
```zig
fn process(value: f64) void { }

const x: f32 = 3.14;
process(x);  // Error! f32 != f64

// Fix:
process(@floatCast(x));
```

## Self-Check

1. What's the difference between `i32` and `u32`?
2. Why must array indices be `usize`?
3. What happens if you add `255 + 1` to a `u8` in debug mode?
4. How do you convert an `i32` to `f64`?

## Exercises

Complete Exercise 1.3: Types in the exercises folder.

## Next Steps

Now let's look at how Zig handles strings - they're quite different from Python.

→ Continue to [Lesson 1.6: Strings and Slices](06_strings.md)
