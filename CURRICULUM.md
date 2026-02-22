# Zig Learning Curriculum

A curriculum for Python/ML developers learning Zig, from basics to building an ML inference engine.

## Module Overview

| Module | Topic | Lessons | Key Skills |
|--------|-------|---------|------------|
| 1 | Foundations | 8 | Syntax, types, control flow, Python comparisons |
| 2 | Functions & Errors | 6 | Error unions, optionals, defer, comptime basics |
| 3 | Memory Management | 8 | Pointers, allocators, arenas, debugging leaks |
| 4 | Data Structures | 6 | Structs, generics, collections, tensor type |
| 5 | Build System | 5 | build.zig, dependencies, testing |
| 6 | Standard Library | 8 | File I/O, JSON, HTTP, networking |
| 7 | C Interoperability | 5 | @cImport, linking, BLAS integration |
| 8 | Hardware Intrinsics | 6 | SIMD, AVX, NEON, portable vectors |
| 9 | Data Processing | 9 | Signal processing, ML algorithms, images |
| 10 | Best Practices | 4 | Style, documentation, profiling |
| 11 | Advanced ML | 3 | Threading, numerical precision, mmap |
| **Capstone** | ML Inference Engine | 6 milestones | Safetensors, tensors, SIMD, neural networks |

**Total: ~65 lessons + capstone project**

---

## Module 1: Foundations for Python Developers

| Lesson | Topic | Key Concepts |
|--------|-------|--------------|
| 1.1 | Why Zig for ML? | Compile-time guarantees, performance, no hidden control flow |
| 1.2 | Environment Setup | Zig toolchain, project structure, `zig build` |
| 1.3 | Hello Zig | Entry points, imports, `std.debug.print` |
| 1.4 | Variables and Constants | `var`, `const`, type annotations, comptime |
| 1.5 | Primitive Types | Integers, floats, bool, explicit type coercion |
| 1.6 | Strings and Slices | `[]const u8`, UTF-8, no GC implications |
| 1.7 | Arrays vs Slices | Stack allocation, bounds checking, sentinels |
| 1.8 | Control Flow | Expression-based if/switch, labeled blocks |

---

## Module 2: Functions, Errors, and Optionals

| Lesson | Topic | Key Concepts |
|--------|-------|--------------|
| 2.1 | Functions Deep Dive | Parameters, return types, `anytype` |
| 2.2 | Error Unions | `!T`, error sets, `try`, `catch` |
| 2.3 | Error Handling Patterns | `defer`, `errdefer`, cleanup |
| 2.4 | Optionals | `?T`, `orelse`, unwrapping |
| 2.5 | Unions and Enums | Tagged unions, `switch`, exhaustiveness |
| 2.6 | Comptime Basics | Type-level programming introduction |

---

## Module 3: Memory Management (CRITICAL)

| Lesson | Topic | Key Concepts |
|--------|-------|--------------|
| 3.1 | Stack vs Heap | Automatic vs dynamic lifetime |
| 3.2 | Pointers Demystified | `*T`, `[*]T`, dereferencing, pointer arithmetic |
| 3.3 | Allocator Interface | `std.mem.Allocator`, alloc/free patterns |
| 3.4 | GeneralPurposeAllocator | Safety checks, leak detection |
| 3.5 | ArenaAllocator | Bulk deallocation, request scoping |
| 3.6 | FixedBufferAllocator | Stack-based allocation, no heap |
| 3.7 | Memory Patterns for ML | Per-inference arenas, weight persistence |
| 3.8 | Debugging Memory Issues | `std.testing.allocator`, valgrind integration |

---

## Module 4: Data Structures and Generics

| Lesson | Topic | Key Concepts |
|--------|-------|--------------|
| 4.1 | Structs | Fields, methods, default values |
| 4.2 | Generics with Comptime | Type parameters, comptime functions |
| 4.3 | ArrayList and HashMap | `std.ArrayList`, `std.HashMap`, iteration |
| 4.4 | Multi-dimensional Arrays | `[][]T`, flat indexing, strides |
| 4.5 | Building a Tensor Type | Shape, dtype, data pointer, views |
| 4.6 | Iterators | Custom iteration, for loop integration |

---

## Module 5: Build System and Project Organization

| Lesson | Topic | Key Concepts |
|--------|-------|--------------|
| 5.1 | Build System Fundamentals | `build.zig` anatomy, steps, options |
| 5.2 | Dependencies with zon | `build.zig.zon`, `zig fetch` |
| 5.3 | Project Organization | Modules, `@import`, pub visibility |
| 5.4 | Cross-compilation | Target triples, release builds |
| 5.5 | Testing Infrastructure | Test blocks, `zig test`, test runners |

---

## Module 6: Standard Library Essentials

