# Module 2: Syntax Inventory

**Read this before teaching any Module 2 lesson.** Use it to verify the student has seen the syntax before asking them to produce it. If they haven't, introduce it first.

## Prerequisite Syntax (from Module 1)

The student can produce all syntax listed in `modules/01_foundations/syntax_inventory.md`. Key items relevant to Module 2:

- `const` / `var` declarations with type annotations
- Primitive types: `i32`, `u8`, `f64`, `bool`, `usize`
- `@as(Type, value)` — explicit type coercion
- `@floatFromInt(value)` — int to float conversion (Lesson 1.5)
- `@intCast(value)` — cast between integer sizes (Lesson 1.5)
- `for (slice) |item| { }` — iteration with capture
- `if (cond) { } else { }` — conditionals
- `switch (x) { ... }` — pattern matching
- `[]const T` — slice types for function parameters
- `&arr` — take a slice reference from an array
- `.{ .field = value }` — struct literal syntax (from arrays lesson)

---

## Lesson 2.1 — Functions Deep Dive

### Introduced (student should produce)
- `fn name(param: Type) ReturnType { return ...; }` — function declaration
- `pub fn` — public visibility modifier
- `void` — return type for functions that return nothing
- `[]const T` as function parameter type (for slices)
- `anytype` — generic parameter type
- `const Name = struct { field: Type, ... };` — named struct definition
- `return .{ .field = value, ... };` — returning struct literals
- `@divTrunc(a, b)` — truncated integer division (like Python's `int(a/b)`)
- `@rem(a, b)` — remainder after truncated division (like Python's `math.remainder`, but truncation-based)

### Shown in examples (student reads but doesn't write yet)
- `fn f(x: *i32) void { x.* *= 2; }` — pointer parameters (Module 3 topic)
- `&num` — taking address of a variable (Module 3 topic)
- `fn f(...) struct { min: i32, max: i32 } { }` — anonymous struct return type

### Also needed for Exercise 2.1
- `@floatFromInt(value)` — to convert `values.len` (usize) to `f64` for division (from Module 1 Lesson 1.5)
- `@divTrunc(a, b)` and `@rem(a, b)` — for the divmod function (taught in this lesson)

---

## Lesson 2.2 — Error Unions

### Introduced (student should produce)
- `const ErrorName = error{ Variant1, Variant2 };` — error set definition
- `return error.VariantName;` — returning an error
- `ErrorSet!ReturnType` — explicit error union return type
- `!ReturnType` — inferred error union return type
- `try expression` — propagate error to caller
- `catch |err| { }` — handle error with payload capture
- `catch default_value` — provide default on error
- `catch unreachable` — assert no error possible (use sparingly)
- `switch (err) { error.X => ..., else => ... }` — match on error variants
- `and` — boolean AND operator (e.g., `c >= '0' and c <= '9'`)
- `or` — boolean OR operator
- `!value` — boolean NOT operator
- Character arithmetic: `c - '0'` — converting a digit character to its numeric value
- `@as(i32, u8_value)` — widening cast (u8 to i32) for mixed-type arithmetic

### Shown in examples (student reads but doesn't write yet)
- `if (fallible()) |value| { } else |err| { }` — error union unwrapping with if
- `(FileError || ParseError)!Data` — combining error sets
- `anyerror` — matches any error type
- `@errorName(err)` — get error name as string

### Also needed for Exercise 2.2
- `and` keyword — for range checking in `parseDigit` (taught in this lesson)
- Character arithmetic `c - '0'` — for digit conversion (taught in this lesson)
- `@as(i32, digit)` — to widen `u8` result for arithmetic (from Module 1)
- `@divTrunc(a, b)` — for `safeDivide` (from Lesson 2.1)
- `try` — for `processValue` error propagation (taught in this lesson)

---

## Lesson 2.3 — Defer and Errdefer

### Introduced (student should produce)
- `defer expression;` — schedule cleanup at scope exit
- `errdefer expression;` — schedule cleanup only on error return
- Multiple defers execute in LIFO (reverse) order
- `defer obj.method();` — deferring a method call

### Shown in examples (student reads but doesn't write yet)
- `defer file.close();` — resource cleanup pattern
- `errdefer allocator.free(buffer);` — partial initialization cleanup

### Also needed for Exercise 2.3
- The `Counter` struct uses pointers (`*bool`, `*Counter`) — these are pre-written and the student does NOT need to modify them. Pointers are taught in Module 3.
- Student only writes: `defer counter.cleanup();`, `errdefer counter.cleanup();`, and three `defer std.debug.print(...)` lines for LIFO demo.

---

## Lesson 2.4 — Optionals

### Introduced (student should produce)
- `?T` — optional type (value or null)
- `null` — the absence-of-value literal
- `orelse default` — provide default when null
- `orelse { return; }` — orelse with block
- `if (optional) |value| { } else { }` — safe unwrapping
- `.?` — force unwrap (panics on null, use with care)

### Shown in examples (student reads but doesn't write yet)
- `!?T` — error union of optional
- `?*const Item` — optional pointer
- Optional struct fields: `field: ?u32 = null`

---

## Lesson 2.5 — Unions and Enums

### Introduced (student should produce)
- `const Color = enum { red, green, blue };` — enum definition
- `Color.green` — enum value access
- `enum(u16) { ok = 200 }` — enum with backing integer
- `@intFromEnum(value)` — enum to integer
- `union(enum) { variant: PayloadType, ... }` — tagged union
- `Value{ .int = 42 }` — creating union values
- `switch (v) { .int => |i| ..., .none => ... }` — switch with payload capture
- `v == .variant` — check active tag
- Methods on enums: `fn method(self: EnumType) ... { }`

---

## Lesson 2.6 — Comptime Basics

### Introduced (student should produce)
- `comptime` keyword for compile-time evaluation
- `comptime var x: i32 = 0;` — comptime variable
- `comptime { }` — comptime block
- `fn f(comptime T: type, ...) type { }` — comptime type parameters
- `@This()` — self-referencing type inside struct
- `@typeInfo(T)` — type introspection

### Shown in examples (student reads but doesn't write yet)
- Comptime string concatenation with `++`
- Returning types from functions
- Comptime conditionals on type

---

## NOT YET TAUGHT (common gaps to watch for)

These are commonly needed but **not introduced in Module 1 or 2**. Do not ask the student to produce them without explanation:

| Syntax | First Appears | Notes |
|--------|--------------|-------|
| Pointers (`*T`, `&x`, `x.*`) | Module 3 | Shown in examples in 2.1 and 2.3, but student doesn't write pointer code |
| `allocator.alloc()` / `.free()` | Module 3 | Memory allocation |
| `ArrayList(T)` | Module 4 | Dynamic arrays |
| `@ptrCast` | Module 3+ | Pointer type casting |
| Struct methods with `self: *Self` | Module 3+ | Methods that mutate (pointer receivers) |
| `async` / `await` | Not in course | Zig's async is being redesigned |
