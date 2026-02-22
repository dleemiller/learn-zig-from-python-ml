# Lesson 2.5: Unions and Enums

## Learning Objectives

- [ ] Define and use enums
- [ ] Create tagged unions
- [ ] Use switch with unions for exhaustive handling
- [ ] Understand how unions compare to Python patterns

## Prerequisites

- Completed Lesson 2.4
- Understand switch statements from Module 1

## Enums

Enums define a set of named values:

```zig
const Color = enum {
    red,
    green,
    blue,
};

const favorite = Color.green;
```

## Enum with Explicit Values

```zig
const HttpStatus = enum(u16) {
    ok = 200,
    not_found = 404,
    internal_error = 500,
};

const code: u16 = @intFromEnum(HttpStatus.ok);  // 200
```

## Switch on Enums

Switches on enums must be exhaustive:

```zig
fn statusMessage(status: HttpStatus) []const u8 {
    return switch (status) {
        .ok => "Success",
        .not_found => "Not Found",
        .internal_error => "Server Error",
    };
}
```

No `else` needed when all cases are covered. If you add a new enum value later, the compiler forces you to handle it.

## Tagged Unions

A tagged union can hold ONE of several types, with a tag indicating which:

```zig
const Value = union(enum) {
    int: i64,
    float: f64,
    string: []const u8,
    none,
};
```

This is like a discriminated union in other languages, or `Union[int, float, str, None]` in Python type hints (but enforced at runtime).

## Creating Union Values

```zig
const a = Value{ .int = 42 };
const b = Value{ .float = 3.14 };
const c = Value{ .string = "hello" };
const d = Value{ .none = {} };
```

## Switch on Tagged Unions

```zig
fn printValue(v: Value) void {
    switch (v) {
        .int => |i| std.debug.print("Integer: {d}\n", .{i}),
        .float => |f| std.debug.print("Float: {d}\n", .{f}),
        .string => |s| std.debug.print("String: {s}\n", .{s}),
        .none => std.debug.print("None\n", .{}),
    }
}
```

The `|i|` captures the payload value.

## Why Exhaustive Switches Matter

```zig
const Shape = union(enum) {
    circle: f64,      // radius
    rectangle: struct { w: f64, h: f64 },
    // Later you add:
    // triangle: struct { base: f64, height: f64 },
};

fn area(s: Shape) f64 {
    return switch (s) {
        .circle => |r| 3.14159 * r * r,
        .rectangle => |rect| rect.w * rect.h,
        // Compiler error! Must handle triangle
    };
}
```

The compiler catches missing cases at compile time, not runtime.

## Real-World Example: Parse Result

```zig
const ParseResult = union(enum) {
    success: ParsedData,
    error_invalid_syntax: usize,  // Line number
    error_unexpected_eof,
    error_unknown_token: []const u8,  // The token
};

fn parse(source: []const u8) ParseResult {
    // ...
}

fn handleParse(source: []const u8) void {
    switch (parse(source)) {
        .success => |data| process(data),
        .error_invalid_syntax => |line| {
            std.debug.print("Syntax error on line {d}\n", .{line});
        },
        .error_unexpected_eof => {
            std.debug.print("Unexpected end of file\n", .{});
        },
        .error_unknown_token => |token| {
            std.debug.print("Unknown token: {s}\n", .{token});
        },
    }
}
```

## Checking the Active Tag

```zig
const v = Value{ .int = 42 };

if (v == .int) {
    std.debug.print("It's an int\n", .{});
}
```

## Enums with Methods

Enums can have methods:

```zig
const Direction = enum {
    north,
    south,
    east,
    west,

    fn opposite(self: Direction) Direction {
        return switch (self) {
            .north => .south,
            .south => .north,
            .east => .west,
            .west => .east,
        };
    }
};

const dir = Direction.north;
const opp = dir.opposite();  // .south
```

## For Python Developers

| Python | Zig |
|--------|-----|
| `class Color(Enum)` | `const Color = enum` |
| `Union[A, B]` type hint | `union(enum) { a: A, b: B }` |
| `match` (3.10+) | `switch` |
| Runtime type checking | Compile-time tag checking |
| `isinstance()` | `v == .variant` |

### Pattern: State Machines

Python:
```python
class State(Enum):
    IDLE = auto()
    LOADING = auto()
    READY = auto()
    ERROR = auto()
```

Zig:
```zig
const State = union(enum) {
    idle,
    loading: Progress,     // Can carry data
    ready: Data,
    err: ErrorInfo,
};
```

Zig's tagged unions let each state carry relevant data.

## Untagged Unions (Advanced)

Plain `union` without the enum tag (rarely needed, used for memory layout control):

```zig
const Converter = union {
    int: i32,
    bytes: [4]u8,
};
```

This is for low-level work like parsing binary formats. Usually prefer `union(enum)`.

## Common Mistakes

### Missing Case in Switch

```zig
switch (value) {
    .a => ...,
    .b => ...,
    // Error if .c exists!
}
```

### Accessing Wrong Variant

```zig
const v = Value{ .int = 42 };
const f = v.float;  // Error! Active variant is .int
```

### Forgetting Payload Capture

```zig
switch (v) {
    .int => std.debug.print("Int\n", .{}),  // OK if you don't need value
    .float => |f| std.debug.print("{d}\n", .{f}),  // Captures value
}
```

## Self-Check

1. What's the difference between `enum` and `union(enum)`?
2. Why must switches on enums be exhaustive?
3. How do you capture the payload of a union variant?
4. When would you use a union instead of a struct?

## Exercises

Complete Exercise 2.5: Unions
