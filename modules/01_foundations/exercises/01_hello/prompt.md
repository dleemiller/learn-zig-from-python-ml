# Exercise 1.1: Hello Zig

## Objective

Write your first Zig program that prints a greeting message.

## Requirements

1. Print "Hello, Zig!" to the standard output
2. Print your name on a second line
3. The program should compile without warnings

## Expected Output

```
Hello, Zig!
My name is [Your Name]
```

## Hints

- Use `std.debug.print()` for output
- Format strings use `{s}` for string interpolation
- Remember to import the standard library

## Getting Started

The starter code is in `starter.zig`. Copy it to your workspace and implement the TODO.

## Verification

Run the test to check your solution:
```bash
zig build test-ex-01-01
```

## Learning Goals

- Understand Zig's entry point (`pub fn main()`)
- Use the standard library import pattern
- Practice with `std.debug.print` formatting
