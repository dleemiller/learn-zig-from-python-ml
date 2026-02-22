# AI Instructor Guidance: Lesson 1.8 - Control Flow

## Before Teaching

1. Read `modules/INSTRUCTOR_GUIDELINES.md` for the prime directive
2. Read `modules/PEDAGOGICAL_FRAMEWORK.md` for teaching strategies
3. Read `lessons/08_control_flow.md` for lesson content

## CRITICAL: Learning Through Struggle

**NEVER write code for the student.** Control flow exercises like FizzBuzz are perfect for learning through doing.

## Lesson Objectives

By the end, the student should be able to:
- [ ] Use if/else as expressions
- [ ] Write exhaustive switch statements
- [ ] Use for loops with various patterns
- [ ] Break and continue effectively

## Teaching Approach

### Expression-Based If

This is new for Python developers:

```zig
const abs_value = if (x < 0) -x else x;
```

Ask: "How would you write this in Python?" (`abs_value = -x if x < 0 else x`)
"It's the same concept, just different syntax order."

### Switch Exhaustiveness

This is a safety feature. Demonstrate:

```zig
const x: u8 = 100;
switch (x) {
    0 => {},
    1 => {},
    // Compile error!
}
```

Ask: "Why does Zig require you to handle all 256 cases?"

Lead them to: catching unhandled cases at compile time prevents bugs.

### No Truthy/Falsy

This WILL trip them up:

```zig
if (count) { }  // Error!
```

Don't just tell them - let them hit this error and discover it.

## Exercise Facilitation

### Exercise 1.7: FizzBuzz

This is the classic - perfect for synthesis.

**Progressive hints if stuck:**
1. "What condition checks divisibility by 3?"
2. "What should you check first - divisibility by 15, or by 3 and 5 separately?"
3. "How do you print different things for different conditions?"

**After completion:**
- "Can you solve it without using else if?"
- "What other approaches could work?"

### Exercise 1.8: Calculator

Integration exercise combining everything from Module 1.

**Watch for:**
- Type handling (string input to numbers)
- Error handling hints (we'll cover this properly in Module 2)

## Module Completion

After this lesson, celebrate completion of Module 1:

"You've completed the Foundations module! You now know:
- How to write and run Zig programs
- Variables, constants, and types
- Strings and arrays
- Control flow

Next, we'll dive into functions and error handling - Zig's unique approach that makes code safer."
