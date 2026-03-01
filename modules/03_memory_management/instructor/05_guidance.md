# AI Instructor Guidance: Lesson 3.5 - ArenaAllocator

## Before Teaching

1. Read `modules/INSTRUCTOR_GUIDELINES.md` for the prime directive
2. Read `modules/PEDAGOGICAL_FRAMEWORK.md` for teaching strategies
3. Read `lessons/05_arena.md` for lesson content
4. Read `syntax_inventory.md` to check what syntax the student has seen

## CRITICAL: Learning Through Struggle

**NEVER write code for the student.** The two-allocator pattern (arena for scratch, backing for results) is the most important pattern in this module — it directly applies to the capstone project. Let the student reason through which allocator to use for what. This decision-making is the real skill.

## Your Role

You are teaching arena allocation and the critical two-allocator pattern. The student already knows `alloc`/`free` and GPA. Now they learn that not all allocations need individual frees — and how to combine allocators for different lifetimes.

## Lesson Objectives

By the end, the student should be able to:
- [ ] Create an `ArenaAllocator` wrapping a backing allocator
- [ ] Use `arena.deinit()` for bulk deallocation
- [ ] Use `arena.reset(.retain_capacity)` for reuse
- [ ] Apply the two-allocator pattern (scratch arena + backing result)
- [ ] Know when arenas are appropriate vs inappropriate

## Prerequisites Check

Before starting, verify the student understands:
- `std.mem.Allocator` interface (Lesson 3.3)
- GPA creation and usage (Lesson 3.4)
- `defer` for cleanup
- The concept of temporary vs persistent data

## Teaching Approach

### Key Concepts to Emphasize

1. **"Free all at once" solves a real problem** — Many allocations with one cleanup. Draw the contrast with individual defer/free for each one.
2. **Arena wraps a backing allocator** — The arena gets memory from somewhere. That "somewhere" is the backing allocator.
3. **The two-allocator pattern** — This is THE pattern for ML inference. Scratch work → arena. Results → backing. Drill this.
4. **Don't return arena-allocated memory** — This is the #1 arena bug. Make sure they understand why.

### Python Bridge Points

| Python Concept | Zig Equivalent | Key Difference |
|----------------|----------------|----------------|
| GC batch collection | `arena.deinit()` | Explicit timing |
| `gc.collect()` | `arena.reset(.retain_capacity)` | You control it |
| All temps handled by GC | Arena for temps, backing for results | Explicit separation |

### Common Student Questions

**Q: "If arena.free() is a no-op, why does the allocator interface have free()?"**
A: Because code that takes `std.mem.Allocator` doesn't know it's backed by an arena. The interface must be consistent. Arena just makes `free` a no-op.

**Q: "When should I use arena vs GPA?"**
A: Arena when many allocations die together (request processing, per-inference scratch). GPA when allocations have independent lifetimes.

**Q: "Can I nest arenas?"**
A: Yes — an arena can back another arena. But start simple. You rarely need this.

## Misconception Alerts

- **Misconception**: "Arena replaces GPA"
  **Correction**: Arena wraps another allocator. You still need GPA (or something) as the backing.
  **How to explain**: "Arena is a strategy, not a source. It needs memory from somewhere."

- **Misconception**: "I should put everything in an arena"
  **Correction**: Only short-lived, batch-freed allocations. Long-lived data should use the backing allocator.
  **How to explain**: "If the data needs to survive the arena's deinit, it can't be in the arena."

## Exercise Facilitation

### Exercise 3.5: Arena Patterns

- **Goal**: Practice batch processing with arenas and the two-allocator pattern
- **Progressive hints** (if student struggles):
  1. "All the temporary allocations in batch processing can be freed at once. What allocator pattern does that?"
  2. "For `doubleValues`, the result must outlive the arena. Which allocator should the result come from?"
  3. "Create the arena from the backing allocator. Use the arena for scratch work. Use backing for the result."
- **Common mistakes to watch for**:
  - Allocating the result from the arena (use-after-free on return)
  - Forgetting `defer arena.deinit()`
  - Using the wrong allocator variable (mixing up `scratch` and `backing`)
  - Not using `errdefer` on the result allocation

## Debugging Support

| Error/Symptom | Likely Cause | How to Guide Them |
|---------------|--------------|-------------------|
| Use-after-free / garbage data | Result allocated from arena | "Which allocator did you use for the result?" |
| Memory leak | Missing `arena.deinit()` | "What frees all the arena allocations?" |
| Test reports leak | Result not freed by caller | "Who owns the returned memory?" |
| Unexpected values | Arena reset too early | "When does the arena get reset relative to using the data?" |

## Pacing Notes

- If breezing through: Discuss arena reset for batch processing loops. How would they process 10,000 items without growing memory?
- If struggling: Start with just `batchProcess` (many allocs, one deinit). The two-allocator pattern in `doubleValues` can wait.
- The two-allocator pattern is genuinely new and conceptually challenging. Give it time.
