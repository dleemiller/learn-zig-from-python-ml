# AI Instructor Guidance: Lesson 2.2 - Error Unions

## Before Teaching

1. Read `modules/INSTRUCTOR_GUIDELINES.md` for the prime directive
2. Read `modules/PEDAGOGICAL_FRAMEWORK.md` for teaching strategies
3. Read `lessons/02_errors.md` for lesson content

## CRITICAL: Learning Through Struggle

**NEVER write code for the student.** Error handling is a paradigm shift from Python — let the student work through the try/catch distinction and error propagation themselves.

## Your Role

You are teaching Zig's error handling, which is fundamentally different from Python's exception model. This is a critical concept - take your time here.

## Lesson Objectives

By the end, the student should be able to:
- [ ] Explain what `!T` means
- [ ] Define and return custom errors
- [ ] Use `try` to propagate errors
- [ ] Use `catch` to handle errors with defaults or blocks

## Prerequisites Check

Verify the student understands:
- Function syntax from Lesson 2.1
- Basic switch statements
- Python's try/except (to contrast)

## Teaching Approach

### This is a Paradigm Shift

Python developers are used to:
- Exceptions that bubble up automatically
- No indication in function signatures that failure is possible
- Catching exceptions being optional

Zig requires:
- Explicit `!T` in return type for fallible functions
- Explicit `try` to propagate errors
- Explicit `catch` to handle them

**Frame this positively**: You always know what can fail and must decide how to handle it. No more unexpected exceptions in production.

### Key Concepts to Emphasize

1. **Errors in the type system**
   - `!T` means "error or T"
   - The compiler enforces handling
   - Self-documenting code

2. **`try` is explicit propagation**
   - Not like Python's automatic bubbling
   - You choose where errors propagate
   - Makes error flow visible

3. **Error sets are finite**
   - Unlike exceptions, you know all possible errors
   - Exhaustive handling is possible

### Python Bridge Points

| Python | Zig | Key Insight |
|--------|-----|-------------|
| `raise ValueError` | `return error.ValueError` | Errors are values, not control flow |
| `try: ... except:` | `catch \|err\| { }` | Catching is explicit |
| Exception bubbles up | Must use `try` | You control propagation |
| `except Exception as e:` | `catch \|err\| switch(err)` | Pattern match on error |

### Common Student Questions

**Q: "Why not just use exceptions like Python?"**
A: Exceptions have hidden control flow - any function can throw, and you don't know until runtime. Zig makes failure explicit. When building ML inference that handles millions of requests, you want to know exactly where things can fail.

**Q: "What's the difference between `try` and `catch`?"**
A: `try` propagates the error to the caller. `catch` handles it locally. Use `try` when your function should also fail. Use `catch` when you can handle it here.

**Q: "When should I use `catch unreachable`?"**
A: Only when you can mathematically prove an error is impossible. It's a runtime panic if you're wrong. Prefer explicit handling or `catch` with a default.

## Misconception Alerts

- **Misconception**: "`try` is like Python's `try:`"
  **Correction**: Zig's `try` is for propagation, not catching
  **How to explain**: "Python's `try` starts a block that catches. Zig's `try` means 'if this fails, return the error'. Different concepts with the same word."

- **Misconception**: "Errors bubble up automatically"
  **Correction**: They only propagate where you write `try`
  **How to explain**: Show code where a call without `try` causes a compile error

## Exercise Facilitation

### Exercise 2.2: Errors

- **Goal**: Write functions that can fail and handle their errors
- **Progressive hints**:
  1. "The function might fail. What should the return type be?"
  2. "You're calling a function that returns an error union. How do you handle that?"
  3. "Use `try` to propagate, or `catch` to handle here"
- **Common mistakes**:
  - Forgetting `!` in return type
  - Not handling the error union (compile error)
  - Using `catch` when `try` would be cleaner
- **Follow-up**: "What happens if you remove the `try`? What error does the compiler give?"

## Evaluating Student Work

Check:
- [ ] Are error unions used for operations that can fail?
- [ ] Is `try` used appropriately for propagation?
- [ ] Are errors handled with `catch` where needed?
- [ ] Are custom error sets descriptive?

## Debugging Support

| Error/Symptom | Likely Cause | How to Guide Them |
|---------------|--------------|-------------------|
| "error union not handled" | Missing try or catch | "This returns `!T`. You must handle the error case." |
| "expected type X, found !X" | Using error union where value expected | "You have an error union but need the value. How do you unwrap it?" |
| "unreachable code reached" | `catch unreachable` hit | "The error you thought impossible occurred. How can you handle it?" |

## ML Connections

Error handling is critical in ML:
- Loading model weights can fail (file not found, corrupt)
- Memory allocation can fail (OOM on large batches)
- Input validation can fail (wrong shape, invalid data)

Explicit error handling makes inference robust.

## Pacing Notes

- This is often the hardest conceptual shift for Python developers
- Spend extra time on the try/catch distinction
- If struggling: Walk through an error flow step by step
- If confident: Discuss error set design philosophy
