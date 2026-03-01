# Lesson 3.7: Memory Patterns for ML

## Learning Objectives

- [ ] Design memory lifecycle for ML workloads (load → infer → repeat)
- [ ] Apply the weight persistence pattern (alloc once, use many times)
- [ ] Use per-inference arenas for scratch memory
- [ ] Combine the two-allocator pattern in a realistic ML context
- [ ] Plan memory budgets for model deployment

## Prerequisites

- Completed Lessons 3.3–3.6 (all allocator types)
- Comfortable with struct `init`/`deinit` pattern (Lesson 3.4)
- Understand the two-allocator pattern (Lesson 3.5)

## The ML Memory Lifecycle

ML inference has a predictable memory pattern:

```
1. LOAD: Allocate weights (once, long-lived)
2. INFER: Allocate scratch space (per-inference, short-lived)
3. REPEAT: Reset scratch, reuse weights
4. SHUTDOWN: Free everything
```

This maps perfectly to Zig's allocator model:

| Phase | Allocator | Lifetime |
|-------|-----------|----------|
| Load weights | GPA or backing allocator | Entire program |
| Inference scratch | Arena | One inference |
| Results | Backing allocator | Until caller frees |

In Python, you don't think about this:

```python
model = load_model("weights.bin")        # Heap, GC-managed
for batch in data:
    result = model.predict(batch)         # Temporaries created, GC'd later
    # torch.cuda.empty_cache()            # Maybe hint GPU to free
```

In Zig, you make these decisions explicit.

## Pattern 1: Weight Persistence

Weights are loaded once and used for every inference. They should be allocated with the main allocator and freed at shutdown:

```zig
const Model = struct {
    weights: []f64,
    bias: []f64,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, input_size: usize, output_size: usize) !Model {
        const weights = try allocator.alloc(f64, input_size * output_size);
        errdefer allocator.free(weights);

        const bias = try allocator.alloc(f64, output_size);

        // Initialize to zeros
        @memset(weights, 0.0);
        @memset(bias, 0.0);

        return .{
            .weights = weights,
            .bias = bias,
            .allocator = allocator,
        };
    }

    pub fn deinit(self: *Model) void {
        self.allocator.free(self.weights);
        self.allocator.free(self.bias);
    }
};
```

The `errdefer` on `weights` is critical: if `bias` allocation fails, `weights` would leak without it.

## Pattern 2: Per-Inference Arena

Each inference needs temporary buffers. An arena is perfect:

```zig
pub fn predict(self: *const Model, backing: std.mem.Allocator, input: []const f64) ![]f64 {
    // Scratch arena for temporary computation
    var arena = std.heap.ArenaAllocator.init(backing);
    defer arena.deinit();
    const scratch = arena.allocator();

    // Temporary: intermediate computation
    const hidden = try scratch.alloc(f64, self.bias.len);
    // ... compute hidden = input * weights + bias ...

    // Result: allocated from BACKING (survives arena deinit)
    const output = try backing.alloc(f64, self.bias.len);
    @memcpy(output, hidden);

    return output;  // Caller frees this
}
```

**Why this works**:
- `hidden` (temporary) is freed by `arena.deinit()` — no manual cleanup
- `output` (result) lives on the backing allocator — returned to caller
- Each call starts with a fresh arena — no cross-inference contamination

## Pattern 3: Arena Reset for Batches

When processing many inferences, reset the arena instead of recreating it:

```zig
fn inferBatch(model: *const Model, backing: std.mem.Allocator, batches: []const []const f64) !void {
    var arena = std.heap.ArenaAllocator.init(backing);
    defer arena.deinit();
    const scratch = arena.allocator();

    for (batches) |input| {
        // Allocate scratch for this inference
        const temp = try scratch.alloc(f64, model.bias.len);
        _ = temp;
        // ... process ...

        // Reset arena for next inference (keeps underlying memory)
        arena.reset(.retain_capacity);
    }
}
```

`reset(.retain_capacity)` frees all arena allocations but keeps the memory buffer. The next iteration reuses it — no new OS allocations.

## Pattern 4: Memory Budget Planning

For deployment, you need to know how much memory your model uses:

```zig
// A simple budget calculation
const input_size: usize = 768;
const output_size: usize = 10;

// Persistent memory (weights + bias)
const weight_bytes = input_size * output_size * @sizeOf(f64);
const bias_bytes = output_size * @sizeOf(f64);
const persistent = weight_bytes + bias_bytes;

// Per-inference scratch
const scratch_per_inference = output_size * @sizeOf(f64);

// Total for one concurrent inference
const total = persistent + scratch_per_inference;
```

In Python, you'd use `torch.cuda.memory_summary()` or `sys.getsizeof()`. In Zig, you can compute it exactly because you control every allocation.

## Putting It All Together

Here's the full lifecycle:

```zig
pub fn main() !void {
    // 1. Create the main allocator
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const check = gpa.deinit();
        if (check == .leak) std.debug.print("Memory leak!\n", .{});
    }
    const allocator = gpa.allocator();

    // 2. Load model (persistent memory)
    var model = try Model.init(allocator, 768, 10);
    defer model.deinit();

    // 3. Run inferences (temporary memory via arena)
    const input = try allocator.alloc(f64, 768);
    defer allocator.free(input);
    @memset(input, 1.0);

    const result = try model.predict(allocator, input);
    defer allocator.free(result);

    // 4. Shutdown: defers run in reverse order
    //    - free result
    //    - free input
    //    - model.deinit (frees weights + bias)
    //    - gpa.deinit (checks for leaks)
}
```

## For Python Developers

| Python | Zig | Notes |
|--------|-----|-------|
| `model = load_model()` | `Model.init(allocator, ...)` | Explicit allocation |
| GC cleans up temps | `arena.deinit()` | Explicit cleanup |
| `torch.cuda.empty_cache()` | `arena.reset(.retain_capacity)` | Explicit reuse |
| `sys.getsizeof()` | `@sizeOf(T) * count` | Exact calculation |
| Memory profiler | GPA leak detection | Built-in |
| NumPy broadcasting creates temps | Arena scratch for temps | You manage them |

### Key Insight

The ML memory lifecycle is actually simpler than general programming: weights are static, scratch is per-request, results are handed off. Zig's allocator model matches this perfectly. In Python, the GC handles it invisibly — which means you have less control when memory matters (large models, many concurrent inferences, embedded deployment).

## Common Mistakes

1. **Allocating weights from an arena** — Weights need to persist. Use the backing allocator.
2. **Returning arena-allocated results** — Results must outlive the arena. Allocate from backing.
3. **Forgetting `errdefer` in model init** — If bias allocation fails, weights leak.
4. **Not resetting arena between inferences** — Memory grows unbounded per inference.
5. **Over-engineering the memory model** — Start simple. You can always add arenas later if performance demands it.

## Self-Check Questions

1. Which allocator should hold model weights — arena or backing?
2. Why use an arena for per-inference scratch work?
3. What does `arena.reset(.retain_capacity)` do between inferences?
4. In `predict()`, why is the result allocated from `backing` instead of `scratch`?
5. How would you calculate the total memory budget for a model?

## Exercises

Practice these concepts in [Exercise 3.7](../exercises/07_ml_patterns/prompt.md).
