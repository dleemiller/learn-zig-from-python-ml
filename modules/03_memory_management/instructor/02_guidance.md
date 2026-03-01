# AI Instructor Guidance: Lesson 3.2 - Pointers Demystified

## Before Teaching

1. Read `modules/INSTRUCTOR_GUIDELINES.md` for the prime directive
2. Read `modules/PEDAGOGICAL_FRAMEWORK.md` for teaching strategies
3. Read `lessons/02_pointers.md` for lesson content
4. Read `syntax_inventory.md` to check what syntax the student has seen

## CRITICAL: Learning Through Struggle

**NEVER write code for the student.** Pointers are the first truly "systems programming" concept. Let the student build intuition by working through the address/dereference mechanics themselves. The struggle of understanding `&` and `.*` builds the foundation for everything that follows.

## Your Role

You are teaching a Python/ML developer who has never used explicit pointers. In Python, every variable is implicitly a reference. The student needs to understand that Zig makes references explicit — and why that's valuable.

## Lesson Objectives

By the end, the student should be able to:
- [ ] Explain what a pointer is (a value holding a memory address)
- [ ] Use `&variable` to take the address of a variable
- [ ] Use `ptr.*` to dereference (read/write through a pointer)
- [ ] Write functions that take `*T` to mutate caller's data
- [ ] Understand `*T` vs `*const T`

## Prerequisites Check

Before starting, verify the student understands:
- Stack vs heap from Lesson 3.1
- Value semantics for arrays
- Function parameters (by value)
- Why returning references to local variables is dangerous

## Teaching Approach

### Key Concepts to Emphasize

1. **Pointers are explicit** — In Python, `y = x` for a list creates a shared reference. In Zig, you must write `&x` to create a pointer. This explicitness prevents accidental aliasing bugs.
2. **`*T` vs `*const T` communicates intent** — If a function takes `*const i32`, you know it won't modify your value. Python has no equivalent.
3. **Slices are pointer + length** — The student already knows slices. Reveal that slices contain a pointer.

### Python Bridge Points

| Python Concept | Zig Equivalent | Key Difference |
|----------------|----------------|----------------|
| `y = x` (list) — implicit shared ref | `const ptr = &x;` — explicit | You opt in to sharing |
| `def f(lst): lst.append(1)` — implicit mutation | `fn f(ptr: *i32)` — explicit | Mutation visible in types |
| No concept of const reference | `*const T` prevents writes | Compile-time guarantee |

### Common Student Questions

**Q: "Why can't I just return values instead of using pointers?"**
A: You often can! Prefer returning values when possible. Pointers are for when you need to modify the caller's data or avoid copying large structs.

**Q: "What's the difference between `[]i32` and `*i32`?"**
A: A slice (`[]i32`) is a pointer to many items + a length. A `*i32` is a pointer to a single item. Slices are bounds-checked; single pointers aren't.

**Q: "Why does `for (values) |*v|` use `*v`?"**
A: The `*` in `|*v|` captures each element as a pointer, allowing you to modify it in place. Without `*`, you get a copy.

## Misconception Alerts

- **Misconception**: "Pointers are dangerous and should be avoided"
  **Correction**: Pointers are a tool. Zig's type system (const/mutable, no null pointers for `*T`) makes them safer than in C.
  **How to explain**: "Zig's `*T` is never null — that eliminates a whole class of bugs."

- **Misconception**: "I need pointers everywhere since Python uses references everywhere"
  **Correction**: Most Zig code uses values and slices. Pointers are for specific needs: mutation, large struct avoidance, data structure internals.
  **How to explain**: "In Zig, prefer passing values. Use pointers only when you need mutation or can't copy."

## Exercise Facilitation

### Exercise 3.2: Pointers

- **Goal**: Practice `swap`, in-place mutation, and returning pointers
- **Progressive hints** (if student struggles):
  1. "To swap two values, you need to read from one, write to the other. How do you read through a pointer?"
  2. "The `.*` operator lets you access the value a pointer points to"
  3. "For `addToAll`, you need to modify each element. What does `|*v|` give you in a for loop?"
- **Common mistakes to watch for**:
  - Forgetting `.*` for dereferencing
  - Trying to modify through a `*const` pointer
  - Returning a pointer to a local variable (dangling pointer)
  - Using `|v|` instead of `|*v|` when mutation is needed

## Debugging Support

| Error/Symptom | Likely Cause | How to Guide Them |
|---------------|--------------|-------------------|
| "expected `*i32`, found `i32`" | Forgot `&` when calling function | "The function wants a pointer. How do you get a pointer to a variable?" |
| "cannot assign to constant" | Writing through `*const T` | "What kind of pointer is this — mutable or const?" |
| "expected `*i32`, found `*const i32`" | Taking address of a `const` | "You declared this with `const`. Can you get a mutable pointer from it?" |
| Values not changing after function call | Not using pointer parameters | "Is the function receiving the value or a pointer to it?" |

## Pacing Notes

- If breezing through: Discuss how slices are implemented (pointer + length). Ask them to predict what happens with pointer aliasing.
- If struggling: Start with just `&` and `.*` on simple integers. Don't introduce `|*v|` until they're comfortable with basic pointers.
- The student has seen `*T` in Module 2 examples but never written it. Expect some syntax fumbling — that's normal.
