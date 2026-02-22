# Module 2: Functions, Errors, and Optionals

## Overview

This module covers Zig's approach to functions and error handling. Unlike Python's exception-based model, Zig makes errors explicit in function signatures and forces you to handle them.

## Prerequisites

- Completed Module 1: Foundations
- Comfortable with basic Zig syntax

## Learning Objectives

By the end of this module, you will be able to:

- Write functions with various parameter and return types
- Use error unions to represent fallible operations
- Apply defer/errdefer for resource cleanup
- Work with optional types safely
- Create and use tagged unions and enums
- Understand basic comptime concepts

## Lessons

| Lesson | Topic | Description |
|--------|-------|-------------|
| 2.1 | Functions Deep Dive | Parameters, return types, anytype |
| 2.2 | Error Unions | !T, error sets, try, catch |
| 2.3 | Error Handling Patterns | defer, errdefer, cleanup |
| 2.4 | Optionals | ?T, orelse, unwrapping |
| 2.5 | Unions and Enums | Tagged unions, switch, exhaustiveness |
| 2.6 | Comptime Basics | Type-level programming introduction |

## Exercises

| Exercise | Topic | Skills Practiced |
|----------|-------|------------------|
| 2.1 | Functions | Function declaration, parameters, returns |
| 2.2 | Errors | Error propagation with try/catch |
| 2.3 | Defer | Resource cleanup patterns |
| 2.4 | Optionals | Working with nullable values |
| 2.5 | Unions | Tagged union matching |
| 2.6 | Comptime | Basic comptime operations |

## Key Python to Zig Concepts

| Python | Zig | Notes |
|--------|-----|-------|
| `def func(x):` | `fn func(x: i32) void` | Explicit types required |
| `try: ... except:` | `try` / `catch` | Error in return type |
| `None` | `null` with `?T` | Explicit optional type |
| Exception propagation | `try` keyword | Must explicitly propagate |
| Context managers | `defer` | Cleanup at scope exit |

## Why This Matters for ML

Error handling is critical in ML systems:
- File I/O when loading models
- Memory allocation failures
- Invalid tensor dimensions
- Numerical errors (division by zero, overflow)

Zig's explicit error handling ensures you consider failure cases upfront, leading to more robust inference code.
