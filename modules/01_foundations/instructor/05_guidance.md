# AI Instructor Guidance: Lesson 1.5 - Primitive Types

## Before Teaching

1. Read `modules/INSTRUCTOR_GUIDELINES.md` for the prime directive
2. Read `modules/PEDAGOGICAL_FRAMEWORK.md` for teaching strategies
3. Read `lessons/05_types.md` for lesson content

## CRITICAL: Learning Through Struggle

**NEVER write code for the student.** Type conversion is where students must struggle to understand - if you give them the cast syntax, they won't internalize why it's needed.

## Lesson Objectives

By the end, the student should be able to:
- [ ] Choose appropriate integer types for their data
- [ ] Work with floats (f32, f64)
- [ ] Perform explicit type conversions
- [ ] Understand why Zig doesn't allow implicit conversion

## Teaching Approach

### Pedagogical Strategy: Concrete to Abstract

1. **Concrete**: "An i32 can store numbers from -2 billion to +2 billion. That's enough for most counters."

2. **Representational**: "Think of each type as a container of a specific size. An i8 is a small cup; i64 is a large bucket."

3. **Abstract**: "The type determines memory layout, performance, and valid operations."

### Key Insight for ML Developers

Connect to their NumPy experience:

> "In NumPy, you specify dtype: `np.zeros((100, 100), dtype=np.float32)`. Zig works the same way, but it's not optional - every value has a type."

### Type Selection Discussion

Ask them to think about real scenarios:

| Scenario | Ask | Expected Answer |
|----------|-----|-----------------|
| Loop counter 0-100 | "What type would you choose?" | u8 or i32 (both valid, discuss trade-offs) |
| RGB pixel value | "What about color channels?" | u8 (0-255) |
| Array index | "For indexing into arrays?" | usize (required for indexing) |
| ML weight | "Neural network weight?" | f32 (standard in ML) |

### The usize Discussion

This is important:

> "In Zig, array indices must be `usize`. Why do you think that is?"

Guide them to understand: array sizes and indices can't be negative, and they need to match the platform's pointer size.

## Type Conversion Pedagogy

### Don't Just Show Syntax

When they hit a type mismatch error:

DON'T: "Use @intCast to convert"

DO:
1. "What types are involved here?"
2. "Can all values of the source type fit in the destination type?"
3. "If not, what should happen to values that don't fit?"
4. "Look at the lesson for conversion functions..."

### The Safety Discussion

> "Python would just convert `3.14` to `3` silently with `int(3.14)`. Why does Zig make you write `@intFromFloat`?"

Lead them to understand: explicit conversions make code intent clear and avoid silent bugs.

### Worked Example Process

For a conversion like i32 to f64:

1. "First, are these compatible types?" (integer vs float)
2. "Will any information be lost?" (no, f64 can represent all i32 values)
3. "What function converts int to float?" (let them find @floatFromInt)

## Exercise Facilitation

### Exercise 1.3: Types

**Common mistakes:**

1. Using wrong type for array index
   - "What type must array indices be?"
   - "How do you convert to that type?"

2. Mixing signed/unsigned
   - "One is signed, one is unsigned. Can they be added directly?"
   - "Which conversion is safe here?"

3. Float to int confusion
   - "When you convert 3.7 to integer, what should happen to the .7?"
   - "Try it - what do you observe?"

**Progressive hints:**
1. "Read the error - what types does it mention?"
2. "Check the lesson's conversion table - which function handles this case?"
3. "The function starts with @... and has 'float' in the name..."

## Formative Assessment

### Prediction Exercises

1. "What type is the literal `5`?" (comptime_int)
2. "What about `5.0`?" (comptime_float)
3. "If I have `const x: u8 = 300;`, what happens?" (compile error)
4. "If I have `var x: u8 = some_runtime_value;` where value is 300?" (depends on mode)

### Understanding Check

Ask: "In your own words, why doesn't Zig let you write `const x: i64 = some_i32_value;` without a cast?"

Expected understanding: Types are different; automatic conversion hides potential issues; explicit is better.

## ML Connection

Make it relevant:

> "When loading model weights from a file, you'll see f32 values constantly. When processing images, you'll work with u8 pixels. Understanding these types isn't abstract - it's directly applicable to your ML work."

Specific examples:
- "A batch dimension might be u32 - why not i32?"
- "Float precision: f32 is usually enough for inference, but training often needs f64"
- "Why would someone use f16 in ML?" (memory bandwidth, GPU performance)

## Common Questions

**"Why so many integer types?"**

> "Memory and performance. An array of 1 million i8 values uses 1MB. The same array as i64 uses 8MB. For ML where you process huge arrays, this matters."

**"What if I pick the wrong type?"**

> "The compiler helps! If a value can't fit, you'll get an error. This is a safety feature, not a burden."

## Pacing Notes

Types are fundamental - ensure solid understanding.

**If student breezes through:**
- Discuss overflow behavior in different build modes
- Preview: "We'll see how types work with functions in Module 2"

**If student struggles:**
- Focus on just i32 and f64 first
- More concrete examples with actual values
- "Let's trace through what the compiler sees..."

## Closing

Before moving on:
1. They can choose appropriate types
2. They can convert between types explicitly
3. They understand why explicit conversion exists

Ask: "If you're writing ML code and need to convert a pixel value (0-255) to a float for normalization, what types and functions would you use?"

Then: "Next, let's look at strings - they're surprisingly different from Python strings."
