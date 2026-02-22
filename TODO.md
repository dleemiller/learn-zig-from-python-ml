# Comprehensive TODO List for Zig Learning Curriculum

## Revision Notes

(None currently)

---

## Overview of Completed Work

### Module 1: Foundations (COMPLETE)
- [x] Module README
- [x] 8 lessons with full content
- [x] 8 instructor guidance files with pedagogical framework
- [x] 8 exercises with prompts, starters, solutions, and tests
- [x] Syntax inventory
- [x] Student workspace directory

### Module 2: Functions, Errors, and Optionals (COMPLETE)
- [x] Module README
- [x] 6 lessons with full content
- [x] 6 instructor guidance files with pedagogical framework
- [x] 6 exercises with prompts, starters, solutions, and tests
- [x] Syntax inventory
- [x] Student workspace directory

### Infrastructure (COMPLETE)
- [x] Repository README
- [x] CURRICULUM.md (course overview)
- [x] .gitignore
- [x] INSTRUCTOR_GUIDELINES.md (prime directive: never write code for students)
- [x] PEDAGOGICAL_FRAMEWORK.md (evidence-based teaching strategies)
- [x] ADDING_CURRICULUM.md (guide for creating new modules)
- [x] CURRICULUM_VERIFICATION.md (checklist for verifying curriculum changes)
- [x] resources/python_to_zig_cheatsheet.md

---

## Remaining Work

### Module 3: Memory Management (8 lessons) - CRITICAL MODULE

#### Lessons to Create
- [ ] `lessons/01_stack_heap.md` - Stack vs heap, automatic vs dynamic lifetime
- [ ] `lessons/02_pointers.md` - *T, [*]T, dereferencing, pointer arithmetic
- [ ] `lessons/03_allocator.md` - std.mem.Allocator interface, alloc/free
- [ ] `lessons/04_gpa.md` - GeneralPurposeAllocator, safety checks, leak detection
- [ ] `lessons/05_arena.md` - ArenaAllocator, bulk deallocation
- [ ] `lessons/06_fixed_buffer.md` - FixedBufferAllocator, stack-based allocation
- [ ] `lessons/07_ml_patterns.md` - Per-inference arenas, weight persistence patterns
- [ ] `lessons/08_debugging.md` - std.testing.allocator, valgrind, debugging leaks

#### Instructor Guidance
- [ ] `instructor/01_guidance.md` through `instructor/08_guidance.md`
- **Note**: This module requires extra care - memory management is the hardest concept for Python developers

#### Exercises
- [ ] `exercises/01_stack_heap/` - Understanding memory lifetime
- [ ] `exercises/02_pointers/` - Pointer operations
- [ ] `exercises/03_allocator/` - Basic allocation/deallocation
- [ ] `exercises/04_gpa/` - Using GPA with leak detection
- [ ] `exercises/05_arena/` - Arena-scoped allocations
- [ ] `exercises/06_fixed_buffer/` - No-heap patterns
- [ ] `exercises/07_ml_patterns/` - ML-specific memory patterns
- [ ] `exercises/08_debugging/` - Finding and fixing memory issues

---

### Module 4: Data Structures and Generics (6 lessons)

#### Lessons to Create
- [ ] `lessons/01_structs.md` - Fields, methods, default values
- [ ] `lessons/02_generics.md` - Type parameters, comptime functions
- [ ] `lessons/03_collections.md` - ArrayList, HashMap, iteration
- [ ] `lessons/04_multidim.md` - Multi-dimensional arrays, flat indexing, strides
- [ ] `lessons/05_tensor.md` - Building a Tensor type (shape, dtype, data pointer)
- [ ] `lessons/06_iterators.md` - Custom iteration, for loop integration

#### Instructor Guidance
- [ ] `instructor/01_guidance.md` through `instructor/06_guidance.md`

#### Exercises
- [ ] `exercises/01_structs/` - Struct definition and methods
- [ ] `exercises/02_generics/` - Generic data structures
- [ ] `exercises/03_collections/` - ArrayList and HashMap usage
- [ ] `exercises/04_multidim/` - 2D array operations
- [ ] `exercises/05_tensor/` - Tensor implementation
- [ ] `exercises/06_iterators/` - Custom iterator

