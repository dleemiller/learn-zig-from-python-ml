# Lesson 1.1: Why Zig for ML?

## Learning Objectives

- [ ] Understand Zig's value proposition for ML/systems work
- [ ] Compare Zig's approach to Python's abstractions
- [ ] Recognize where Zig excels vs where Python is better
- [ ] Understand compile-time vs runtime guarantees

## For Python Developers

As a Python developer in ML, you've likely experienced:

- **Slow Python loops** forcing you to vectorize everything
- **Memory issues** with large datasets or models
- **Deployment challenges** (packaging, dependencies, cold starts)
- **C extension complexity** when you need performance

Zig addresses these pain points while remaining simpler than C/C++.

## The Case for Zig

### 1. Performance Without Complexity

**Python (NumPy) approach:**
```python
# Fast because NumPy is C under the hood
result = np.dot(weights, input) + bias
```

**Zig approach:**
```zig
// Also fast, but you see exactly what happens
fn forward(weights: []const f32, input: []const f32, bias: f32) f32 {
    var sum: f32 = bias;
    for (weights, input) |w, x| {
        sum += w * x;
    }
    return sum;
}
```

The Zig version:
- No hidden allocations
- Predictable memory layout
- Compiles to efficient machine code
- Works without a runtime

### 2. No Hidden Control Flow

In Python, many operations hide complexity:

```python
# What actually happens here?
model = load_model("weights.pt")  # File I/O? Network? Decompression?
output = model(input)             # GPU? CPU? What precision?
```

In Zig, everything is explicit:

```zig
// You see exactly what happens
const model = try loadSafetensors(allocator, "weights.st");
defer model.deinit();

const output = model.forward(input);
```

This explicitness helps when:
- Debugging performance issues
- Deploying to constrained environments
- Understanding memory usage

### 3. Compile-Time Guarantees

Zig catches errors before your code runs:

```zig
// This won't compile - type mismatch
const x: i32 = 3.14;  // Error: expected i32, found f64

// This won't compile - potential overflow
const y: u8 = 300;    // Error: 300 cannot fit in u8

// This won't compile - array bounds
const arr = [3]i32{ 1, 2, 3 };
const val = arr[5];   // Error: index out of bounds
```

Compare to Python where these would only fail at runtime (if at all).

### 4. Memory Control

Python hides memory management:
```python
# Where does this memory come from? When is it freed?
data = np.zeros((1000000, 1000), dtype=np.float32)
```

Zig makes it explicit:
```zig
// Clear ownership: you allocate, you free
const data = try allocator.alloc(f32, 1000000 * 1000);
defer allocator.free(data);
// Memory freed when scope exits
```

For ML, this matters for:
- Loading large models efficiently
- Per-request inference memory
- Avoiding GC pauses in production

### 5. Easy C Interop

Need BLAS for fast matrix operations?

```zig
const c = @cImport({
    @cInclude("cblas.h");
});

// Call C BLAS directly
c.cblas_sgemv(
    c.CblasRowMajor,
    c.CblasNoTrans,
    m, n, 1.0,
    A, n, x, 1, 0.0, y, 1
);
```

No bindings to write. No compilation nightmares. Just import and use.

## When to Use Zig vs Python

| Use Zig | Use Python |
|---------|------------|
| Production inference servers | Exploratory data analysis |
| Real-time processing | Quick prototyping |
| Embedded/edge deployment | Training with PyTorch/JAX |
| Performance-critical kernels | Visualization and notebooks |
| Small binary, fast startup | Ecosystem/library access |

The sweet spot: **Train in Python, deploy in Zig**.

## Zig's Philosophy

1. **No hidden allocations** - Memory operations are explicit
2. **No hidden control flow** - No operator overloading, no exceptions
3. **Readability** - Local reasoning, code means what it says
4. **Compile-time metaprogramming** - Generics via `comptime`, not templates
5. **Easy C interop** - Direct `@cImport`, no bindings needed

## What You'll Build

By the end of this course, you'll create an ML inference engine that:

1. **Parses safetensors** - Load model weights
2. **Implements tensor ops** - With SIMD optimization
3. **Runs forward passes** - MLP and transformer architectures
4. **Handles memory efficiently** - Arena allocators for inference

All in pure Zig, with C interop for BLAS when needed.

## Common Questions

**Q: Is Zig hard to learn coming from Python?**

The main adjustments:
- Explicit types everywhere (but with inference)
- Manual memory management (but with safe patterns)
- No classes/OOP (structs with methods instead)

The payoff: Predictable performance, easier debugging.

**Q: Can I use my existing Python models?**

Yes! Export to safetensors or ONNX, load in Zig for inference. Keep training in Python.

**Q: Is Zig production-ready?**

Zig is used in production at Uber, Cloudflare, and others. Version 1.0 is still approaching, but the current stable releases are solid for learning and building real projects.

## Self-Check

Before moving on, make sure you can answer:

1. What are two advantages of Zig's explicit memory management for ML?
2. Why does "no hidden control flow" matter for debugging?
3. When would you still prefer Python over Zig?

## Next Steps

In the next lesson, we'll set up your Zig development environment and verify everything works.

→ Continue to [Lesson 1.2: Environment Setup](02_setup.md)