| Lesson | Topic | Key Concepts |
|--------|-------|--------------|
| 6.1 | File I/O Deep Dive | `std.fs`, reading/writing files, directories |
| 6.2 | JSON Parsing | `std.json`, parsing, serialization, streaming |
| 6.3 | Compression (zlib/gzip) | `std.compress`, deflate, archives |
| 6.4 | Binary File Formats | Reading binary data, endianness, packed structs |
| 6.5 | CSV and Delimited Data | Custom parsing, streaming, memory efficiency |
| 6.6 | HTTP Client Basics | `std.http.Client`, REST APIs |
| 6.7 | TCP/UDP Sockets | `std.net`, client/server patterns |
| 6.8 | Building a Simple Server | Request handling, concurrency |

---

## Module 7: C Interoperability

| Lesson | Topic | Key Concepts |
|--------|-------|--------------|
| 7.1 | C Interop Basics | `@cImport`, translate-c, extern |
| 7.2 | C Types and Memory | `c_int`, null-terminated strings |
| 7.3 | Linking Libraries | `linkSystemLibrary`, pkg-config |
| 7.4 | BLAS Integration | CBLAS interface, sgemm/sgemv |
| 7.5 | Wrapping C Libraries | Safe Zig wrappers over unsafe C |

---

## Module 8: Hardware Intrinsics and SIMD

| Lesson | Topic | Key Concepts |
|--------|-------|--------------|
| 8.1 | SIMD Fundamentals | Vector registers, data parallelism |
| 8.2 | Zig's @Vector Type | `@Vector(N, T)`, auto-vectorization |
| 8.3 | Platform Detection | `@import("builtin")`, comptime features |
| 8.4 | x86 AVX/AVX2/AVX-512 | 256/512-bit vectors, FMA |
| 8.5 | ARM NEON | 128-bit vectors, Apple Silicon |
| 8.6 | Writing Portable SIMD | Cross-architecture abstractions |

---

## Module 9: Data Processing and Algorithms

| Lesson | Topic | Key Concepts |
|--------|-------|--------------|
| 9.1 | Signal Processing Basics | Convolution, filtering, windowing |
| 9.2 | Savitzky-Golay Filter | Smoothing, derivatives, polynomial fitting |
| 9.3 | Statistics and Linear Algebra | Mean, std, covariance, matrix ops |
| 9.4 | Logistic Regression | Gradient descent, sigmoid, classification |
| 9.5 | K-Means Clustering | Distance metrics, iterative refinement |
| 9.6 | Time Series Processing | Rolling windows, resampling |
| 9.7 | Image Loading (stb_image) | PNG/JPEG via C interop |
| 9.8 | Image Processing Basics | Grayscale, resize, convolution |
| 9.9 | Image Pipeline | Load, process, save workflow |

---

## Module 10: Best Practices and Production Code

| Lesson | Topic | Key Concepts |
|--------|-------|--------------|
| 10.1 | Code Style and zig fmt | Canonical formatting, conventions |
| 10.2 | Documentation | `///` doc comments, generating docs |
| 10.3 | Error Messages | Descriptive error set design |
| 10.4 | Performance Profiling | `-ftime-report`, perf integration |

---

## Module 11: Advanced Topics for ML

| Lesson | Topic | Key Concepts |
|--------|-------|--------------|
| 11.1 | Multi-threading | `std.Thread`, thread pools, atomics |
| 11.2 | Numerical Precision | f16/bf16/f32 conversion, stability |
| 11.3 | Memory-Mapped I/O | Large model loading, mmap patterns |

---

## Capstone Project: ML Inference Engine

### Phase 1: MLP Classifier (Primary Goal)

| Milestone | Deliverable |
|-----------|-------------|
| 1. Safetensors Parser | Load model weights from .safetensors files |
| 2. Tensor Operations | Generic tensor type with basic ops |
| 3. SIMD Kernels | Vectorized element-wise and reduction ops |
| 4. Neural Network Layers | Linear, activation, normalization layers |
| 5. MLP Model | End-to-end inference on a trained model |

### Phase 2: ModernBERT Extension (Stretch Goal)

| Milestone | Deliverable |
|-----------|-------------|
| 6. Transformer | Multi-head attention, encoder blocks, text inference |

### Assessment Criteria

| Criterion | Weight |
|-----------|--------|
| Correctness | 25% |
| Memory Safety | 25% |
| SIMD Optimization | 20% |
| Code Quality | 15% |
| Testing | 15% |

---

## Learning Path Recommendations

- **Fast Track** (experienced systems programmer): Modules 1, 3, 6, 8 → Capstone
- **Standard Path** (Python developer): All modules in order
- **Deep Dive** (thorough understanding): All modules + all exercises + capstone extensions

## Progress Tracking

The AI instructor tracks progress in `progress.json`:

```json
{
  "current_module": 3,
  "current_lesson": 2,
  "completed_exercises": ["01_01", "01_02", "02_01"],
  "capstone_milestone": 0
}
```

Resume anytime by saying: **"Continue where I left off"**