---

### Module 5: Build System and Project Organization (5 lessons)

#### Lessons to Create
- [ ] `lessons/01_build_basics.md` - build.zig anatomy, steps, options
- [ ] `lessons/02_dependencies.md` - build.zig.zon, zig fetch
- [ ] `lessons/03_modules.md` - @import, pub visibility, organization
- [ ] `lessons/04_cross_compile.md` - Target triples, release builds
- [ ] `lessons/05_testing.md` - Test blocks, zig test, test runners

#### Instructor Guidance
- [ ] `instructor/01_guidance.md` through `instructor/05_guidance.md`

#### Exercises
- [ ] `exercises/01_build_basics/` - Modify build.zig
- [ ] `exercises/02_dependencies/` - Add a dependency
- [ ] `exercises/03_modules/` - Multi-file project
- [ ] `exercises/04_cross_compile/` - Cross-compile demonstration
- [ ] `exercises/05_testing/` - Test organization

---

### Module 6: Standard Library Essentials (8 lessons)

#### Lessons to Create
- [ ] `lessons/01_file_io.md` - std.fs, reading/writing files
- [ ] `lessons/02_json.md` - std.json, parsing, serialization
- [ ] `lessons/03_compression.md` - std.compress, zlib, gzip
- [ ] `lessons/04_binary.md` - Binary formats, endianness, packed structs
- [ ] `lessons/05_csv.md` - CSV parsing, streaming
- [ ] `lessons/06_http.md` - std.http.Client, REST APIs
- [ ] `lessons/07_sockets.md` - std.net, TCP/UDP
- [ ] `lessons/08_server.md` - Simple server, request handling

#### Instructor Guidance
- [ ] `instructor/01_guidance.md` through `instructor/08_guidance.md`

#### Exercises
- [ ] `exercises/01_file_io/` - Read/write files
- [ ] `exercises/02_json/` - Parse JSON config
- [ ] `exercises/03_compression/` - Decompress gzip
- [ ] `exercises/04_binary/` - Parse binary format
- [ ] `exercises/05_csv/` - CSV reader
- [ ] `exercises/06_http/` - HTTP client
- [ ] `exercises/07_sockets/` - Socket client
- [ ] `exercises/08_server/` - Echo server

---

### Module 7: C Interoperability (5 lessons)

#### Lessons to Create
- [ ] `lessons/01_c_basics.md` - @cImport, translate-c, extern
- [ ] `lessons/02_c_types.md` - c_int, null-terminated strings
- [ ] `lessons/03_linking.md` - linkSystemLibrary, pkg-config
- [ ] `lessons/04_blas.md` - CBLAS interface, sgemm/sgemv
- [ ] `lessons/05_wrappers.md` - Safe Zig wrappers over C

#### Instructor Guidance
- [ ] `instructor/01_guidance.md` through `instructor/05_guidance.md`

#### Exercises
- [ ] `exercises/01_c_basics/` - Call libc function
- [ ] `exercises/02_c_types/` - String conversion
- [ ] `exercises/03_linking/` - Link system library
- [ ] `exercises/04_blas/` - BLAS matrix multiply
- [ ] `exercises/05_wrappers/` - Create safe wrapper

---

### Module 8: Hardware Intrinsics and SIMD (6 lessons)

#### Lessons to Create
- [ ] `lessons/01_simd_basics.md` - Vector registers, data parallelism
- [ ] `lessons/02_vector_type.md` - @Vector(N, T), operations
- [ ] `lessons/03_platform.md` - @import("builtin"), feature detection
- [ ] `lessons/04_avx.md` - x86 AVX/AVX2/AVX-512
- [ ] `lessons/05_neon.md` - ARM NEON
- [ ] `lessons/06_portable_simd.md` - Cross-platform abstractions

#### Instructor Guidance
- [ ] `instructor/01_guidance.md` through `instructor/06_guidance.md`

#### Exercises
- [ ] `exercises/01_simd_basics/` - Understand vectorization
- [ ] `exercises/02_vector_type/` - @Vector operations
- [ ] `exercises/03_platform/` - Feature detection
- [ ] `exercises/04_avx/` - AVX implementation
- [ ] `exercises/05_neon/` - NEON implementation
- [ ] `exercises/06_portable_simd/` - Portable dot product

