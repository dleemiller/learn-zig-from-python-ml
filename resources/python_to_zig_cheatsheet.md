# Python to Zig Cheatsheet

Quick reference for Python developers learning Zig.

## Basic Syntax

| Python | Zig | Notes |
|--------|-----|-------|
| `# comment` | `// comment` | Single-line comments |
| `"""docstring"""` | `/// doc comment` | Documentation |
| `pass` | `{}` | Empty block |
| `None` | `null` | Only with optionals (`?T`) |
| `True/False` | `true/false` | Lowercase |

## Variables

```python
# Python
x = 5           # Mutable, any type
PI = 3.14       # Convention, still mutable

name = "Alice"
numbers = [1, 2, 3]
```

```zig
// Zig
var x: i32 = 5;           // Mutable, explicit type
const PI: f64 = 3.14;     // Immutable, compile-time

const name = "Alice";     // Type inferred: []const u8
var numbers = [_]i32{ 1, 2, 3 };  // Array with inferred length
```

## Types

| Python | Zig | Range |
|--------|-----|-------|
| `int` | `i32`, `i64`, etc. | Sized integers |
| `int` (positive) | `u32`, `u64`, etc. | Unsigned integers |
| `float` | `f32`, `f64` | IEEE 754 floats |
| `bool` | `bool` | `true` or `false` |
| `str` | `[]const u8` | UTF-8 byte slice |
| `bytes` | `[]u8` | Mutable byte slice |
| `list[int]` | `[]i32` or `ArrayList(i32)` | Slice or dynamic array |
| `dict[str, int]` | `std.StringHashMap(i32)` | Hash map |
| `None` | `?T` (optional) | Explicit optional type |

## Functions

```python
# Python
def greet(name: str) -> str:
    return f"Hello, {name}!"

def add(a, b):  # Dynamic types
    return a + b
```

```zig
// Zig
fn greet(name: []const u8) []const u8 {
    // Note: String formatting requires more setup
    return "Hello!";
}

fn add(a: i32, b: i32) i32 {  // Explicit types required
    return a + b;
}

// Generic version (like Python's duck typing)
fn addGeneric(a: anytype, b: anytype) @TypeOf(a) {
    return a + b;
}
```

## Error Handling

```python
# Python
def read_file(path):
    try:
        with open(path) as f:
            return f.read()
    except FileNotFoundError:
        return None
    except IOError as e:
        raise
```

```zig
// Zig
fn readFile(path: []const u8) ![]u8 {
    const file = try std.fs.cwd().openFile(path, .{});
    defer file.close();
    return try file.readToEndAlloc(allocator, max_size);
}

// Using it:
const content = readFile("data.txt") catch |err| {
    switch (err) {
        error.FileNotFound => return null,
        else => return err,
    }
};
```

| Python | Zig | Meaning |
|--------|-----|---------|
| `raise Exception` | `return error.Something` | Return an error |
| `try:` | `try` (before call) | Propagate error up |
| `except:` | `catch \|err\|` | Handle error |
| `with:` | `defer` | Cleanup on scope exit |
| `except X:` | `catch \|err\| switch(err)` | Handle specific errors |

## Control Flow

```python
# Python
if x > 0:
    print("positive")
elif x < 0:
    print("negative")
else:
    print("zero")

for i in range(10):
    print(i)

for item in items:
    print(item)

while condition:
    do_something()
```

```zig
// Zig
if (x > 0) {
    std.debug.print("positive\n", .{});
} else if (x < 0) {
    std.debug.print("negative\n", .{});
} else {
    std.debug.print("zero\n", .{});
}

// Range loop
for (0..10) |i| {
    std.debug.print("{d}\n", .{i});
}

// Iterate over slice
for (items) |item| {
    std.debug.print("{}\n", .{item});
}

while (condition) {
    doSomething();
}
```

### Zig's Expression-Based If

```zig
// Zig if can be an expression
const abs_value = if (x < 0) -x else x;

// Python equivalent:
// abs_value = -x if x < 0 else x
```

## Data Structures

### Arrays (Fixed Size)

```python
# Python - list is always dynamic
numbers = [1, 2, 3, 4, 5]
```

