# Lesson 3.2: Pointers Demystified

## Learning Objectives

- [ ] Understand what pointers are and why they exist
- [ ] Use `*T` and `*const T` pointer types
- [ ] Take the address of a variable with `&`
- [ ] Dereference pointers with `ptr.*`
- [ ] Pass pointers to functions for mutation
- [ ] Understand the difference between `[]T` and `*T`

## Prerequisites

- Completed Lesson 3.1 (Stack vs Heap concepts)
- Understand value semantics for arrays
- Comfortable with function parameters

## What Is a Pointer?

A pointer is a value that holds a memory address. It tells you *where* data lives, not *what* the data is.

```
Variable x:        Pointer to x:
┌─────────┐       ┌───────────────┐
│   42    │ ←──── │ address: 0xFF │
└─────────┘       └───────────────┘
 (the data)        (where data is)
```

In Python, every variable is already a reference (pointer) under the hood:

```python
x = [1, 2, 3]
y = x          # y points to the same list as x
y[0] = 99      # x[0] is now 99 too!
```

In Zig, pointers are **explicit**. You decide when to reference and when to copy.

## Pointer Types

```zig
var x: i32 = 42;

const ptr: *i32 = &x;          // mutable pointer to x
const cptr: *const i32 = &x;   // read-only pointer to x
```

- `*T` — pointer to a mutable `T`. You can read and write through it.
- `*const T` — pointer to a constant `T`. You can read but not write.
- `&x` — "address of x" — creates a pointer to `x`.

## Dereferencing: Reading Through a Pointer

Use `ptr.*` to access the value a pointer points to:

```zig
var x: i32 = 42;
const ptr = &x;

const value = ptr.*;   // value is 42
```

## Writing Through a Pointer

With a `*T` (mutable pointer), you can change the original value:

```zig
var x: i32 = 42;
const ptr: *i32 = &x;

ptr.* = 100;    // x is now 100
```

This is how you do "pass by reference" in Zig — explicitly, through pointer parameters.

## Pointer Parameters: Mutation by Design

In Python, mutable objects are passed by reference implicitly:

```python
def add_one(lst):
    lst.append(1)  # Modifies the original — surprise!
```

In Zig, mutation requires an explicit pointer parameter:

```zig
fn increment(ptr: *i32) void {
    ptr.* += 1;
}

pub fn main() void {
    var x: i32 = 10;
    increment(&x);
    // x is now 11
}
```

The function signature tells you: "this function will modify what you pass." No surprises.

## Slices vs Pointers

You already know slices from Module 1. A slice (`[]T`) is actually a pointer + length:

```
Slice []i32:
┌──────────────────┐
│ ptr: *i32 ──────────→ [10, 20, 30, 40, 50]
│ len: 5           │
└──────────────────┘
```

When you pass a `[]i32` (mutable slice) to a function, the function can modify the elements:

```zig
fn doubleAll(values: []i32) void {
    for (values) |*v| {
        v.* *= 2;
    }
}

pub fn main() void {
    var data = [_]i32{ 1, 2, 3 };
    doubleAll(&data);
    // data is now { 2, 4, 6 }
}
```

Notice `|*v|` — this captures each element as a pointer, allowing mutation.

## Const vs Mutable Pointers

The `const` qualifier prevents modification:

```zig
fn readOnly(ptr: *const i32) void {
    const val = ptr.*;   // OK — reading
    _ = val;
    // ptr.* = 10;       // Error! Can't write through const pointer
}

fn readWrite(ptr: *i32) void {
    ptr.* = 10;          // OK — writing
}
```

Choose `*const T` when the function only needs to read. This communicates intent and prevents bugs.

## Many-Item Pointers (Preview)

Zig also has `[*]T` — a pointer to an unknown number of items. This is mainly for C interop and low-level work. You won't need to write it yet, but you may see it in library code:

```zig
// [*]T has no length information — use carefully
// You'll encounter this in Module 7 (C Interop)
```

For now, prefer slices (`[]T`) — they carry their length and are bounds-checked.

## Returning Pointers Into Data

A function can return a pointer into data that was passed in:

```zig
fn findMax(values: []i32) *i32 {
    var max_ptr: *i32 = &values[0];
    for (values[1..]) |*v| {
        if (v.* > max_ptr.*) {
            max_ptr = v;
        }
    }
    return max_ptr;
}
```

This is safe because the caller owns the data — the pointer is valid as long as the caller's data exists.

## For Python Developers

| Python | Zig | Notes |
|--------|-----|-------|
| `y = x` (list) → shared ref | `const ptr = &x;` → explicit pointer | Zig makes sharing explicit |
| All objects are references | Values by default, pointers opt-in | You choose |
| No const references | `*const T` prevents writes | Compile-time safety |
| `x.append(1)` mutates implicitly | `ptr.* = val` mutates explicitly | Clear mutation |
| Can't take address of anything | `&x` works on any variable | Low-level access |

### Key Insight

In Python, "everything is a reference" means you can accidentally mutate shared state. In Zig, mutation is always visible in the types:
- `fn f(x: i32)` — cannot modify caller's data
- `fn f(x: *i32)` — can modify caller's data
- `fn f(x: *const i32)` — can read but not modify

## Common Mistakes

1. **Forgetting `&` when calling a function that takes `*T`** — The compiler will tell you: "expected `*i32`, found `i32`". You need to pass `&variable`.
2. **Trying to take address of a `const`** — You can only get a `*T` from a `var`. From a `const`, you get `*const T`.
3. **Dangling pointers** — Don't return `&local_var`. The local dies when the function returns.
4. **Confusing `ptr.*` (dereference) with `ptr.field` (struct field access through pointer)** — Zig auto-dereferences for struct fields, so `ptr.field` works without `ptr.*.field`.

## Self-Check Questions

1. What is the type of `&x` if `x` is `var x: i32`?
2. How do you read the value that a pointer points to?
3. What's the difference between `*i32` and `*const i32`?
4. Why does Zig require explicit `&` instead of implicitly passing references?
5. What does `|*v|` mean in a `for` loop?

## Exercises

Practice these concepts in [Exercise 3.2](../exercises/02_pointers/prompt.md).
