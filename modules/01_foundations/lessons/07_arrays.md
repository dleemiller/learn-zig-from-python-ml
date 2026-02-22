# Lesson 1.7: Arrays vs Slices

## Learning Objectives

- [ ] Create and use fixed-size arrays
- [ ] Understand the difference between arrays and slices
- [ ] Use slice operations effectively
- [ ] Know when to use arrays vs slices vs ArrayList

## Prerequisites

- Completed Lesson 1.6
- Understand strings as byte slices

## Arrays: Fixed Size at Compile Time

```zig
// Explicit size
const arr: [5]i32 = .{ 1, 2, 3, 4, 5 };

// Inferred size
const arr2 = [_]i32{ 1, 2, 3, 4, 5 };  // [5]i32

// Initialized with same value
const zeros = [_]i32{ 0, 0, 0, 0, 0 };
const zeros2: [5]i32 = .{ 0 } ** 5;  // Same, using repeat

// Uninitialized (dangerous!)
var buffer: [100]u8 = undefined;
```

### Key Properties

- Size is part of the type: `[5]i32` ≠ `[6]i32`
- Stored on the stack (usually)
- Cannot grow or shrink
- Size known at compile time

## Slices: Views into Arrays

A slice is a pointer + length:

```zig
const arr = [_]i32{ 1, 2, 3, 4, 5 };
const slice: []const i32 = &arr;  // Slice of entire array

std.debug.print("Length: {d}\n", .{slice.len});  // 5
std.debug.print("First: {d}\n", .{slice[0]});    // 1
```

### Creating Slices

```zig
const arr = [_]i32{ 10, 20, 30, 40, 50 };

// Full slice
const full: []const i32 = &arr;

// Partial slices
const first_three = arr[0..3];   // { 10, 20, 30 }
const last_two = arr[3..5];      // { 40, 50 }
const middle = arr[1..4];        // { 20, 30, 40 }
const from_idx = arr[2..];       // { 30, 40, 50 } (to end)
```

### Mutable Slices

```zig
var arr = [_]i32{ 1, 2, 3, 4, 5 };
var slice: []i32 = &arr;  // Note: no const

slice[0] = 100;  // Modifies arr[0]
std.debug.print("{d}\n", .{arr[0]});  // 100
```

## Arrays vs Slices: Mental Model

Think of it like NumPy:

```python
# Python/NumPy
arr = np.array([1, 2, 3, 4, 5])  # The data
view = arr[1:4]                   # A view into it
```

```zig
// Zig
const arr = [_]i32{ 1, 2, 3, 4, 5 };  // The data (on stack)
const slice = arr[1..4];               // A view into it
```

## Why Slices?

### Function Parameters

Functions should take slices, not arrays:

```zig
// BAD - only works with [5]i32
fn sumBad(arr: [5]i32) i32 { ... }

// GOOD - works with any size
fn sum(slice: []const i32) i32 {
    var total: i32 = 0;
    for (slice) |val| {
        total += val;
    }
    return total;
}

// Call with any array
const a = [_]i32{ 1, 2, 3 };
const b = [_]i32{ 1, 2, 3, 4, 5, 6, 7 };

_ = sum(&a);  // Works
_ = sum(&b);  // Works
```

### Subsets Without Copying

```zig
const data = [_]i32{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };

// Process first half (no copy!)
processSlice(data[0..5]);

// Process second half (no copy!)
processSlice(data[5..]);
```

## Bounds Checking

Zig checks bounds in safe modes:

```zig
const arr = [_]i32{ 1, 2, 3 };
const val = arr[5];  // Runtime panic in Debug: index out of bounds
```

This catches bugs that would be silent memory corruption in C.

## Multi-dimensional Arrays

