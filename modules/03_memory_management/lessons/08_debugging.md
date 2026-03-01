# Lesson 3.8: Debugging Memory Issues

## Learning Objectives

- [ ] Use `std.testing.allocator` for leak detection in tests
- [ ] Read and interpret GPA leak reports
- [ ] Recognize common memory bugs: leaks, double-free, use-after-free
- [ ] Apply a systematic debugging checklist
- [ ] Know when and how to use valgrind

## Prerequisites

- Completed Lessons 3.1–3.7 (all memory concepts)
- Comfortable with allocators, defer, errdefer
- Familiar with `zig test`

## `std.testing.allocator`: Your Best Friend

You've been using `std.testing.allocator` in exercises. Now let's understand what it does.

`std.testing.allocator` is a special allocator that:
- Tracks every allocation and deallocation
- Fails the test if any memory is leaked
- Reports exactly what was leaked

```zig
test "leak detection demo" {
    const allocator = std.testing.allocator;

    const data = try allocator.alloc(u8, 100);
    // Oops — forgot allocator.free(data)!
    _ = data;
    // Test FAILS: "memory leak detected"
}
```

This is why all exercise tests use `std.testing.allocator` — it catches leaks automatically.

## How `std.testing.allocator` Works

Under the hood, `std.testing.allocator` is a GPA with leak checking. When the test ends:
1. It checks if all allocations were freed
2. If not, it reports the leak and fails the test
3. The report shows how many bytes leaked

This is like Python's `tracemalloc`, but integrated into the test framework.

## Reading Leak Reports

When a test leects a leak, you'll see something like:

```
Test [1/1] test "my test"... [gpa] (err): memory address 0x... has no matching deallocation
[gpa] (err): allocation trace:
...
FAIL (leaked 100 bytes)
```

This tells you:
- How many bytes leaked
- Where the allocation happened (with stack traces in debug builds)

## The Five Common Memory Bugs

### Bug 1: Memory Leak

**Symptom**: Test fails with "memory leak detected"
**Cause**: Allocated memory was never freed
**Fix**: Add `defer allocator.free(data)` or `errdefer allocator.free(data)`

```zig
// BUGGY
fn leaky(allocator: std.mem.Allocator) ![]i32 {
    const temp = try allocator.alloc(i32, 10);
    const result = try allocator.alloc(i32, 5);
    // temp is never freed!
    @memcpy(result, temp[0..5]);
    return result;
}

// FIXED
fn fixed(allocator: std.mem.Allocator) ![]i32 {
    const temp = try allocator.alloc(i32, 10);
    defer allocator.free(temp);   // Always free scratch data
    const result = try allocator.alloc(i32, 5);
    errdefer allocator.free(result);
    @memcpy(result, temp[0..5]);
    return result;
}
```

### Bug 2: Missing `errdefer`

**Symptom**: Leak only on error paths (hard to catch without testing.allocator)
**Cause**: Early return on error doesn't free partial allocations
**Fix**: Add `errdefer` after each allocation that might need cleanup on error

```zig
// BUGGY — if step2 fails, data from step1 leaks
fn risky(allocator: std.mem.Allocator) !Result {
    const a = try allocator.alloc(u8, 100);
    const b = try allocator.alloc(u8, 200);  // If this fails, 'a' leaks
    return .{ .a = a, .b = b };
}

// FIXED
fn safe(allocator: std.mem.Allocator) !Result {
    const a = try allocator.alloc(u8, 100);
    errdefer allocator.free(a);              // Clean up 'a' if 'b' fails
    const b = try allocator.alloc(u8, 200);
    return .{ .a = a, .b = b };
}
```

### Bug 3: Use-After-Free

**Symptom**: Garbage data, crashes, or undefined behavior
**Cause**: Accessing memory that was already freed
**Fix**: Ensure data outlives all references to it