---

### Module 9: Data Processing and Algorithms (9 lessons)

#### Lessons to Create
- [ ] `lessons/01_signal.md` - Convolution, filtering, windowing
- [ ] `lessons/02_savgol.md` - Savitzky-Golay filter
- [ ] `lessons/03_statistics.md` - Mean, std, covariance, matrix ops
- [ ] `lessons/04_logistic.md` - Logistic regression from scratch
- [ ] `lessons/05_kmeans.md` - K-means clustering
- [ ] `lessons/06_timeseries.md` - Rolling windows, resampling
- [ ] `lessons/07_image_load.md` - stb_image integration
- [ ] `lessons/08_image_proc.md` - Grayscale, resize, convolution
- [ ] `lessons/09_image_pipeline.md` - Full image processing pipeline

#### Instructor Guidance
- [ ] `instructor/01_guidance.md` through `instructor/09_guidance.md`

#### Exercises
- [ ] `exercises/01_signal/` - Convolution implementation
- [ ] `exercises/02_savgol/` - Savitzky-Golay filter
- [ ] `exercises/03_statistics/` - Stats functions
- [ ] `exercises/04_logistic/` - Train logistic regression
- [ ] `exercises/05_kmeans/` - K-means implementation
- [ ] `exercises/06_timeseries/` - Time series processing
- [ ] `exercises/07_image_load/` - Load image with stb
- [ ] `exercises/08_image_proc/` - Image filters
- [ ] `exercises/09_image_pipeline/` - Complete pipeline

---

### Module 10: Best Practices and Production Code (4 lessons)

#### Lessons to Create
- [ ] `lessons/01_style.md` - zig fmt, naming conventions
- [ ] `lessons/02_docs.md` - /// doc comments, generating docs
- [ ] `lessons/03_error_design.md` - Error set design
- [ ] `lessons/04_profiling.md` - -ftime-report, perf

#### Instructor Guidance
- [ ] `instructor/01_guidance.md` through `instructor/04_guidance.md`

#### Exercises
- [ ] `exercises/01_style/` - Format and fix code
- [ ] `exercises/02_docs/` - Add documentation
- [ ] `exercises/03_error_design/` - Design error sets
- [ ] `exercises/04_profiling/` - Profile and optimize

---

### Module 11: Advanced Topics for ML (3 lessons)

#### Lessons to Create
- [ ] `lessons/01_threading.md` - std.Thread, thread pools, atomics
- [ ] `lessons/02_precision.md` - f16/bf16/f32 conversion, numerical stability
- [ ] `lessons/03_mmap.md` - Memory-mapped I/O for large models

#### Instructor Guidance
- [ ] `instructor/01_guidance.md` through `instructor/03_guidance.md`

#### Exercises
- [ ] `exercises/01_threading/` - Parallel matrix multiply
- [ ] `exercises/02_precision/` - Precision conversion
- [ ] `exercises/03_mmap/` - mmap model loading

---

### Capstone Project: ML Inference Engine

#### Core Structure
- [ ] `capstone/README.md` - Project overview
- [ ] `capstone/student_workspace/.gitkeep`

#### Instructor Guidance
- [ ] `capstone/instructor/overview.md` - Capstone teaching strategy
- [ ] `capstone/instructor/milestone_guidance/01_safetensors.md`
- [ ] `capstone/instructor/milestone_guidance/02_tensor_ops.md`
- [ ] `capstone/instructor/milestone_guidance/03_simd_kernels.md`
- [ ] `capstone/instructor/milestone_guidance/04_layers.md`
- [ ] `capstone/instructor/milestone_guidance/05_mlp_model.md`
- [ ] `capstone/instructor/milestone_guidance/06_transformer.md`

#### Milestone 1: Safetensors Parser
- [ ] `capstone/milestones/01_safetensors/spec.md`
- [ ] `capstone/milestones/01_safetensors/starter/`
- [ ] `capstone/milestones/01_safetensors/reference/`
- [ ] `capstone/milestones/01_safetensors/tests.zig`

