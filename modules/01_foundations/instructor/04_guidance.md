# AI Instructor Guidance: Lesson 1.4 - Variables and Constants

## Before Teaching

1. Read `modules/INSTRUCTOR_GUIDELINES.md` for the prime directive
2. Read `modules/PEDAGOGICAL_FRAMEWORK.md` for teaching strategies
3. Read `lessons/04_variables.md` for lesson content

## CRITICAL: Learning Through Struggle

**NEVER write code for the student.** When they make mistakes with `var`/`const`, guide them with questions to discover the error themselves.

## Lesson Objectives

By the end, the student should be able to:
- [ ] Choose between `var` and `const` appropriately
- [ ] Declare variables with explicit types
- [ ] Understand type inference limits
- [ ] Avoid using `undefined` inappropriately

## Teaching Approach

### Pedagogical Strategy: Cognitive Conflict

Create moments where Python intuition breaks:

```zig
// Show this:
const x = 5;
x = 10;  // What happens?
```

Let them predict, then see the error. This creates memorable learning.

### Key Concept Emphasis

1. **Immutability by Default**: In Zig, `const` is the norm. This is the opposite of Python where everything is mutable by default.

2. **Explicit Mutability**: `var` is an explicit choice. Ask: "Why might requiring this be helpful for catching bugs?"

3. **Type Annotations**: Connect to Python type hints, but note these are enforced.

### Python Bridge Discussion

Start with:

> "In Python, you write `x = 5` and that's it. Let's see how Zig approaches this differently, and why that matters for the kind of code we're writing."

| Python | Zig | Discussion Point |
|--------|-----|------------------|
| `x = 5` | `const x: i32 = 5;` | "Why do you think Zig wants to know the size?" |
| `PI = 3.14` (convention) | `const pi = 3.14;` | "In Python, what stops you from doing `PI = 0`?" |
| `x: int = 5` | `const x: i32 = 5;` | "Similar syntax! But Zig enforces it" |

### Prediction Exercises

Use predictions to check understanding:

1. "If I write `const x = 5;` and then `const y = x + 10;`, what's y's type?"

2. "If I write `var x = 5;`, will this compile? Why or why not?"

3. "If I write `var x: i32 = undefined; const y = x + 1;`, what happens?"

### Common Misconception: `undefined` Safety

Students may think `undefined` is like Python's `None`:

> "It's not a safe 'empty' value - it's literally undefined. Reading it before writing is like reading random memory. Why do you think Zig allows this at all?"

Lead them to understand: buffer initialization patterns.

## Exercise Facilitation

### Exercise 1.2: Variables

**Watch for these mistakes:**

1. Using `var` when `const` would work
   - Ask: "Does this value ever change? What should we use for values that don't change?"

2. Forgetting type annotations on `var`
   - Ask: "The compiler says it can't infer the type. Why might that be?"

3. Trying to use `const` then modify
   - Ask: "What does `const` mean? Can you use something else?"

**Progressive hints:**
1. "Read the error message carefully - what is it telling you about types?"
2. "Is this value going to change later, or is it fixed?"
3. "What type do you want this to be? How do you tell Zig?"

**After completion, discuss:**
- "When would you use `var` vs `const` in a real program?"
- "Why do you think Zig makes you be explicit about mutability?"

## Error Message Practice

Have them trigger specific errors:

1. **Modify const**: `const x = 5; x = 10;`
   - "What does this error tell you?"

2. **Missing type**: `var x = 5;`
   - "Why does `var` need a type but `const` doesn't?"

3. **Undefined read**: Have them think about what would happen

## Formative Assessment Questions

Check understanding throughout:

- "If I'm writing a loop counter, should it be `var` or `const`?"
- "If I'm storing a configuration value that never changes, which?"
- "What's the benefit of Zig forcing you to choose?"

## Metacognition Checkpoint

After the lesson:

"This is probably the first big mindset shift from Python - being explicit about mutability. What's your gut reaction? Does it feel like extra work, or does it feel helpful?"

Listen to their response. If they see it as overhead, explain the debugging benefits. If they're on board, validate and move on.

## Pacing Notes

This concept is fundamental - don't rush.

**If student breezes through:**
- Discuss comptime values: "What do you think `comptime var` means?"
- Preview Module 2: "We'll see how `const` interacts with functions"

**If student struggles:**
- More examples: "Let's look at more cases together"
- Relate to Python type hints: "It's like type hints that are actually enforced"

## Common Questions

**"Why can't var infer types like const?"**

> "const values are often comptime - the compiler knows them during compilation. var values can change at runtime, so the compiler needs to reserve the right amount of memory. What size should an untyped `5` be - 1 byte? 8 bytes?"

**"undefined seems dangerous - why have it?"**

> "It's for performance-critical code where you know you'll initialize soon. We'll see this in buffers and arrays. For now, always initialize your variables."

## Closing

Before moving on:
1. They can declare both `var` and `const` correctly
2. They understand why types are required for `var`
3. They know `undefined` is dangerous

Ask: "In one sentence, what's the difference between `var` and `const`?"

Then: "Next, we'll look at the types themselves - Zig has many more than Python's simple int/float!"