```zig
// BUGGY — returning data from a scope where it was freed
fn useAfterFree(backing: std.mem.Allocator) ![]i32 {
    var arena = std.heap.ArenaAllocator.init(backing);
    defer arena.deinit();

    const result = try arena.allocator().alloc(i32, 10);
    return result;  // DANGER: arena.deinit() frees this!
}

// FIXED — allocate result from backing allocator
fn correct(backing: std.mem.Allocator) ![]i32 {
    var arena = std.heap.ArenaAllocator.init(backing);
    defer arena.deinit();

    const temp = try arena.allocator().alloc(i32, 10);
    // ... work with temp ...

    const result = try backing.alloc(i32, 10);
    @memcpy(result, temp);
    return result;  // Safe: allocated from backing, not arena
}
```

### Bug 4: Double Free

**Symptom**: Crash or "invalid free" error
**Cause**: Freeing the same memory twice
**Fix**: Ensure each allocation is freed exactly once

```zig
// BUGGY
fn doubleFree(allocator: std.mem.Allocator) !void {
    const data = try allocator.alloc(u8, 100);
    defer allocator.free(data);
    // ... later ...
    allocator.free(data);  // Already being freed by defer!
}
```

### Bug 5: Buffer Overflow

**Symptom**: Crash or corrupted data in adjacent allocations
**Cause**: Writing past the end of an allocated buffer
**Fix**: Check bounds; use Zig's built-in bounds checking

```zig
// BUGGY
const data = try allocator.alloc(u8, 10);
data[10] = 42;  // Out of bounds! Zig catches this in safe builds.
```

## Debugging Checklist

When a memory test fails, work through this:

1. **Find the allocation**: What was allocated and where?
2. **Trace the ownership**: Who is responsible for freeing it?
3. **Check `defer`/`errdefer`**: Is there a matching free for every alloc?
4. **Check error paths**: Does `errdefer` cover all partial allocations?
5. **Check arena vs backing**: Are returned values allocated from the right allocator?
6. **Check lifetimes**: Does the data outlive all references to it?

## Valgrind Integration

For programs (not tests), you can use valgrind for deeper analysis:

```bash
# Build your program
zig build

# Run under valgrind
valgrind --leak-check=full ./zig-out/bin/my_program
```

Valgrind catches:
- Memory leaks
- Use-after-free
- Buffer overflows
- Uninitialized memory reads

It's heavier than GPA's built-in checks, but catches more subtle bugs.

## For Python Developers

| Python | Zig | Notes |
|--------|-----|-------|
| `tracemalloc.start()` | `std.testing.allocator` | Automatic in tests |
| `tracemalloc.get_traced_memory()` | GPA leak report at `deinit()` | Automatic |
| `objgraph.show_refs()` | Read the code — all refs are explicit | No hidden references |
| Memory profiler | `valgrind --leak-check=full` | External tool |
| GC prevents most leaks | `defer`/`errdefer` prevent leaks | Manual but reliable |
| `gc.get_referrers()` | Pointer analysis by reading code | Explicit ownership |

### Key Insight

In Python, memory bugs manifest as "the program uses too much memory over time" — vague and hard to diagnose. In Zig, memory bugs manifest as test failures with specific reports — immediate and actionable. You pay the cost of manual management, but you get precise diagnostics in return.

## Common Mistakes

1. **Ignoring test failures** — Memory leak test failures are real bugs. Don't skip them.
2. **Adding `defer free` everywhere** — Only free memory you own. Don't free things the caller should free.
3. **Confusing "leak in test" with "leak in code"** — The test itself must also free any memory it allocates.
4. **Not testing error paths** — Leaks often hide in error paths. Test with failing allocations.

## Self-Check Questions

1. What happens when `std.testing.allocator` detects a leak?
2. What's the difference between a memory leak and use-after-free?
3. Why is `errdefer` essential for multi-allocation functions?
4. In the debugging checklist, what's the first thing to check?
5. When would you use valgrind instead of `std.testing.allocator`?

## Module Complete!

You've completed Module 3! You now understand:
- Stack vs heap memory and lifetimes
- Pointers for explicit references
- The allocator interface: alloc/free, create/destroy
- GPA for general use with leak detection
- Arenas for batch deallocation
- FixedBufferAllocator for no-heap allocation
- ML-specific memory patterns
- Debugging memory issues

→ Continue to [Module 4: Data Structures and Generics](../../04_data_structures/README.md)

## Exercises

Practice these concepts in [Exercise 3.8](../exercises/08_debugging/prompt.md).
