# Learn Zig: An AI-Instructor-Led Course for Python/ML Developers

An interactive Zig course where an AI instructor (Claude Code) teaches you systems programming, progressing from basics to building an ML inference engine. Designed for Python developers — no prior C/C++/Rust experience required.

See **[CURRICULUM.md](CURRICULUM.md)** for the full course outline.

## Getting Started

1. Install Zig from [ziglang.org/learn/getting-started](https://ziglang.org/learn/getting-started/)
2. Verify: `zig version`
3. Clone and build:
   ```bash
   git clone https://github.com/dleemiller/learn-zig-from-python-ml
   cd learn-zig
   zig build
   ```
4. Start Claude Code in this directory and say: **"Let's begin learning Zig"**

## Prerequisites

- Python proficiency (intermediate+)
- Basic ML concepts (tensors, matrix ops, neural networks)
- A code editor (VS Code with Zig extension recommended)

## Repository Structure

```
learn-zig/
├── CLAUDE.md              # AI instructor configuration
├── CURRICULUM.md          # Full course outline
├── progress.json          # Your learning progress (auto-created)
├── build.zig              # Build system
├── modules/               # Course content (lessons, exercises, instructor guidance)
│   ├── INSTRUCTOR_GUIDELINES.md
│   ├── PEDAGOGICAL_FRAMEWORK.md
│   └── 01_foundations/    # Module 1 (and so on for each module)
├── capstone/              # Final project: ML inference engine
└── src/                   # Student workspace
```

## Manual Study (Without AI)

1. Read lessons in `modules/XX/lessons/`
2. Work on exercises in `modules/XX/exercises/`
3. Run `zig build test-ex-XX-YY` to verify solutions

## License

MIT License — See [LICENSE](LICENSE) for details.
