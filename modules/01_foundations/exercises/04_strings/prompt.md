# Exercise 1.4: String Operations

## Objective

Work with Zig strings (byte slices) and understand their properties.

## Requirements

1. Get the length of a string
2. Access individual characters (bytes)
3. Create a substring using slice syntax
4. Compare two strings for equality

## Expected Output

```
String: Hello, Zig!
Length: 11
First char: H
Last char: !
Substring [0..5]: Hello
Strings equal: true
```

## Concepts Tested

- []const u8 type
- String .len property
- Slice indexing and ranges
- std.mem.eql for comparison

## Verification

```bash
zig build test-ex-01-04
```