```zig
// Zig - fixed size array
const numbers = [5]i32{ 1, 2, 3, 4, 5 };  // [5]i32
const inferred = [_]i32{ 1, 2, 3, 4, 5 }; // Length inferred

// Access
const first = numbers[0];
const length = numbers.len;  // 5
```

### Slices (Views into Arrays)

```zig
// Slice is a pointer + length (like Python's memoryview)
const slice: []const i32 = &numbers;     // Pointer to array
const subset = numbers[1..4];            // Elements 1, 2, 3
```

### Structs (Like Python dataclass/namedtuple)

```python
# Python
from dataclasses import dataclass

@dataclass
class Point:
    x: float
    y: float

    def distance(self, other: 'Point') -> float:
        return ((self.x - other.x)**2 + (self.y - other.y)**2)**0.5
```

```zig
// Zig
const Point = struct {
    x: f64,
    y: f64,

    pub fn distance(self: Point, other: Point) f64 {
        const dx = self.x - other.x;
        const dy = self.y - other.y;
        return @sqrt(dx * dx + dy * dy);
    }
};

// Usage
const p1 = Point{ .x = 0.0, .y = 0.0 };
const p2 = Point{ .x = 3.0, .y = 4.0 };
const dist = p1.distance(p2);  // 5.0
```

## Memory Management

```python
# Python - automatic garbage collection
data = [0] * 1000000  # Allocated somewhere
# ... use data ...
# Eventually garbage collected
```

```zig
// Zig - explicit allocation
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
defer _ = gpa.deinit();
const allocator = gpa.allocator();

const data = try allocator.alloc(i32, 1000000);
defer allocator.free(data);  // Always freed when scope exits

// ... use data ...
```

### Common Allocator Patterns

| Pattern | Use Case |
|---------|----------|
| `GeneralPurposeAllocator` | General use, debug-friendly |
| `ArenaAllocator` | Batch free (per-request) |
| `FixedBufferAllocator` | No heap, stack-based |
| `std.testing.allocator` | Tests (leak detection) |

## String Formatting

```python
# Python
name = "Alice"
age = 30
print(f"Name: {name}, Age: {age}")
```

```zig
// Zig
const name = "Alice";
const age: u32 = 30;
std.debug.print("Name: {s}, Age: {d}\n", .{ name, age });
```

### Format Specifiers

| Specifier | Type | Example |
|-----------|------|---------|
| `{s}` | String (`[]const u8`) | `"hello"` |
| `{d}` | Integer | `42` |
| `{x}` | Hex integer | `0x2a` |
| `{e}` | Float (scientific) | `3.14e0` |
| `{}` | Default format | Any |
| `{any}` | Debug print | Structs, etc. |

## Common Gotchas

### 1. Semicolons Required
```zig
const x = 5;  // Semicolon required
```

### 2. No Operator Overloading
```python
# Python - you can override __add__
result = vector1 + vector2
```
```zig
// Zig - explicit function call
const result = vector1.add(vector2);
```

### 3. No Implicit Type Conversion
```python
# Python
x = 5 + 3.14  # Implicit int to float
```
```zig
// Zig
const x: f64 = 5.0 + 3.14;  // Must be same type
const y: f64 = @as(f64, @floatFromInt(5)) + 3.14;  // Explicit
```

### 4. Array Index Must Be usize
```zig
const i: i32 = 5;
const val = arr[@intCast(i)];  // Must cast to usize
```

### 5. Strings Are Not Null-Terminated by Default
```zig
const str = "hello";           // []const u8, length 5
const cstr: [*:0]const u8 = "hello";  // Null-terminated for C interop
```

## Quick Reference: Common Operations

| Operation | Zig |
|-----------|-----|
| Print | `std.debug.print("{}\n", .{value})` |
| Assert | `std.debug.assert(condition)` |
| Test assert | `try std.testing.expect(condition)` |
| Get type | `@TypeOf(value)` |
| Cast type | `@as(T, value)` or `@intCast`, `@floatCast` |
| Sizeof | `@sizeOf(T)` |
| Import | `const mod = @import("module.zig")` |
| C import | `const c = @cImport(@cInclude("header.h"))` |
