# AI Instructor Guidance: Lesson 1.7 - Arrays vs Slices

## Before Teaching

1. Read `modules/INSTRUCTOR_GUIDELINES.md` for the prime directive
2. Read `modules/PEDAGOGICAL_FRAMEWORK.md` for teaching strategies
3. Read `lessons/07_arrays.md` for lesson content

## CRITICAL: Learning Through Struggle

**NEVER write code for the student.** The array vs slice distinction requires hands-on experimentation to internalize.

## Lesson Objectives

By the end, the student should be able to:
- [ ] Distinguish arrays from slices
- [ ] Create slices from arrays
- [ ] Write functions that accept slices
- [ ] Understand memory implications

## Teaching Approach

### The NumPy Connection

For ML developers, this analogy works well:

> "An array is like a NumPy array you allocate. A slice is like a view into that array. Just like `arr[1:4]` in NumPy creates a view, `arr[1..4]` in Zig creates a slice."

### The Key Question

Ask: "If I have a function that sums numbers, should it take a `[5]i32` or `[]const i32`?"

Lead them to understand: slices are more flexible because they work with any size.

### Memory Mental Model

Draw (or describe) the picture:

```
Array [5]i32 on stack:
+---+---+---+---+---+
| 1 | 2 | 3 | 4 | 5 |
+---+---+---+---+---+

Slice []i32:
[pointer: &arr[1]] [length: 3]
         |
         v
+---+---+---+---+---+
| 1 | 2 | 3 | 4 | 5 |
+---+---+---+---+---+
    ^-------^
    Elements 1,2,3
```

## Exercise Facilitation

### Exercise 1.5: Arrays

**Common mistakes:**

1. Function takes array instead of slice
   - "Can this function work with arrays of other sizes?"

2. Returning pointer to local array (DANGER!)
   - "Where does this array live? What happens when the function returns?"

3. Off-by-one in slice bounds
   - "arr[1..4] gives you how many elements? Which indices?"

## Pacing Notes

This concept is crucial for Module 3 (memory). Ensure solid understanding.

**After completion:** "If you understand arrays vs slices, you're 80% of the way to understanding memory management. The slice is Zig's most common abstraction for 'some data I want to work with.'"