```zig
// 2D array (3 rows, 4 columns)
const matrix: [3][4]i32 = .{
    .{ 1, 2, 3, 4 },
    .{ 5, 6, 7, 8 },
    .{ 9, 10, 11, 12 },
};

const val = matrix[1][2];  // Row 1, Column 2 = 7

// Iterate rows
for (matrix) |row| {
    for (row) |val| {
        std.debug.print("{d} ", .{val});
    }
    std.debug.print("\n", .{});
}
```

### For ML: Flattened Arrays

For performance, ML often uses flat arrays with computed indices:

```zig
// 3x4 matrix stored flat
const flat = [_]i32{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 };
const rows: usize = 3;
const cols: usize = 4;

fn get(data: []const i32, row: usize, col: usize) i32 {
    return data[row * cols + col];
}

const val = get(&flat, 1, 2);  // 7
```

## Sentinel-Terminated Arrays

For C interop, you sometimes need null-terminated arrays:

```zig
// Null-terminated string (C-compatible)
const c_str: [:0]const u8 = "hello";

// The sentinel is NOT included in .len
std.debug.print("Length: {d}\n", .{c_str.len});  // 5
```

## Array Operations

### Concatenation (Comptime Only)

```zig
const a = [_]i32{ 1, 2 };
const b = [_]i32{ 3, 4 };
const c = a ++ b;  // [_]i32{ 1, 2, 3, 4 }
```

### Repetition (Comptime Only)

```zig
const pattern = [_]i32{ 1, 2 };
const repeated = pattern ** 3;  // [_]i32{ 1, 2, 1, 2, 1, 2 }
```

### Copying

```zig
const src = [_]i32{ 1, 2, 3 };
var dst: [3]i32 = undefined;
@memcpy(&dst, &src);
```

## For Python Developers

| Python | Zig | Notes |
|--------|-----|-------|
| `list` | `ArrayList` | Dynamic (Module 4) |
| `tuple` | `[N]T` | Fixed array |
| `arr[1:4]` | `arr[1..4]` | Slice (view, not copy) |
| `arr[:]` | `arr[0..]` or `&arr` | Full slice |
| `len(arr)` | `arr.len` | Property |
| `arr.append(x)` | Not for arrays | Use ArrayList |
| `arr + other` | `arr ++ other` | Comptime only |
| `np.zeros(5)` | `.{ 0 } ** 5` | Comptime only |

### Key Insight

Python lists are dynamic and heap-allocated. Zig arrays are fixed and usually stack-allocated. Slices let you work with portions without copying.

## When to Use What

| Use Case | Type |
|----------|------|
| Fixed-size buffer | `[N]T` |
| Function parameters | `[]const T` or `[]T` |
| Unknown size at compile time | `[]T` (from allocator) |
| Growing collection | `ArrayList(T)` (Module 4) |
| String data | `[]const u8` |

## Common Mistakes

### Returning a slice to local array
```zig
fn dangerous() []const i32 {
    const arr = [_]i32{ 1, 2, 3 };
    return &arr;  // DANGER: arr is on stack, will be invalid!
}
```

### Confusing array and slice types
```zig
fn process(arr: [5]i32) void { }

const data = [_]i32{ 1, 2, 3, 4, 5 };
process(&data);  // Error! &data is a pointer, not [5]i32
process(data);   // Correct
```

### Off-by-one in slices
```zig
const arr = [_]i32{ 1, 2, 3, 4, 5 };
const last_three = arr[3..5];  // { 4, 5 } - only 2 elements!
const last_three_correct = arr[2..5];  // { 3, 4, 5 }
```

## Self-Check

1. What's the difference between `[5]i32` and `[]i32`?
2. If you slice an array, does it copy the data?
3. Why should functions typically take slices, not arrays?
4. What happens if you access `arr[10]` when `arr.len == 5`?

## Exercises

Complete Exercise 1.5: Arrays in the exercises folder.

## Next Steps

Now let's explore Zig's control flow, which has some unique features.

→ Continue to [Lesson 1.8: Control Flow](08_control_flow.md)
