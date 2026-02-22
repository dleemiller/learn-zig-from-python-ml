# AI Instructor Guidance: Lesson 2.4 - Optionals

## Before Teaching

1. Read `modules/INSTRUCTOR_GUIDELINES.md` for the prime directive
2. Read `modules/PEDAGOGICAL_FRAMEWORK.md` for teaching strategies
3. Read `lessons/04_optionals.md` for lesson content
4. Read `syntax_inventory.md` to check what syntax the student has seen

## CRITICAL: Learning Through Struggle

**NEVER write code for the student.** Optionals replace Python's None — let the student discover how `?T`, `orelse`, and unwrapping work through their own exploration.

## Your Role

You are teaching optional types (`?T`), Zig's way of representing "might not have a value." This is safer than Python's `None` everywhere.

## Lesson Objectives

By the end, the student should be able to:
- [ ] Understand `?T` as "T or null"
- [ ] Use `orelse` for default values
- [ ] Safely unwrap with `if (x) |val|`
- [ ] Choose between `?T` and `!T` appropriately

## Prerequisites Check

Verify the student understands:
- Error unions from Lesson 2.2
- The `catch` pattern (similar to `orelse`)
- Python's `None` and `Optional` type hints

## Teaching Approach

### The Billion Dollar Mistake

Tony Hoare called null references his "billion dollar mistake." Python's `None` can appear anywhere:

```python
user = get_user(id)
print(user.name)  # AttributeError if user is None!
```

Zig makes nullability explicit:

```zig
const user = getUser(id) orelse return;
// user is definitely not null here
std.debug.print("{s}\n", .{user.name});
```

### Key Concepts to Emphasize

1. **Explicit optionality**
   - `?T` tells you at the type level that null is possible
   - The compiler forces you to handle it
   - No more `AttributeError: 'NoneType' has no attribute`

2. **`orelse` for defaults**
   - Similar to `catch` for errors
   - Provides a value when null

3. **`if` for conditional access**
   - `if (maybe) |value|` unwraps safely
   - value is guaranteed non-null inside the block

### Python Bridge Points

| Python | Zig | Key Insight |
|--------|-----|-------------|
| `None` | `null` | Just the value |
| `Optional[T]` | `?T` | Type-level encoding |
| `x or default` | `x orelse default` | Short-circuit default |
| `if x is not None:` | `if (x) \|val\|` | Safe unwrapping |

### Common Student Questions

**Q: "When do I use `?T` vs `!T`?"**
A:
- `?T`: Value might not exist (find operations, optional config)
- `!T`: Operation might fail (I/O, parsing, allocation)

A "not found" result is often `?T` - it's not an error, just absence.
A file read failure is `!T` - something went wrong.

**Q: "Can I have `!?T`?"**
A: Yes! A function can both fail AND return null on success. Example: Try to read optional config from a file - might fail (file error) or succeed but have no value (key not found).

**Q: "Why not just return a sentinel value like -1?"**
A: Sentinel values are error-prone. What if -1 is a valid value? Optional types are self-documenting and type-safe.

## Misconception Alerts

- **Misconception**: "orelse and catch are the same"
  **Correction**: orelse handles null, catch handles errors
  **How to explain**: "?T uses orelse. !T uses catch. Different types, different handlers."

- **Misconception**: "I can always use `.?` to unwrap"
  **Correction**: `.?` panics on null - use only when you can prove it's non-null
  **How to explain**: "If you're not certain it's non-null, use orelse or if instead"

## Exercise Facilitation

### Exercise 2.4: Optionals

- **Goal**: Work with optional types safely
- **Progressive hints**:
  1. "The function might return null. What type represents that?"
  2. "You need to handle the null case. What operator provides a default?"
  3. "Use `if (value) |unwrapped|` to safely access the inner value"
- **Common mistakes**:
  - Using catch instead of orelse
  - Using `.?` unsafely
  - Not handling the null case at all
- **Follow-up**: "When would you return `?T` vs `!T` from a function?"

## Evaluating Student Work

Check:
- [ ] Are optionals used where values might be absent?
- [ ] Is null handled with orelse or if, not ignored?
- [ ] Is `.?` used only where null is impossible?
- [ ] Is the choice between ?T and !T appropriate?

## Debugging Support

| Error/Symptom | Likely Cause | How to Guide Them |
|---------------|--------------|-------------------|
| "cannot use optional type" | Trying to use ?T as T | "You have an optional. How do you get the value inside?" |
| "no member named 'orelse'" | Using orelse on non-optional | "What type is this? orelse works on optionals." |
| Panic at runtime | `.?` on null | "You assumed non-null but it was null. Use orelse or if instead." |

## ML Connections

- Optional config values (learning rate, batch size defaults)
- Lookup tables returning optional values
- Optional fields in parsed model configs
- "Not found" results in caches

## Pacing Notes

- Usually straightforward after error unions
- The `orelse` / `catch` distinction can confuse
- If breezing through: Discuss optional pointers and chaining
- If struggling: Focus on the parallel with error handling
