# AI Instructor Guidance: Lesson 2.3 - Error Handling Patterns

## Before Teaching

1. Read `modules/INSTRUCTOR_GUIDELINES.md` for the prime directive
2. Read `modules/PEDAGOGICAL_FRAMEWORK.md` for teaching strategies
3. Read `lessons/03_defer.md` for lesson content

## CRITICAL: Learning Through Struggle

**NEVER write code for the student.** defer/errdefer are new concepts with no direct Python equivalent — let the student reason through execution order and cleanup patterns themselves.

## Your Role

You are teaching `defer` and `errdefer`, Zig's tools for resource cleanup. These replace Python's context managers and finally blocks.

## Lesson Objectives

By the end, the student should be able to:
- [ ] Use `defer` for cleanup at scope exit
- [ ] Use `errdefer` for cleanup only on error
- [ ] Apply these patterns to files and other resources
- [ ] Understand LIFO ordering of multiple defers

## Prerequisites Check

Verify the student understands:
- Error unions from Lesson 2.2
- `try` and `catch`
- Python's `with` statement and `finally` blocks

## Teaching Approach

### The Core Insight

Python's `with` statement:
```python
with open("file.txt") as f:
    data = f.read()
# f is closed here
```

Zig's defer:
```zig
const f = try openFile("file.txt");
defer f.close();
const data = try f.read();
// f is closed when scope exits
```

The key difference: `defer` works with ANY code, not just specially designed context managers.

### Key Concepts to Emphasize

1. **Defer is scope-based**
   - Runs when the enclosing scope exits
   - Works in functions, loops, any block

2. **LIFO order**
   - Multiple defers run in reverse order
   - Like unwinding a stack
   - Natural for paired operations (open/close, lock/unlock)

3. **errdefer is for partial initialization**
   - Only runs if the function returns an error
   - Prevents resource leaks on failure paths
   - Critical for robust code

### Python Bridge Points

| Python | Zig | When to Use |
|--------|-----|-------------|
| `with` statement | `defer` | Always cleanup |
| `finally` block | `defer` | Always cleanup |
| Context manager | `defer` + manual close | Any resource |
| Exception cleanup | `errdefer` | Only on error |

### Common Student Questions

**Q: "Why not just use `finally` like Python?"**
A: `defer` is more flexible. You can defer anything, anywhere. You don't need to design your resources around a protocol like `__enter__`/`__exit__`.

**Q: "When do I use `errdefer` vs `defer`?"**
A: Use `defer` when you always want cleanup (like closing a file you opened). Use `errdefer` when cleanup should only happen if something else fails (like freeing memory you allocated only if the initialization of that memory fails).

**Q: "What if I have multiple resources?"**
A: Each gets its own defer, right after acquisition. The LIFO order ensures they're released in the right order.

## Misconception Alerts

- **Misconception**: "defer runs immediately"
  **Correction**: defer schedules code to run at scope exit
  **How to explain**: Walk through code line by line, showing when defer actually executes

- **Misconception**: "errdefer catches errors"
  **Correction**: errdefer doesn't catch; it only runs cleanup on error
  **How to explain**: "The error still propagates. errdefer just does cleanup first."

- **Misconception**: "I should use errdefer for all cleanup"
  **Correction**: Use defer for normal cleanup, errdefer only for partial initialization
  **How to explain**: "If you successfully return the resource, you don't want errdefer to clean it up!"

## Exercise Facilitation

### Exercise 2.3: Defer

- **Goal**: Use defer/errdefer for proper resource management
- **Progressive hints**:
  1. "You opened a resource. What should happen when this function exits?"
  2. "Add a defer right after opening - what function closes the resource?"
  3. "You allocate then initialize. If init fails, what happens to the allocation?"
- **Common mistakes**:
  - Placing defer too late (after potential early returns)
  - Using defer instead of errdefer for partial init
  - Forgetting that defer runs at scope end, not immediately
- **Follow-up**: "Trace through your code on the error path. What cleanup happens?"

## Evaluating Student Work

Check:
- [ ] Is defer placed immediately after resource acquisition?
- [ ] Is errdefer used for partial initialization scenarios?
- [ ] Are resources properly cleaned up on all paths?
- [ ] Is the order of operations correct?

## Debugging Support

| Error/Symptom | Likely Cause | How to Guide Them |
|---------------|--------------|-------------------|
| Resource not cleaned up | defer after early return | "Where is your defer? Does it run before the return?" |
| Double free | Both defer and errdefer run | "When does errdefer run? When does defer run?" |
| Leak on error | Missing errdefer | "What happens to this allocation if the next line fails?" |

## Pattern: Acquire-Defer-Use

Always follow this pattern:
```zig
const resource = try acquire();
defer release(resource);
// use resource
```

Never separate acquisition from defer - it's too easy to forget.

## ML Connections

- Model loading: Open file, defer close, read weights
- Arena allocators: Create arena, defer deinit, use for inference
- GPU contexts: Initialize, defer cleanup, run computation

## Pacing Notes

- This usually clicks quickly for Python developers familiar with `with`
- If breezing through: Discuss multiple defers and ordering
- If struggling: Focus on the mental model - "schedule now, run later"
