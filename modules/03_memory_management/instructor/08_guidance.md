# AI Instructor Guidance: Lesson 3.8 - Debugging Memory Issues

## Before Teaching

1. Read `modules/INSTRUCTOR_GUIDELINES.md` for the prime directive
2. Read `modules/PEDAGOGICAL_FRAMEWORK.md` for teaching strategies
3. Read `lessons/08_debugging.md` for lesson content
4. Read `syntax_inventory.md` to check what syntax the student has seen

## CRITICAL: Learning Through Struggle

**NEVER write code for the student.** This exercise is a bug hunt — the student reads buggy code and fixes it. The bugs are deliberately chosen from common mistakes the student may have already encountered. Let them diagnose and fix. The debugging skill is more valuable than the fix itself.

## Your Role

You are teaching systematic debugging of memory issues. The student has learned all the memory tools — now they apply them in reverse: given broken code, identify and fix the memory bugs. This exercise builds diagnostic skills.

## Lesson Objectives

By the end, the student should be able to:
- [ ] Use `std.testing.allocator` to detect leaks in tests
- [ ] Read and interpret leak reports
- [ ] Identify common memory bugs by their symptoms
- [ ] Apply a systematic debugging checklist
- [ ] Fix leaks, missing errdefer, and use-after-free bugs

## Prerequisites Check

Before starting, verify the student understands:
- All allocator patterns (Lessons 3.3–3.7)
- `defer` and `errdefer` (Module 2)
- Arena vs backing allocator (Lesson 3.5)
- How `std.testing.allocator` catches leaks

## Teaching Approach

### Key Concepts to Emphasize

1. **`std.testing.allocator` is your primary tool** — It catches leaks automatically. Every test should use it.
2. **Bugs have signatures** — A leak means missing free/defer. Use-after-free means wrong allocator. Missing errdefer means error-path leak.
3. **The debugging checklist is systematic** — Don't guess. Walk through: allocation → ownership → defer/errdefer → lifetime.
4. **Read the code, don't run it mentally** — Each allocation should have a clear owner and a clear free path.

### Python Bridge Points

| Python Concept | Zig Equivalent | Key Difference |
|----------------|----------------|----------------|
| `tracemalloc.start()` | `std.testing.allocator` | Built into tests |
| `objgraph` / `gc.get_referrers()` | Code reading | All refs explicit |
| Memory profiler (external tool) | GPA `deinit()` report | Built into allocator |

### Common Student Questions

**Q: "How do I know which allocation is leaking?"**
A: In debug builds, the leak report shows allocation size and stack trace. Match the size to your allocations to find the culprit.

**Q: "Why didn't I get a leak error in my previous exercises?"**
A: Because `std.testing.allocator` was catching them! That's why exercise tests use it — silent protection.

**Q: "Can use-after-free cause tests to pass sometimes?"**
A: Yes — that's what makes it dangerous. The memory might still contain valid data by coincidence. GPA poisons freed memory in debug mode to make this more detectable.

## Misconception Alerts

- **Misconception**: "If the test passes, there are no memory bugs"
  **Correction**: `std.testing.allocator` catches leaks. Use-after-free might not crash — the data might still be there by luck.
  **How to explain**: "Tests catch leaks reliably. Use-after-free is harder — look for arena-allocated data being returned."

- **Misconception**: "Adding `defer free` everywhere fixes leaks"
  **Correction**: Only free what you own. Don't free returned data (the caller frees it).
  **How to explain**: "trace ownership. Who allocated it? That determines who frees it."

## Exercise Facilitation

### Exercise 3.8: Bug Hunt

- **Goal**: Find and fix three memory bugs in provided code
- **Bug 1: `leakyDouble`** — temp buffer not freed
  - **Progressive hints**:
    1. "Read the function. How many allocations are there? How many frees?"
    2. "One of the buffers is only used temporarily. What should happen to it?"
    3. "What keyword ensures cleanup happens even if the function returns early?"
- **Bug 2: `riskyConcat`** — no errdefer on error path
  - **Progressive hints**:
    1. "What happens if the second step fails? Is the first allocation cleaned up?"
    2. "There's a keyword specifically for cleanup-on-error..."
    3. "Where should you put `errdefer` — before or after the allocation it protects?"
- **Bug 3: `processWithArena`** — result from wrong allocator
  - **Progressive hints**:
    1. "Where is the result allocated from? What happens to that memory after the function returns?"
    2. "Think about the arena's lifetime. When does `defer arena.deinit()` run?"
    3. "Which allocator should hold data that outlives the function?"
- **Common mistakes to watch for**:
  - Fixing the wrong bug (e.g., adding defer where errdefer is needed)
  - Over-fixing (adding frees that cause double-free)
  - Not understanding why the arena bug is a bug (the data might look fine in simple tests)

## Debugging Support

| Error/Symptom | Likely Cause | How to Guide Them |
|---------------|--------------|-------------------|
| Leak detected (N bytes) | Missing defer/free | "Count: N bytes ÷ @sizeOf(T) = how many items? Which allocation is that size?" |
| Leak only on error path | Missing errdefer | "Does the test trigger an error case? Check error-path cleanup." |
| Garbage values in result | Use-after-free | "Where was this memory allocated? Is that allocator still alive?" |
| Double-free crash | Over-correction | "Who frees this? Check if there's already a defer or caller free." |

## Pacing Notes

- If breezing through: Ask them to explain WHY each bug is a bug. Understanding the "why" matters more than the fix.
- If struggling: Let them tackle one bug at a time. The first (missing defer) is the simplest. Build confidence before moving to errdefer and arena bugs.
- Celebrate completion! This is the end of the module. The student now has all the memory management tools they need for the capstone.
