# Lesson 1.6: Strings and Slices

## Learning Objectives

- [ ] Understand that Zig strings are `[]const u8`
- [ ] Work with string length, indexing, and slicing
- [ ] Compare strings correctly
- [ ] Understand UTF-8 implications

## Prerequisites

- Completed Lesson 1.5
- Understand primitive types

## Strings Are Byte Slices

In Python, strings are a special type with methods like `.upper()`, `.split()`, etc.

In Zig, strings are much simpler — they're just sequences of bytes:

```zig
const greeting: []const u8 = "Hello";
```

The type `[]const u8` means:
- A sequence of bytes (`u8`)
- That can't be modified (`const`)

That's it. No special string type, no built-in methods.

## A Soft Introduction to Pointers

To understand why strings work the way they do, you need a small preview of a concept we'll cover fully in Module 3: **pointers**.

A pointer is a value that holds a memory address — it "points to" where some data lives. A **slice** (like `[]const u8`) is a pointer plus a length: "here's where the data starts, and here's how many bytes."

```
String slice []const u8:
┌─────────┬────────┐
│ pointer │ length │  →  points to →  ['H']['e']['l']['l']['o']
└─────────┴────────┘                   in memory somewhere
```

You don't need to fully understand pointers yet — just know that a slice is a "view" into some data, not the data itself. We'll explore this properly in Module 3.

## Basic String Operations

### Length

```zig
const str = "Hello";
const len = str.len;  // 5
```

### Indexing

```zig
const str = "Hello";
const first = str[0];   // 'H' — but as a u8 (byte value 72)
const last = str[str.len - 1];  // 'o'
```

### Slicing (Substrings)

```zig
const str = "Hello, World!";
const hello = str[0..5];     // "Hello"
const world = str[7..12];    // "World"
const rest = str[7..];       // "World!" (to end)
```

Note: Zig uses `..` (two dots), Python uses `:` (colon).

## Comparing Strings

This is where the "slices are pointers" concept matters.

**Don't use `==` for strings:**

```zig
const a = "hello";
const b = "hello";
if (a == b) { ... }  // Unreliable!
```

The `==` operator compares whether two slices point to the same memory location, not whether they contain the same bytes. It might work for identical literals (the compiler may merge them), but it's not guaranteed.

**Use `std.mem.eql` instead:**

```zig
const std = @import("std");

const a = "hello";
const b = "hello";
if (std.mem.eql(u8, a, b)) {
    // This actually compares the bytes
}
```

This compares the contents, byte by byte.

## UTF-8 Reality

Zig strings are UTF-8 encoded. This means:

```zig
const emoji = "Hi 👋";
std.debug.print("len = {d}\n", .{emoji.len});  // 7, not 4!
```

The wave emoji takes 4 bytes in UTF-8. The `.len` field counts **bytes**, not characters.

Similarly:
```zig
const accented = "café";
std.debug.print("len = {d}\n", .{accented.len});  // 5, not 4
```

The `é` character is 2 bytes.

If you need to count actual characters, you need to decode UTF-8 — but for most purposes (especially ML data processing), byte length is what you want.

## Escape Sequences

```zig
const newline = "Line 1\nLine 2";
const tab = "Col1\tCol2";
const quote = "She said \"Hello\"";
const backslash = "path\\to\\file";
```

## Multi-line Strings

```zig
const multi =
    \\This is line 1
    \\This is line 2
    \\This is line 3
;
```

The `\\` syntax creates a multi-line string.

## String Concatenation

You can't use `+` to concatenate strings:

```zig
const a = "Hello, ";
const b = "World!";
const c = a + b;  // Error!
```

For compile-time concatenation, use `++`:

```zig
const greeting = "Hello, " ++ "World!";  // Works at compile time
```

For runtime concatenation, you need memory allocation — covered in Module 3.

## For Python Developers

| Python | Zig | Notes |
|--------|-----|-------|
| `str` | `[]const u8` | Byte sequence |
| `len("abc")` | `"abc".len` | Field, not function |
| `s[0]` | `s[0]` | Returns byte (u8), not string |
| `s[1:4]` | `s[1..4]` | Two dots, not colon |
| `s == t` | `std.mem.eql(u8, s, t)` | Must use function |
| `s + t` | `s ++ t` | Compile-time only |
| `f"{x}"` | Print with `.{x}` | No interpolation |

## Common Mistakes

### Using `==` for comparison
```zig
if (str1 == str2) { }  // Wrong — compares pointers, not content
if (std.mem.eql(u8, str1, str2)) { }  // Correct
```

### Expecting character count from `.len`
```zig
const s = "café";
s.len  // 5 bytes, not 4 characters
```

### Trying to use `+` for concatenation
```zig
const c = a + b;  // Error
const c = a ++ b;  // Works (compile-time only)
```

## Self-Check

1. What type is a string literal in Zig?
2. How do you check if two strings have the same content?
3. Why is `"👋".len` equal to 4, not 1?
4. Why can't you use `==` to compare strings?

## Exercises

Complete Exercise 1.4: Strings in the exercises folder.

## Next Steps

Now let's look at arrays and how slices relate to them.

→ Continue to [Lesson 1.7: Arrays vs Slices](07_arrays.md)
