# Exercise 3.7: Memory Patterns for ML

## Objective

Build a `SimpleModel` struct that demonstrates ML memory patterns: weight persistence (alloc once, free at shutdown), per-inference arena scratch, and the two-allocator pattern.

## Requirements

1. Implement `SimpleModel.init` — allocate weights and bias, initialize them
2. Implement `SimpleModel.deinit` — free weights and bias
3. Implement `SimpleModel.predict` — compute output using arena scratch, return result from result allocator

## Details

### `SimpleModel` struct
- Fields: `weights: []f64`, `bias: []f64`, `input_size: usize`, `output_size: usize`, `allocator: std.mem.Allocator`

### `SimpleModel.init(allocator, input_size, output_size) !SimpleModel`
- Allocate weights: `input_size * output_size` f64 values, fill with 0.1
- Allocate bias: `output_size` f64 values, fill with 0.0
- Use `errdefer` to free weights if bias allocation fails
- Store all fields including the allocator

### `SimpleModel.deinit(self: *SimpleModel) void`
- Free both weights and bias

### `SimpleModel.predict(self: SimpleModel, result_allocator: std.mem.Allocator, input: []const f64) ![]f64`
- Create an arena from `result_allocator` for scratch work
- Allocate scratch buffer of `output_size` from the arena
- Compute: for each output j, `scratch[j] = bias[j] + sum(input[i] * weights[i * output_size + j])` for all i
- Allocate result of `output_size` from `result_allocator` (NOT the arena)
- Copy scratch into result
- Return result (caller owns this memory)

## Syntax Reference

- `const Name = struct { ... };` — struct definition (Module 2)
- `errdefer allocator.free(slice)` — cleanup on error (Module 2, Lesson 3.4)
- `std.heap.ArenaAllocator.init(backing)` — create arena (Lesson 3.5)
- `defer arena.deinit();` — arena cleanup (Lesson 3.5)
- `try allocator.alloc(f64, n)` — allocate (Lesson 3.3)
- `@memset(slice, value)` — fill memory (Lesson 3.3)
- `@memcpy(dest, src)` — copy memory (Lesson 3.3)

## Concepts Tested

- Resource-owning struct with init/deinit
- errdefer for partial initialization cleanup
- Per-inference arena for scratch work
- Two-allocator pattern (arena scratch + result allocator)
- ML weight persistence pattern

## Verification

```bash
zig test tests.zig
```
