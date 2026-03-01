# Lesson 3.1: Stack vs Heap

## Learning Objectives

- [ ] Understand what memory is and why it matters
- [ ] Explain the difference between stack and heap memory
- [ ] Understand lifetime as the core concept
- [ ] Know when stack memory isn't enough
- [ ] Recognize the dangling reference problem

## Prerequisites

- Completed Module 2: Functions, Errors, and Optionals
- Comfortable with function calls, return values, and `defer`

## Why Python Developers Never Think About Memory

In Python, you write code like this:

```python
def process():
    data = [1, 2, 3, 4, 5]  # Where does this live? Who cares!
    result = sum(data)
    return result  # data is cleaned up... eventually
```

Python's garbage collector handles everything. You never ask:
- Where is `data` stored?
- When is `data` freed?
- What happens if two variables point to the same list?

In Zig, **you** answer all these questions. This isn't busywork — it's what gives you control over performance and predictability.

## Two Kinds of Memory

Your program has two regions of memory:

### The Stack

The stack is fast, automatic, and limited:

```
┌─────────────────────────┐
│ main()                  │
│   x: i32 = 42           │  ← Each function call gets a "frame"
│   y: i32 = 10           │
├─────────────────────────┤
│ calculate(42, 10)       │
│   result: i32 = 52      │  ← New frame pushed on top
│   temp: f64 = 5.2       │
├─────────────────────────┤
│ (next call would go here)│
└─────────────────────────┘
```

- **Allocation**: instant (just move a pointer)
- **Deallocation**: instant (function returns, frame disappears)
- **Size**: must be known at compile time
- **Lifetime**: tied to the function scope

### The Heap

The heap is flexible, manual, and slower:

```
┌──────────────────────────────┐
│ Heap (managed by allocator)  │
│                              │
│  [1, 2, 3, ...., 1000000]   │  ← Can be any size
│                              │
│  "hello world"               │  ← Lives as long as you want
│                              │
└──────────────────────────────┘
```

- **Allocation**: slower (find a free block, track it)
- **Deallocation**: you decide when
- **Size**: can be determined at runtime
- **Lifetime**: you control it explicitly

## Stack Memory in Zig

Local variables live on the stack:

```zig
fn calculate(a: i32, b: i32) i32 {
    const sum = a + b;        // sum lives on the stack
    var temp = sum * 2;       // temp lives on the stack
    temp -= 1;
    return temp;              // value is copied out, stack frame disappears
}
```

Arrays with compile-time-known sizes also live on the stack:

```zig
fn makeArray() [5]i32 {
    var arr = [_]i32{ 10, 20, 30, 40, 50 };
    arr[0] = 99;
    return arr;  // The ENTIRE array is copied to the caller
}
```

This is different from Python, where `return [1,2,3]` returns a reference to a heap object.

## Value Semantics: Arrays Are Copied

This is one of the biggest differences from Python:

```zig
fn main() void {
    var original = [_]i32{ 1, 2, 3 };
    var copy = original;       // Full copy! Not a reference.
    copy[0] = 99;

    // original[0] is still 1
    // copy[0] is 99
}
```

In Python:
```python
original = [1, 2, 3]
copy = original    # NOT a copy — same list!
copy[0] = 99       # original[0] is now 99 too!
```

Zig arrays have **value semantics** — assignment copies the data. Python lists have **reference semantics** — assignment shares the data.

## Slices Are Views, Not Copies

A slice doesn't own data — it's a view into existing data:

```zig
fn main() void {
    var arr = [_]i32{ 10, 20, 30, 40, 50 };
    const slice = arr[1..4];  // slice is {20, 30, 40}
    // slice doesn't own this data — it points into arr
}
```

A slice is just a pointer + length. It's lightweight to pass around, but the underlying data must stay alive as long as the slice exists.

## Lifetime: The Core Concept

**Lifetime** means: how long does this piece of data exist?

```zig
fn stackLifetime() i32 {
    const x: i32 = 42;     // x is born
    const y = x + 10;      // x is still alive
    return y;               // x dies when function returns
}
```

Stack variables live exactly as long as their function call. This is simple and predictable, but it means you can't return a reference to a local variable:

```zig
// DANGER — conceptual example (Zig prevents this)
fn dangling() *i32 {
    var x: i32 = 42;
    return &x;   // x will be destroyed when this function returns!
    // The pointer would point to freed memory — a "dangling pointer"
}
```

Zig's compiler catches many dangling reference bugs. But understanding *why* they're dangerous is essential — it's the reason we need heap allocation.

## When the Stack Isn't Enough

The stack fails when:

1. **Size unknown at compile time**: `fn make(n: usize) ???` — can't put `n` items on the stack
2. **Data must outlive the function**: return a large buffer that the caller will use later
3. **Data is too large**: stack space is limited (typically 1-8 MB)

This is when you need the heap — and that requires an **allocator** (Lesson 3.3).

## Seeing Memory Size

You've already seen `@sizeOf` from Module 1:

```zig
@sizeOf(i32)     // 4 bytes
@sizeOf(f64)     // 8 bytes
@sizeOf([100]i32) // 400 bytes — all on the stack
```

For ML, this matters. A layer with 768×768 weights as `f32`:
- 768 × 768 × 4 bytes = ~2.4 MB — too big for the stack!
- This *must* go on the heap.

## For Python Developers

| Python | Zig | Notes |
|--------|-----|-------|
| Everything is on the heap | Stack by default, heap when needed | You choose |
| `sys.getsizeof(x)` | `@sizeOf(T)` | Compile-time in Zig |
| `id(x)` shows memory address | `@intFromPtr(&x)` | Explicit address-taking |
| `del x` hints to GC | Variable dies at scope end | Automatic for stack |
| `y = x` (list) → shared reference | `var y = x;` (array) → full copy | Value semantics |
| `copy.deepcopy(x)` → independent copy | Assignment already copies | No need for deepcopy |

## Common Mistakes

1. **Thinking all data is on the heap** — In Zig, local variables and fixed-size arrays are on the stack. Only dynamically-sized data needs the heap.
2. **Assuming assignment shares data** — Zig arrays are value types. Assignment copies. This is safe but can be slow for large arrays.
3. **Ignoring lifetime** — A slice into a local array becomes dangling after the function returns. Always think about "who owns this data?"

## Self-Check Questions

1. Where does a local `var x: i32 = 5;` live — stack or heap?
2. If you assign one array to another (`var b = a;`), do they share data?
3. Why can't you return a pointer to a local variable?
4. When would you need heap memory instead of stack memory?
5. What is a "dangling pointer" and why is it dangerous?

## Exercises

Practice these concepts in [Exercise 3.1](../exercises/01_stack_heap/prompt.md).
