# Module 1: Foundations for Python Developers

## Overview

This module introduces Zig fundamentals through the lens of a Python developer. We'll cover syntax, types, and control flow while constantly drawing comparisons to Python to leverage your existing knowledge.

## Learning Objectives

By the end of this module, you will be able to:

- Explain why Zig is valuable for ML/systems work
- Set up and use the Zig toolchain
- Write and compile basic Zig programs
- Use Zig's type system (integers, floats, strings, arrays)
- Understand the difference between compile-time and runtime
- Write control flow with Zig's expression-based syntax

## Prerequisites

- Python proficiency (intermediate level)
- Familiarity with a command-line interface
- A text editor (VS Code with Zig extension recommended)

## Lessons

| Lesson | Topic | Duration |
|--------|-------|----------|
| 1.1 | [Why Zig for ML?](lessons/01_why_zig.md) | ~20 min |
| 1.2 | [Environment Setup](lessons/02_setup.md) | ~15 min |
| 1.3 | [Hello Zig](lessons/03_hello.md) | ~20 min |
| 1.4 | [Variables and Constants](lessons/04_variables.md) | ~25 min |
| 1.5 | [Primitive Types](lessons/05_types.md) | ~30 min |
| 1.6 | [Strings and Slices](lessons/06_strings.md) | ~30 min |
| 1.7 | [Arrays vs Slices](lessons/07_arrays.md) | ~30 min |
| 1.8 | [Control Flow](lessons/08_control_flow.md) | ~30 min |

## Exercises

Each lesson has an associated exercise in the `exercises/` directory:

1. **Hello World** - Your first Zig program
2. **Variables** - Constants, mutability, and shadowing
3. **Types** - Numeric conversions and operations
4. **Strings** - String manipulation and formatting
5. **Arrays** - Array operations and bounds checking
6. **Control Flow** - Conditionals and loops
7. **FizzBuzz** - Classic challenge in Zig
8. **Calculator** - Putting it all together

## Key Python → Zig Concepts

| Python | Zig | Key Difference |
|--------|-----|----------------|
| `x = 5` | `var x: i32 = 5;` | Explicit types, semicolons |
| `CONST = 5` | `const x = 5;` | True compile-time constant |
| Dynamic typing | Static typing | Types checked at compile time |
| `None` | `null` with optionals | Must be explicit with `?T` |
| `try/except` | `try`/`catch` with `!T` | Error unions, not exceptions |
| `"string"` | `"string"` (`[]const u8`) | Strings are byte slices |
| `list` | `[]T` or `ArrayList` | Fixed arrays vs dynamic |
| Garbage collection | Manual/arena allocation | You control memory |

## What's Next

After completing this module, you'll be ready for:
- **Module 2**: Functions, Errors, and Optionals
- Start understanding Zig's unique error handling model

## Tips for Success

1. **Don't skip exercises** - Muscle memory matters for new syntax
2. **Read error messages** - Zig's compiler messages are helpful
3. **Use `zig fmt`** - Let the formatter handle style
4. **Ask the AI** - If confused, ask for Python comparisons
