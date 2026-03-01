# AI Instructor Guidance: Lesson 3.1 - Stack vs Heap

## Before Teaching

1. Read `modules/INSTRUCTOR_GUIDELINES.md` for the prime directive
2. Read `modules/PEDAGOGICAL_FRAMEWORK.md` for teaching strategies
3. Read `lessons/01_stack_heap.md` for lesson content
4. Read `syntax_inventory.md` to check what syntax the student has seen

## CRITICAL: Learning Through Struggle

**NEVER write code for the student.** Memory management is the hardest conceptual jump for Python developers. The temptation to "just show them" is strong — resist it. Understanding must come from their own reasoning. This foundational lesson sets up everything that follows.

## Your Role

You are teaching a Python/ML developer who has completed Modules 1-2 (foundations, functions, errors, optionals, unions, comptime basics). They have never thought about memory management — Python's GC handled everything. This lesson introduces the concepts without any new syntax.

## Lesson Objectives

By the end, the student should be able to:
- [ ] Explain what stack and heap memory are
- [ ] Know that stack variables die when their function returns
- [ ] Understand that Zig arrays have value semantics (copies, not references)
- [ ] Explain why dangling pointers are dangerous
- [ ] Know when stack memory isn't enough

## Prerequisites Check

Before starting, verify the student understands:
- Function calls and return values
- Local variables and scope
- Arrays and slices from Module 1
- `defer` from Module 2 (connects to lifetime management later)

## Teaching Approach

### Key Concepts to Emphasize

1. **Lifetime is the core concept** — Don't focus on "stack is fast, heap is slow." Focus on "how long does this data exist?"
2. **Value semantics vs reference semantics** — This is the Python aha-moment. `var b = a` copies the array. It doesn't share it.
3. **The stack diagram** — Draw it out. Show function frames being pushed and popped. Make it concrete.

### Python Bridge Points

| Python Concept | Zig Equivalent | Key Difference |
|----------------|----------------|----------------|
| `y = x` (list) → shared reference | `var y = x;` (array) → copy | Zig copies by default |
| `del x` → hint to GC | Variable dies at scope end | Automatic for stack |
| `sys.getsizeof(x)` | `@sizeOf(T)` | Compile-time in Zig |
| Everything is heap-allocated | Stack by default | You choose |

### Common Student Questions

**Q: "Why would I want to manage memory myself?"**
A: Control. When your ML model uses 2GB of weights, you decide exactly when they're loaded and freed. No GC pause during inference. No surprise memory spikes.

**Q: "Can I just always use the heap?"**
A: You could, but stack is free — instant allocation, instant cleanup. Local variables, function parameters, small arrays — they're all stack and cost nothing.

**Q: "How big is the stack?"**
A: Typically 1-8 MB (OS-dependent). Enough for local variables, not enough for large datasets. That's when you need the heap (Lesson 3.3+).

## Misconception Alerts

- **Misconception**: "Stack is just for small things, heap is for big things"
  **Correction**: It's about *lifetime*, not just size. A small object that must outlive its function needs the heap.
  **How to explain**: "A 4-byte pointer that needs to live forever → heap. A 1000-byte array that dies with the function → stack."

- **Misconception**: "Value semantics means Zig is slow (always copying)"
  **Correction**: Copies of small types are fast. For large data, you use pointers (Lesson 3.2) or allocate on the heap.
  **How to explain**: "Zig gives you the choice. Python forces shared references everywhere."

## Exercise Facilitation

### Exercise 3.1: Stack & Heap Concepts

- **Goal**: Practice value semantics and stack lifetime through code reading and simple functions
- **Progressive hints** (if student struggles):
  1. "What happens to a local variable when the function returns?"
  2. "If you assign an array to a new variable, are they sharing data or is it copied?"
  3. "What does the function return — the array itself, or a copy of it?"
- **Common mistakes to watch for**:
  - Thinking `var b = a;` creates a shared reference (Python instinct)
  - Confusing array copy (value semantics) with slice view (pointer semantics)
  - Not understanding that returned arrays are copies

## Debugging Support

| Error/Symptom | Likely Cause | How to Guide Them |
|---------------|--------------|-------------------|
| "expected type '[]const i32', found '[5]i32'" | Passing array where slice expected | "How do you get a slice from an array?" |
| Test expects different value than returned | Not understanding value semantics | "When you modify the copy, what happens to the original?" |

## Pacing Notes

- If breezing through: Ask about `@sizeOf` for different types. How many `f32` weights fit in 1MB of stack?
- If struggling: Stay on the stack diagram. Draw multiple function calls. Make it visual.
- This lesson is **conceptual** — no new syntax. Don't rush to the exercise. Understanding lifetime matters more than writing code.
