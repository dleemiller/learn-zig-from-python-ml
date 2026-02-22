# AI Instructor Guidance: Lesson 2.5 - Unions and Enums

## Your Role

You are teaching enums and tagged unions. These provide type-safe alternatives to Python's enums and Union types.

## Lesson Objectives

By the end, the student should be able to:
- [ ] Define and use enums
- [ ] Create tagged unions with payloads
- [ ] Use switch exhaustively on enums and unions
- [ ] Capture payload values in switch

## Prerequisites Check

Verify the student understands:
- Switch statements from Module 1
- Basic struct syntax (will see more in Module 4)
- Python's Enum class and type Union hints

## Teaching Approach

### Two Related Concepts

1. **Enum**: Named set of values (like Python's Enum)
2. **Tagged Union**: One of several types, with a tag (like Python's Union type hints, but enforced)

Start with enums (familiar), then build to unions (powerful).

### Key Concepts to Emphasize

1. **Exhaustive switches**
   - Compiler requires all cases
   - Adding a new variant → compiler shows all places to update
   - No forgotten cases

2. **Tagged unions carry data**
   - Each variant can have different associated data
   - More powerful than enums alone
   - Type-safe state machines

3. **Payload capture with `|value|`**
   - Similar pattern to error handling and optionals
   - Extracts the inner value safely

### Python Bridge Points

| Python | Zig | Key Insight |
|--------|-----|-------------|
| `class State(Enum)` | `const State = enum` | Named values |
| `Union[A, B, C]` | `union(enum)` | Tagged union |
| `match` (3.10+) | `switch` | Pattern matching |
| `isinstance()` | `v == .variant` | Check active variant |

### The Power of Tagged Unions

Python:
```python
# State might be string, might be dict, unclear
state = "loading"  # or {"data": [...], "page": 2}
```

Zig:
```zig
const State = union(enum) {
    loading,
    loaded: struct { data: []u8, page: u32 },
    failed: []const u8,  // error message
};
// Compiler enforces correct handling of each variant
```

### Common Student Questions

**Q: "Why not just use a struct with optional fields?"**
A: A struct with optionals allows invalid states (multiple fields set, or none). A union allows exactly one variant at a time - it's a cleaner model for state machines.

**Q: "What's the difference between `enum` and `union(enum)`?"**
A: Enum: just named values, no data. Union: each variant can carry different data. Use enum when you just need names; use union when variants have payloads.

**Q: "Why does switch need to be exhaustive?"**
A: If you add a new variant later, the compiler shows you every place that needs updating. With `else`, you'd silently fall through. Exhaustiveness is a feature.

## Misconception Alerts

- **Misconception**: "I can access any union variant"
  **Correction**: Only the active variant is accessible
  **How to explain**: "A union holds ONE value at a time. The tag tells you which one."

- **Misconception**: "switch else is fine for enums"
  **Correction**: Prefer exhaustive handling; else hides forgotten cases
  **How to explain**: "What happens when you add a new enum value? With else, it silently falls through."

## Exercise Facilitation

### Exercise 2.5: Unions

- **Goal**: Define and use tagged unions for type-safe variants
- **Progressive hints**:
  1. "What are the possible states? List them as union variants."
  2. "Each variant might have different data. What does each one need?"
  3. "Use switch to handle each variant. Capture the payload with |value|."
- **Common mistakes**:
  - Forgetting `(enum)` in `union(enum)`
  - Not capturing payload in switch
  - Using else instead of exhaustive handling
- **Follow-up**: "What would happen if you added a new variant? How would the compiler help?"

## Evaluating Student Work

Check:
- [ ] Are enums used for simple named values?
- [ ] Are tagged unions used when variants have data?
- [ ] Is switch exhaustive (no unnecessary else)?
- [ ] Are payloads captured correctly?

## Debugging Support

| Error/Symptom | Likely Cause | How to Guide Them |
|---------------|--------------|-------------------|
| "switch must handle all cases" | Missing variant in switch | "Which variant are you not handling?" |
| "cannot access field" | Accessing wrong variant's payload | "What variant is active? You can only access that one." |
| "expected enum, found union" | Using wrong syntax | "Is this an enum (named values) or union (with payloads)?" |

## Real-World Pattern: Result Type

```zig
const Result = union(enum) {
    ok: Data,
    err: Error,
};
```

This pattern appears throughout Zig's std library.

## ML Connections

- Model states: Uninitialized, Loading, Ready, Failed
- Layer types: Linear, Conv, Attention (each with different params)
- Activation functions: ReLU, GELU, Softmax (each might need config)
- Training status: Epoch progress, validation, checkpoint

## Pacing Notes

- Enums are usually quick (familiar from Python)
- Unions take more time to click
- If breezing through: Discuss union layout and memory
- If struggling: Focus on the state machine mental model