#### Milestone 2: Tensor Operations
- [ ] `capstone/milestones/02_tensor_ops/spec.md`
- [ ] `capstone/milestones/02_tensor_ops/starter/`
- [ ] `capstone/milestones/02_tensor_ops/reference/`
- [ ] `capstone/milestones/02_tensor_ops/tests.zig`

#### Milestone 3: SIMD Kernels
- [ ] `capstone/milestones/03_simd_kernels/spec.md`
- [ ] `capstone/milestones/03_simd_kernels/starter/`
- [ ] `capstone/milestones/03_simd_kernels/reference/`
- [ ] `capstone/milestones/03_simd_kernels/tests.zig`

#### Milestone 4: Neural Network Layers
- [ ] `capstone/milestones/04_layers/spec.md`
- [ ] `capstone/milestones/04_layers/starter/`
- [ ] `capstone/milestones/04_layers/reference/`
- [ ] `capstone/milestones/04_layers/tests.zig`

#### Milestone 5: MLP Model (Primary)
- [ ] `capstone/milestones/05_mlp_model/spec.md`
- [ ] `capstone/milestones/05_mlp_model/starter/`
- [ ] `capstone/milestones/05_mlp_model/reference/`
- [ ] `capstone/milestones/05_mlp_model/tests.zig`

#### Milestone 6: Transformer Extension (Stretch)
- [ ] `capstone/milestones/06_transformer/spec.md`
- [ ] `capstone/milestones/06_transformer/starter/`
- [ ] `capstone/milestones/06_transformer/reference/`
- [ ] `capstone/milestones/06_transformer/tests.zig`

#### Test Models
- [ ] `capstone/test_models/test_mlp.safetensors` - Small MLP
- [ ] `capstone/test_models/test_bert_tiny.safetensors` - Tiny transformer

---

### Tools

- [ ] `tools/verify.zig` - Exercise verification utility
- [ ] `tools/check_progress.zig` - Progress tracking utility

---

### Resources (Additional)

- [ ] `resources/memory_patterns.md` - Memory management patterns reference
- [ ] `resources/simd_reference.md` - SIMD instruction reference
- [ ] `resources/blas_reference.md` - BLAS function reference

---

## Summary Statistics

| Component | Total Items | Completed | Remaining |
|-----------|-------------|-----------|-----------|
| Modules | 11 | 2 | 9 |
| Lessons | 65 | 14 | 51 |
| Exercises | ~65 | 14 | ~51 |
| Instructor Guides | ~65 | 14 | ~51 |
| Capstone Milestones | 6 | 0 | 6 |
| Tools | 2 | 0 | 2 |
| Resources | 4 | 1 | 3 |

---

## Priority Order

1. **Module 3 (Memory Management)** - Most critical for Python developers
2. **Module 4 (Data Structures)** - Enables tensor work
3. **Tools (verify.zig, check_progress.zig)** - Enable progress tracking
4. **Module 5 (Build System)** - Project organization
5. **Module 6 (Standard Library)** - Practical capabilities
6. **Module 7 (C Interop)** - BLAS enablement
7. **Module 8 (SIMD)** - Performance optimization
8. **Module 9 (Data Processing)** - Algorithm implementations
9. **Module 10 (Best Practices)** - Production readiness
10. **Module 11 (Advanced ML)** - Capstone preparation
11. **Capstone Project** - Final integration

---

## Notes for Implementation

### Pedagogical Consistency
Every module must follow the established patterns:
- Reference INSTRUCTOR_GUIDELINES.md and PEDAGOGICAL_FRAMEWORK.md
- Include PRIMM model application where applicable
- Include Python bridge points in every lesson
- Never provide direct solutions in instructor guidance

### Testing Strategy
Each exercise should have:
- `prompt.md` - Clear requirements
- `starter.zig` - Scaffolded code with TODOs
- `solution.zig` - Reference implementation (for verification only)
- `tests.zig` - Automated verification

### Module READMEs
Each module needs its own README.md with:
- Learning objectives
- Prerequisites
- Lesson overview
- Exercise summary
- Key Python → Zig concepts
