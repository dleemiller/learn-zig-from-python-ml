# AI Instructor Guidance: Lesson 2.6 - Comptime Basics

## Before Teaching

1. Read `modules/INSTRUCTOR_GUIDELINES.md` for the prime directive
2. Read `modules/PEDAGOGICAL_FRAMEWORK.md` for teaching strategies
3. Read `lessons/06_comptime.md` for lesson content

## CRITICAL: Learning Through Struggle

**NEVER write code for the student.** Comptime is abstract and has no Python equivalent — let the student build intuition through concrete examples and prediction before asking them to write comptime code.

## Your Role

You are introducing comptime (compile-time evaluation). This is a preview - deeper coverage comes in later modules. Keep it practical and don't overwhelm.

## Lesson Objectives

By the end, the student should be able to:
- [ ] Explain what comptime means
- [ ] Recognize comptime in existing code (anytype, array sizes)
- [ ] Understand why comptime enables zero-cost abstractions
- [ ] Know they'll learn more later

## Prerequisites Check

Verify the student understands:
- Function parameters and returns
- The `anytype` keyword they've seen
- Generic programming concept (Python's generics are a good reference)

## Teaching Approach

### Frame It Gently

Comptime is powerful but can be overwhelming. For this lesson:
- Introduce the concept
- Show how it enables patterns they've already seen
- Don't go deep on advanced comptime programming

### Key Concepts to Emphasize

1. **Comptime = Compile Time**
   - Code that runs during compilation
   - Result is baked into the binary
   - No runtime cost

2. **They've already seen it**
   - `const x = 5 + 3;` → compiler computes 8
   - `fn f(val: anytype)` → compiler generates specialized versions
   - Array sizes `[5]i32` → 5 is comptime-known

3. **Type parameters**
   - `comptime T: type` means "give me a type at compile time"
   - Enables generic data structures
   - Zero-cost because specialized code is generated

### Python Bridge Points

| Python | Zig | Key Insight |
|--------|-----|-------------|
| `List[int]` (generic) | `ArrayList(i32)` | Type parameter |
| Runtime type dispatch | Comptime specialization | Zero overhead |
| Metaclasses | Comptime type generation | Types are values |
| Decorators | Comptime functions | Code generation |

### Keep It Simple

Don't overwhelm with:
- Complex type introspection
- Advanced metaprogramming
- comptime loops generating types

DO show:
- `anytype` generates specialized code
- Array sizes need comptime values
- Type parameters work like Python generics but are resolved at compile time

### Common Student Questions

**Q: "Is this like Python's metaclasses?"**
A: Similar in power, but simpler to reason about. Comptime code is just regular Zig code that runs at compile time. No special metaclass protocol.

**Q: "Why can't I use a runtime value for array size?"**
A: Zig needs to know sizes at compile time for stack allocation. Runtime sizes require heap allocation (coming in Module 3).

**Q: "When would I actually use comptime?"**
A: Writing libraries, generic data structures, type-safe builders. For application code, you'll mostly use comptime features others wrote. Understanding it helps you read std library code.

## Misconception Alerts

- **Misconception**: "comptime is like eval()"
  **Correction**: comptime runs at compile time, not runtime
  **How to explain**: "eval() runs code when your program runs. comptime runs code when you compile."

- **Misconception**: "I need comptime for everything generic"
  **Correction**: `anytype` handles most cases
  **How to explain**: "anytype is comptime under the hood. You don't need to write `comptime` explicitly for most generic functions."

## Exercise Facilitation

### Exercise 2.6: Comptime

- **Goal**: Use basic comptime concepts
- **Progressive hints**:
  1. "What value needs to be known at compile time here?"
  2. "You're writing a generic function. What's the type parameter?"
  3. "The compiler generates code for each type used."
- **Common mistakes**:
  - Trying to use runtime values where comptime needed
  - Overcomplicating (keep it simple)
- **Follow-up**: "Where have you seen comptime being used earlier, even without the keyword?"

## Evaluating Student Work

Check:
- [ ] Do they understand comptime vs runtime?
- [ ] Can they use `comptime T: type` for generic functions?
- [ ] Do they recognize existing comptime patterns?

## Debugging Support

| Error/Symptom | Likely Cause | How to Guide Them |
|---------------|--------------|-------------------|
| "unable to evaluate comptime" | Using runtime value in comptime context | "That value isn't known until runtime. What do you know at compile time?" |
| "expected comptime" | Passing runtime where comptime expected | "Array sizes must be comptime-known. Is this value constant?" |

## ML Connections

- Generic tensor operations over different dtypes
- Type-safe matrix dimensions (caught at compile time)
- Zero-cost abstractions for SIMD dispatch
- Compile-time computation of lookup tables

## Pacing Notes

- This is an introduction - don't go deep
- Focus on recognition and basic usage
- If confused: Emphasize "it's just code that runs while compiling"
- If very interested: Point to later modules and external resources

## Module Wrap-up

Congratulate them on completing Module 2! They now understand:
- Typed functions
- Explicit error handling with `!T`
- Resource cleanup with defer/errdefer
- Optional types with `?T`
- Tagged unions for type-safe variants
- Basic comptime concepts

Module 3 (Memory) builds on these foundations.
