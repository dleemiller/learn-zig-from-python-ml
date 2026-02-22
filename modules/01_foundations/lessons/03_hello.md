# Lesson 1.3: Hello Zig

## Learning Objectives

- [ ] Write a complete Zig program from scratch
- [ ] Understand the structure of a Zig file
- [ ] Use `std.debug.print` for output
- [ ] Understand imports and the standard library

## Prerequisites

- Zig installed and working (`zig version` shows a version)
- Completed Lesson 1.2

## Your First Program

Create a file called `hello.zig`:

```zig
const std = @import("std");

pub fn main() void {
    std.debug.print("Hello, Zig!\n", .{});
}
```

Run it:
```bash
zig run hello.zig
```

Output:
```
Hello, Zig!
```

Let's break down every part.

## Anatomy of a Zig File

### 1. Imports

```zig
const std = @import("std");
```

- `@import` is a built-in function (note the `@`)
- `"std"` refers to the standard library
- `const std` binds it to the name `std`

Unlike Python's `import`, this:
- Creates a compile-time constant
- The import is resolved at compile time
- No runtime overhead

### 2. Entry Point

```zig
pub fn main() void {
    // Your code here
}
```

- `pub` makes the function public (visible outside the file)
- `fn` declares a function
- `main` is the entry point (like Python's `if __name__ == "__main__"`)
- `()` means no parameters
- `void` means no return value

### Declaration Order

Unlike Python, Zig has no order dependency for top-level declarations. You can call a function defined later in the file:

```zig
pub fn main() void {
    sayHello();  // works fine, even though sayHello is below
}

fn sayHello() void {
    std.debug.print("Hello\n", .{});
}
```

Zig resolves all declarations before compiling. In Python, the interpreter runs top-to-bottom, so a function must be defined before you call it at runtime.

### 3. Printing Output

```zig
std.debug.print("Hello, Zig!\n", .{});
```

- `std.debug` is the debug namespace
- `print` writes to stderr (not stdout!)
- `"Hello, Zig!\n"` is the format string
- `.{}` is an empty tuple for format arguments

## Format Strings

Zig uses format specifiers similar to Python's `%` formatting:

```zig
const name = "World";
const count: i32 = 42;

std.debug.print("Hello, {s}!\n", .{name});
std.debug.print("Count: {d}\n", .{count});
std.debug.print("Multiple: {s} - {d}\n", .{name, count});
```

### Common Format Specifiers

| Specifier | Type | Example |
|-----------|------|---------|
| `{s}` | String (`[]const u8`) | `"hello"` |
| `{d}` | Decimal integer | `42` |
| `{x}` | Hexadecimal | `0x2a` |
| `{b}` | Binary | `0b101010` |
| `{e}` | Float (scientific) | `1.5e2` |
| `{}` | Default format | Anything |
| `{any}` | Debug format | Structs, etc. |

### The Anonymous Struct Syntax

The `.{}` syntax creates an anonymous struct (tuple):

```zig
.{}                    // Empty tuple
.{"hello"}             // One element
.{"hello", 42}         // Two elements
.{name, count}         // Variables
```

## Why stderr?

`std.debug.print` writes to stderr, not stdout. This is intentional:
- Debug output doesn't interfere with program output
- Good for development and debugging
- For "real" output, use `std.io.getStdOut()`

## Stdout vs Debug Print

For actual program output (not debugging):

```zig
const std = @import("std");

pub fn main() !void {  // Note: !void for error handling
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hello, stdout!\n", .{});
}
```

We'll cover error handling (`!void` and `try`) in Module 2.

## For Python Developers

| Python | Zig |
|--------|-----|
| `print("hello")` | `std.debug.print("hello\n", .{})` |
| `print(f"Hi {name}")` | `std.debug.print("Hi {s}\n", .{name})` |
| `import sys` | `const std = @import("std")` |
| `if __name__ == "__main__":` | `pub fn main()` |

Key differences:
1. **No automatic newline** - You must include `\n`
2. **Format arguments in tuple** - `.{arg1, arg2}`
3. **Explicit format specifiers** - `{s}`, `{d}`, not just `{}`

## Multiple Statements

```zig
const std = @import("std");

pub fn main() void {
    std.debug.print("Line 1\n", .{});
    std.debug.print("Line 2\n", .{});
    std.debug.print("Line 3\n", .{});
}
```

Note: Every statement ends with a semicolon.

## Comments

```zig
// Single line comment

/// Documentation comment (for docs generation)
/// Describes the following declaration

// Multi-line? Just use multiple single-line comments
// Zig intentionally doesn't have /* */ style comments
```

## Common Mistakes

### Missing semicolon
```zig
// BAD
std.debug.print("hello\n", .{})

// GOOD
std.debug.print("hello\n", .{});
```

### Missing newline
```zig
// Prints without newline (output may be garbled)
std.debug.print("hello", .{});

// Correct
std.debug.print("hello\n", .{});
```

### Wrong format specifier
```zig
const num: i32 = 42;

// BAD - using string specifier for integer
std.debug.print("{s}\n", .{num});  // Compile error!

// GOOD
std.debug.print("{d}\n", .{num});
```

### Empty format tuple
```zig
// BAD - missing the tuple
std.debug.print("hello\n");  // Compile error!

// GOOD - even with no args, need empty tuple
std.debug.print("hello\n", .{});
```

## Building vs Running

You have two options:

```bash
# Direct run (compile and execute)
zig run hello.zig

# Build, then run separately
zig build-exe hello.zig
./hello
```

For learning, `zig run` is convenient. For production, you'll use `zig build`.

## Self-Check

Before moving on:

1. What does `@import("std")` do?
2. Why do we write `void` after `main()`?
3. What's the difference between `{}` and `.{}`?
4. Why might `std.debug.print` use stderr instead of stdout?

## Exercises

Complete Exercise 1.1: Hello World in the exercises folder.

## Next Steps

Now that you can print output, let's learn about variables and constants.

→ Continue to [Lesson 1.4: Variables and Constants](04_variables.md)
