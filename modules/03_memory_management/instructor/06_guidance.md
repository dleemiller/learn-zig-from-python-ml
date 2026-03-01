# AI Instructor Guidance: Lesson 3.6 - FixedBufferAllocator

## Before Teaching

1. Read `modules/INSTRUCTOR_GUIDELINES.md` for the prime directive
2. Read `modules/PEDAGOGICAL_FRAMEWORK.md` for teaching strategies
3. Read `lessons/06_fixed_buffer.md` for lesson content
4. Read `syntax_inventory.md` to check what syntax the student has seen

## CRITICAL: Learning Through Struggle

**NEVER write code for the student.** This lesson reinforces that the allocator interface is the same regardless of backing. Let the student discover that their existing alloc/free code works identically with FBA — that's the aha-moment.

## Your Role

You are teaching the FixedBufferAllocator — the simplest allocator, perfect for when you know the maximum size upfront. This lesson also cements the allocator interface concept: same code, different strategies.

## Lesson Objectives

By the end, the student should be able to:
- [ ] Create a `FixedBufferAllocator` from a stack buffer
- [ ] Handle `OutOfMemory` when the buffer is full
- [ ] Understand that the allocator interface is the same regardless of backing
- [ ] Know when FBA is appropriate

## Prerequisites Check

Before starting, verify the student understands:
- `std.mem.Allocator` interface (Lesson 3.3)
- Error handling for `error.OutOfMemory` (Module 2)
- Stack-allocated arrays (Module 1)

## Teaching Approach

### Key Concepts to Emphasize

1. **Same interface, different backing** — The student's allocator code works unchanged with FBA. This is the polymorphism payoff.
2. **Bounded memory** — FBA can't grow. When it's full, you get OutOfMemory. This is a feature, not a bug — it prevents runaway allocation.
3. **No heap required** — For embedded or constrained environments. Also great for small scratch buffers where heap overhead isn't worth it.

### Python Bridge Points

| Python Concept | Zig Equivalent | Key Difference |
|----------------|----------------|----------------|
| No equivalent (always heap) | Stack buffer + FBA | No OS calls |
| `io.BytesIO(b'\x00' * N)` | `var buf: [N]u8 = undefined;` | Stack allocation |
| Unlimited memory (practically) | Fixed budget, explicit failure | Bounded |

### Common Student Questions

**Q: "Why use FBA when GPA works everywhere?"**
A: Speed and predictability. No OS calls, no heap fragmentation, no surprise allocations. For a small, known-size scratch buffer, FBA is faster.

**Q: "How do I know what buffer size to use?"**
A: Calculate it: count of items × `@sizeOf(T)` + some alignment padding. Start generous and tune later.

**Q: "Can FBA back an arena?"**
A: Yes! An arena backed by FBA gives you no-heap batch allocation. Useful in embedded systems.

## Misconception Alerts

- **Misconception**: "FBA is just a worse GPA"
  **Correction**: FBA has zero overhead, zero OS calls, and bounded memory. It's better for constrained scenarios.
  **How to explain**: "GPA is general-purpose. FBA is for when you know exactly how much memory you need."

- **Misconception**: "I need to free FBA allocations individually"
  **Correction**: FBA has limited free support. Use `reset()` for bulk cleanup, similar to arena.
  **How to explain**: "Think of FBA like a simple arena — it carves up a buffer. Reset to start over."

## Exercise Facilitation

### Exercise 3.6: FixedBufferAllocator

- **Goal**: Allocate from a provided buffer; handle buffer-too-small errors
- **Progressive hints** (if student struggles):
  1. "How do you create an FBA from a buffer? What method on `std.heap.FixedBufferAllocator`?"
  2. "Once you have the FBA, getting an allocator is the same as with GPA or arena."
  3. "What error do you get when the buffer is too small? How do you handle it?"
- **Common mistakes to watch for**:
  - Passing the buffer by value instead of by pointer (`&buf`)
  - Not handling the OutOfMemory case
  - Confusing the byte-size of the buffer with the number of items that fit

## Debugging Support

| Error/Symptom | Likely Cause | How to Guide Them |
|---------------|--------------|-------------------|
| OutOfMemory unexpectedly | Buffer too small for requested items | "How many bytes do your items need? How big is the buffer?" |
| "expected `*[N]u8`" | Buffer type mismatch | "FBA needs a slice of bytes. How do you pass your buffer?" |
| Test expects error but gets success | Buffer big enough for test case | "Check the test — what size buffer does it use?" |

## Pacing Notes

- If breezing through: Challenge them to calculate the minimum buffer size for a specific allocation. Account for alignment.
- If struggling: Focus on the "same interface" insight. Have them copy their Lesson 3.3 code and just swap the allocator. See that it works.
- This is a shorter lesson (~20 min). Don't stretch it. The key insight (interface polymorphism) is more important than FBA details.
