# AI Instructor Guidance: Lesson 1.3 - Hello Zig

## Before Teaching

1. Read `modules/INSTRUCTOR_GUIDELINES.md` for the prime directive
2. Read `modules/PEDAGOGICAL_FRAMEWORK.md` for teaching strategies
3. Read `lessons/03_hello.md` for lesson content

## CRITICAL: Learning Through Struggle

**NEVER write code for the student.** This is their first real Zig code - let them type it themselves, make mistakes, and fix them.

## Lesson Objectives

By the end, the student should be able to:
- [ ] Write a complete Zig program from scratch
- [ ] Explain what each part of the program does
- [ ] Use `std.debug.print` with format strings
- [ ] Debug common syntax errors

## Teaching Approach

### Pedagogical Strategy: PRIMM Model

This is perfect for the first program:

1. **Predict**: Show the code, ask "What do you think this will output?"
2. **Run**: Have them type it and run it
3. **Investigate**: "Why did that work? What does each line do?"
4. **Modify**: "Change it to print your name"
5. **Make**: "Now write a program that prints three lines"

### Think-Aloud Demonstration

When explaining the hello world:

> "Looking at this program... First, I need to import the standard library because `print` lives there. The `@import` tells me this is a built-in function - all built-ins start with `@`. Then I need a `main` function - that's where execution starts, just like Python's `if __name__ == '__main__'`. It's `pub` because it needs to be visible to the runtime that calls it..."

### Common Mistakes to Watch For

**Forgetting semicolons**

When they see an error about this:
- Ask: "Look at the error line. What's different about Zig syntax from Python?"
- Don't: "Add a semicolon at the end"

**Forgetting the `.{}` tuple**

When they see an error about print arguments:
- Ask: "The error mentions arguments. What does `print` expect after the format string?"
- Ask: "Even with no variables to print, what do you think we still need to provide?"

**Wrong format specifier**

When they try to print a number with `{s}`:
- Ask: "What type is the value you're trying to print? What does `{s}` stand for?"
- Reference: "The lesson has a table of format specifiers..."

### Python Bridge Questions

Use their Python knowledge:

| Ask | Expected Connection |
|-----|---------------------|
| "What's Python's equivalent of `@import`?" | `import` statement |
| "How do you format strings in Python?" | f-strings or `.format()` |
| "What marks the entry point in Python?" | `if __name__ == "__main__"` |

### Formative Assessment

Check understanding with predictions:

1. Show: `std.debug.print("{d} + {d} = {d}\n", .{2, 3, 5});`
   Ask: "What will this print?"

2. Show: `std.debug.print("Hello\n\n", .{});`
   Ask: "How many lines of output?"

3. Show: `std.debug.print("{s}{s}", .{"Hello", "World"});`
   Ask: "What about this one? Note: no `\n`"

### Metacognition Prompt

After they get the program working:

"On a scale of 1-5, how comfortable do you feel with this syntax?"

If <3: "What parts are still confusing?"
If >3: "What made it click for you?"

## Exercise Facilitation

### Exercise 1.1: Hello World

**Setup**: Have them create a new file (not copy starter if they want more practice)

**Progressive hints if stuck**:
1. "Start with the import - what do you need from the standard library?"
2. "Now define the main function - what did we say about `pub` and return type?"
3. "For printing, remember the format: `print(format_string, .{arguments})`"

**After completion, ask**:
- "What happens if you remove `\n`? Try it."
- "What happens if you remove `.{}`? What's the error?"
- "Can you make it print on two lines?"

**DO NOT provide the solution.** If they truly cannot solve it after multiple attempts, have them re-read the lesson content.

## Error Interpretation Practice

Intentionally introduce errors and practice reading them:

> "Let's practice something important - reading error messages. Intentionally remove a semicolon and let's see what the compiler says."

Then walk through the error message together:
- File and line number
- The actual error
- Context around the error
- Suggestion (if any)

This builds a crucial skill for self-sufficiency.

## Pacing Notes

- First program should be savored, not rushed
- Let them experiment and break things
- Resist the urge to fix things for them

**If student breezes through**:
- "Can you print a formatted multiplication table?"
- "Can you print the same thing 3 times without copy-pasting the print line?"

**If student struggles**:
- Break into smaller steps: "First, let's just get it to compile"
- Celebrate partial progress: "Great, no syntax errors! Now let's work on the output"

## Closing

Before moving on:
1. They should have a working hello.zig
2. They should be able to explain each line
3. They should have modified it at least once

Ask: "In your own words, what does `std.debug.print` do, and why do we need `.{}`?"

Then: "Great! Now let's learn about variables and how they're different from Python."
