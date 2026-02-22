# AI Instructor Guidance: Lesson 1.6 - Strings and Slices

## Before Teaching

1. Read `modules/INSTRUCTOR_GUIDELINES.md` for the prime directive
2. Read `modules/PEDAGOGICAL_FRAMEWORK.md` for teaching strategies
3. Read `lessons/06_strings.md` for lesson content

## CRITICAL: Learning Through Struggle

**NEVER write code for the student.** Strings are confusing for Python developers. Let them discover the byte-slice reality through their own exploration.

## Lesson Objectives

By the end, the student should be able to:
- [ ] Explain that Zig strings are byte slices
- [ ] Work with `[]const u8` and `[]u8`
- [ ] Use string iteration and slicing
- [ ] Compare strings correctly

## Teaching Approach

### Key Insight: Strings Are NOT Special

This is the critical mental shift:

> "In Python, `str` is a distinct type with dozens of methods. In Zig, 'strings' are just byte slices. There's no `String` type. This is a feature, not a limitation."

### Python Comparison Discussion

| Python | Zig | Why Different |
|--------|-----|---------------|
| `"hello"` is str | `"hello"` is `[]const u8` | Just bytes |
| `len("hello")` = 5 | `"hello".len` = 5 | Similar |
| `"hello"[0]` = "h" | `"hello"[0]` = 104 | Byte value! |
| `"a" + "b"` = "ab" | Error | No runtime concat |

### The Byte Reality

Demonstrate:
```zig
const str = "Hello";
std.debug.print("{c}\n", .{str[0]});  // Prints: H
std.debug.print("{d}\n", .{str[0]});  // Prints: 72
```

Ask: "Why does it print 72? What does 72 represent?"

### UTF-8 Mind-Bender

This trips up everyone:

```zig
const emoji = "Hello ";
std.debug.print("len = {d}\n", .{emoji.len});
```

Ask: "What do you predict the length will be?"

Let them see it's 10 (not 7), then discuss UTF-8 encoding.

## Common Misconception: String Equality

Students will try:
```zig
if (str1 == str2) { ... }
```

When they see unexpected behavior:
- Don't: "Use std.mem.eql"
- Do: "What do you think `==` compares for slices?"

Lead them to understand: `==` compares pointers and lengths, not contents.

## Exercise Facilitation

### Exercise 1.4: Strings

**Watch for:**

1. Using `==` for string comparison
   - "Did it work? Why might two identical strings not be `==`?"

2. Trying to modify string literals
   - "What error do you see? What does `const` mean in the type?"

3. UTF-8 confusion
   - "Count the bytes vs the characters. Are they the same?"

**After completion:**
- "How would you check if two user inputs are the same?"
- "Why do you think Zig doesn't have a `String` type?"

## Pacing Notes

Strings often take longer than expected for Python developers. Don't rush.

**If struggling:** Focus just on `[]const u8` and basic operations. Save UTF-8 details for later.

**If breezing:** Discuss how real string libraries work (allocated strings, rope structures).
