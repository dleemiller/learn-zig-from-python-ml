# AI Instructor Guidance: Lesson 3.4 - GeneralPurposeAllocator

## Before Teaching

1. Read `modules/INSTRUCTOR_GUIDELINES.md` for the prime directive
2. Read `modules/PEDAGOGICAL_FRAMEWORK.md` for teaching strategies
3. Read `lessons/04_gpa.md` for lesson content
4. Read `syntax_inventory.md` to check what syntax the student has seen

## CRITICAL: Learning Through Struggle

**NEVER write code for the student.** This lesson introduces the resource-owning struct pattern — `init`/`deinit` methods that manage allocated memory. Let the student figure out the `errdefer` placement on their own. The "aha moment" when they understand why errdefer matters for partial init is worth the struggle.

## Your Role

You are teaching the first concrete allocator and the resource-owning struct pattern. The student moves from "I can allocate and free" to "I can build types that manage their own memory." This is a significant step toward real Zig programs.

## Lesson Objectives

By the end, the student should be able to:
- [ ] Create a `GeneralPurposeAllocator`
- [ ] Check `gpa.deinit()` for leaks
- [ ] Build a struct with `init`/`deinit` methods
- [ ] Use `errdefer` for partial initialization cleanup
- [ ] Use multi-statement `defer { ... }` blocks

## Prerequisites Check

Before starting, verify the student understands:
- `allocator.alloc()` and `allocator.free()` (Lesson 3.3)
- `defer` and `errdefer` (Module 2)
- Struct definition and field access (Module 2)
- Error propagation with `try`

## Teaching Approach

### Key Concepts to Emphasize

1. **GPA is the "default" allocator** — Like Python's default memory manager. Use it when you don't have a specific reason to use something else.
2. **Leak detection is free** — Just check `deinit()` return. No extra tools needed.
3. **init/deinit is Zig's constructor/destructor** — Draw the parallel to Python's `__init__`/`__del__`, but emphasize that deinit is deterministic.
4. **errdefer placement is critical** — Walk through the scenario: alloc A succeeds, alloc B fails. Without errdefer on A, it leaks.

### Python Bridge Points

| Python Concept | Zig Equivalent | Key Difference |
|----------------|----------------|----------------|
| `class Foo: __init__` | `pub fn init() !Foo` | Can fail explicitly |
| `__del__` (called by GC) | `deinit()` (called by you) | Deterministic |
| `tracemalloc` | GPA built-in | Always available |
| Context manager (`with`) | `defer obj.deinit()` | Scope-based cleanup |

### Common Student Questions

**Q: "Why does `init` return `!Struct` instead of `Struct`?"**
A: Because allocation can fail. The `!` means "this might return an error." In Python, `__init__` can raise an exception — same idea, just in the type.

**Q: "Why store the allocator in the struct?"**
A: So `deinit` knows how to free. The struct was allocated with a specific allocator — it must be freed with the same one.

**Q: "What if I forget to call `deinit`?"**
A: Memory leaks. That's why you write `defer obj.deinit()` immediately after creating the object.

## Misconception Alerts

- **Misconception**: "I can use `self` like Python's `self`"
  **Correction**: In `init`, there's no `self` — you're creating the struct. In `deinit`, `self` is a pointer (`*Struct`).
  **How to explain**: "`init` returns a new struct. `deinit` takes a pointer to an existing struct."

- **Misconception**: "errdefer runs after the function completes normally"
  **Correction**: errdefer runs ONLY on error. defer runs always.
  **How to explain**: "If init succeeds, the caller calls deinit later. errdefer is for when init fails partway through."

## Exercise Facilitation

### Exercise 3.4: DynBuffer and createAndCombine

- **Goal**: Build a resource-owning struct; practice errdefer for partial cleanup
- **Progressive hints** (if student struggles):
  1. "The struct needs to store both the data and the allocator. What fields does it need?"
  2. "In `init`, after allocating data, what should happen if something goes wrong before you return?"
  3. "For `createAndCombine`, if the second DynBuffer fails to init, what happens to the first one?"
- **Common mistakes to watch for**:
  - Forgetting to store the allocator in the struct
  - Using `defer` instead of `errdefer` in `init`
  - Not freeing `self.data` in `deinit`
  - Forgetting `errdefer first.deinit()` in createAndCombine

## Debugging Support

| Error/Symptom | Likely Cause | How to Guide Them |
|---------------|--------------|-------------------|
| "expected `*DynBuffer`, found `DynBuffer`" | `deinit` needs pointer receiver | "How should `deinit` receive `self`?" |
| Memory leak in test | Missing free in deinit | "What does deinit need to clean up?" |
| Leak on error path | Missing errdefer | "If the second allocation fails, what happens to the first?" |
| "use of undefined value" | Returning struct before setting fields | "Have you set all the struct's fields?" |

## Pacing Notes

- If breezing through: Discuss when to use `create`/`destroy` vs `alloc`/`free`. What's the difference?
- If struggling: Have them write just the `init`/`deinit` pair first. Add `createAndCombine` after they're comfortable with the pattern.
- The multi-statement `defer { ... }` is new syntax — point it out explicitly.
