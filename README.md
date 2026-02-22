# Learn Zig: A Curriculum for Python/ML Developers

A comprehensive, interactive Zig course designed specifically for Python developers working in ML and data science. This curriculum bridges your Python knowledge to systems programming, culminating in building an ML inference engine.

## Why This Course?

As a Python developer in ML, you're used to high-level abstractions that hide memory management, compilation, and hardware details. Zig offers:

- **Predictable Performance**: No hidden allocations, no garbage collector pauses
- **Memory Safety**: Compile-time checks catch bugs before runtime
- **Hardware Access**: Direct SIMD/vectorization for ML kernels
- **C Interop**: Use existing C libraries (BLAS, image processing) seamlessly
- **Simplicity**: No hidden control flow, no operator overloading surprises

## Target Audience

- Python developers with ML/data science experience
- Comfortable with NumPy, PyTorch, or similar frameworks
- Curious about systems programming and performance optimization
- No prior C/C++/Rust experience required

## Prerequisites

- Python proficiency (intermediate+)
- Basic understanding of ML concepts (tensors, matrix operations, neural networks)
- Familiarity with command-line tools
- A code editor (VS Code with Zig extension recommended)

## Setup

### Install Zig

**Check [ziglang.org/learn/getting-started](https://ziglang.org/learn/getting-started/) for current installation instructions.**

The download page has platform-specific commands including curl one-liners for Linux.

**Verify installation:**
```bash
zig version
# Should show the current stable version
```

### Clone This Repository

```bash
git clone https://github.com/your-username/learn-zig.git
cd learn-zig
```

### Verify Build

```bash
zig build
# Should complete without errors
```

## How to Use This Course

This curriculum is designed for **AI-assisted interactive learning**. You'll work with an AI CLI tool (like Claude Code) that acts as your instructor.

### Getting Started

1. **Start your AI assistant** in this directory
2. **Say**: "I want to start learning Zig" or "Let's begin Module 1"
3. **The AI will**:
   - Read the curriculum structure
   - Guide you through lessons conversationally
   - Present exercises and help when you're stuck
   - Verify your solutions and provide feedback

### Typical Session Flow

```
You: "I'm ready for lesson 1.3"

AI: [Reads lesson content and instructor guidance]
    "Great! In this lesson we'll write your first Zig program..."
    [Teaches concepts, shows examples]

You: "I think I understand. What's the exercise?"

AI: [Reads exercise prompt, copies starter to workspace]
    "Try implementing X. I've set up the starter code in..."

You: [Write code, ask questions as needed]

AI: [Runs tests, provides feedback]
    "Almost! Look at line 15 - remember that in Zig..."
```

### Manual Study (Without AI)

You can also study independently:
1. Read `modules/XX/lessons/YY_topic.md` for content
2. Copy exercise starters to `modules/XX/student_workspace/`
3. Run `zig build test-ex-XX-YY` to verify solutions
4. Check `exercises/XX/solution.zig` if stuck (try not to peek!)

## Course Structure

See [CURRICULUM.md](CURRICULUM.md) for the complete curriculum overview.

### Modules Overview

| Module | Topic | Lessons | Focus |
|--------|-------|---------|-------|
| 1 | Foundations | 8 | Syntax, types, control flow |
| 2 | Functions & Errors | 6 | Error handling, optionals |
| 3 | Memory Management | 8 | Allocators, pointers (critical!) |
| 4 | Data Structures | 6 | Generics, collections, tensors |
| 5 | Build System | 5 | Project organization |
| 6 | Standard Library | 8 | I/O, JSON, HTTP, networking |
| 7 | C Interoperability | 5 | FFI, BLAS integration |
| 8 | Hardware Intrinsics | 6 | SIMD, AVX, NEON |
| 9 | Data Processing | 9 | Algorithms, image processing |
| 10 | Best Practices | 4 | Style, docs, profiling |
| 11 | Advanced ML | 3 | Threading, precision, mmap |

### Capstone Project

Build a working ML inference engine:
- Parse safetensors model files
- Implement tensor operations with SIMD
- Build neural network layers
- Run MLP inference (primary goal)
- Extend to transformer architecture (stretch goal)

## Repository Structure

```
learn-zig/
├── README.md                 # This file
├── CURRICULUM.md             # Full curriculum details
├── build.zig                 # Build system
├── modules/                  # Course content
│   ├── 01_foundations/
│   │   ├── README.md         # Module overview
│   │   ├── lessons/          # Lesson content
│   │   ├── instructor/       # AI teaching guidance
│   │   ├── exercises/        # Coding exercises
│   │   └── student_workspace/# Your work (gitignored)
│   └── ...
├── capstone/                 # Final project
├── tools/                    # Verification utilities
└── resources/                # Reference materials
```

## Getting Help

- **During exercises**: Ask your AI assistant for hints
- **General questions**: The AI can explain any concept
- **Course issues**: Open an issue on GitHub
- **Zig community**: [Ziggit](https://ziggit.dev), [Discord](https://discord.gg/zig)

## License

MIT License - See [LICENSE](LICENSE) for details.

---

Ready to start? Open your AI assistant and say: **"Let's begin learning Zig!"**
