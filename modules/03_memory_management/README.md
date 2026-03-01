# Module 3: Memory Management

## Overview

Memory management is the single biggest conceptual jump for Python developers learning Zig. In Python, you never think about memory — the garbage collector handles everything. In Zig, you control every allocation and deallocation. This module takes you from "what is a pointer?" to confidently managing memory in ML-style workloads.

## Prerequisites

- Completed Module 1: Foundations
- Completed Module 2: Functions, Errors, and Optionals
- Comfortable with error unions (`!T`), `try`, `defer`, and `errdefer`

## Learning Objectives

By the end of this module, you will be able to:

- Explain the difference between stack and heap memory
- Use pointers to reference and mutate data
- Allocate and free memory using the `std.mem.Allocator` interface
- Choose the right allocator for a given task (GPA, Arena, FixedBuffer)
- Apply memory patterns common in ML workloads (weight persistence, per-inference arenas)
- Debug memory issues: leaks, double-free, use-after-free

## Lessons

| Lesson | Topic | Duration |
|--------|-------|----------|
| 3.1 | [Stack vs Heap](lessons/01_stack_heap.md) | ~25 min |
| 3.2 | [Pointers Demystified](lessons/02_pointers.md) | ~30 min |
| 3.3 | [Allocator Interface](lessons/03_allocator.md) | ~30 min |
| 3.4 | [GeneralPurposeAllocator](lessons/04_gpa.md) | ~25 min |
| 3.5 | [ArenaAllocator](lessons/05_arena.md) | ~25 min |
| 3.6 | [FixedBufferAllocator](lessons/06_fixed_buffer.md) | ~20 min |
| 3.7 | [Memory Patterns for ML](lessons/07_ml_patterns.md) | ~30 min |
| 3.8 | [Debugging Memory Issues](lessons/08_debugging.md) | ~25 min |

## Exercises

Each lesson has an associated exercise in the `exercises/` directory:

1. **Stack & Heap** — Value semantics, stack lifetimes, array copies vs slice views
2. **Pointers** — Swap, in-place mutation, returning pointers into data
3. **Allocator Interface** — alloc/free, two-pass filtering, concatenation
4. **GeneralPurposeAllocator** — Resource-owning struct with init/deinit, errdefer cleanup
5. **ArenaAllocator** — Batch processing, two-allocator pattern (arena scratch + backing result)
6. **FixedBufferAllocator** — No-heap allocation, buffer-too-small error handling
7. **ML Patterns** — SimpleModel struct with weight persistence and per-inference arena scratch
8. **Debugging** — Bug hunt: find and fix leaks, missing errdefer, use-after-free

## Key Python → Zig Concepts

| Python | Zig | Key Difference |
|--------|-----|----------------|
| `x = [1, 2, 3]` (heap, GC-managed) | `var x = [_]i32{1, 2, 3};` (stack) | You choose where data lives |
| `y = x` (shared reference) | `const ptr = &x;` (explicit pointer) | References are always explicit |
| `del x` (hint to GC) | `allocator.free(x)` (immediate) | You control when memory is freed |
| `list()` (always heap) | `allocator.alloc(i32, n)` (allocator decides) | Allocator is a parameter |
| GC batch reclamation | `arena.deinit()` (bulk free) | Explicit bulk deallocation |
| `tracemalloc` | `std.testing.allocator` / GPA | Built-in leak detection |

## What's Next

After completing this module, you'll be ready for:
- **Module 4: Data Structures and Generics** — Structs, generics, ArrayList, and building a Tensor type
