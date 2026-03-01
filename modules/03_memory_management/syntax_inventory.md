# Module 3: Memory Management — Syntax Inventory

**Read this before teaching any Module 3 lesson.** Use it to verify the student has seen the syntax before asking them to produce it.

## Prerequisites from Modules 1 and 2

The student can produce all syntax listed in Module 1 and Module 2 syntax inventories. Key items relevant to Module 3:

- `const` / `var` declarations with type annotations
- Primitive types: `i32`, `u8`, `f64`, `bool`, `usize`
- `[N]T` — fixed-size arrays, `[_]T{...}` — inferred-size arrays
- `[]const T` / `[]T` — slice types
- `&arr` — take a slice reference from an array
- `for (slice) |item| { }` — iteration
- `for (slice, 0..) |item, i| { }` — iteration with index
- `if (cond) { } else { }` — conditionals
- `fn name(param: Type) ReturnType { }` — function declaration
- `pub fn` — public visibility
- `const ErrorSet = error{ ... };` — error set definition
- `!ReturnType` — inferred error union return type
- `try expression` — propagate errors
- `catch |err| { }` — handle errors
- `defer expression;` — cleanup at scope exit
- `errdefer expression;` — cleanup on error return only
- `?T`, `orelse`, `if (opt) |val| { }` — optionals
- `const Name = struct { field: Type, ... };` — struct definition
- `@sizeOf(T)` — size of a type in bytes (Lesson 1.5)
- `@as(Type, value)` — explicit type coercion
- `@intCast(value)` — cast between integer sizes
- `@rem(a, b)` — remainder

---

## Lesson 3.1 — Stack vs Heap

### Introduced (student should produce)
- No new syntax — this is a conceptual lesson
- Students practice reading code that demonstrates stack lifetimes and value semantics

### Shown in examples (student reads but doesn't write yet)
- `@sizeOf(T)` used to illustrate memory sizes (already known from Module 1)
- Stack frame diagrams and lifetime concepts

### Also needed for Exercise 3.1
- `fn name(param: Type) ReturnType { }` — function declaration (Module 1/2)
- `[N]i32` — fixed-size array types (Module 1)
- `[]const i32` — slice parameter types (Module 1)
- `return` — returning values from functions (Module 1)
- `for (slice) |item| { }` — iteration (Module 1)
- `var` — mutable local variables (Module 1)

---

## Lesson 3.2 — Pointers Demystified

### Introduced (student should produce)
- `*T` — single-item mutable pointer type
- `*const T` — single-item const pointer type
- `&variable` — take the address of a variable
- `ptr.*` — dereference a pointer (read or write the pointed-to value)
- `fn f(ptr: *i32) void` — pointer parameter for mutation
- `fn f(values: []i32) void` — mutable slice parameter

### Shown in examples (student reads but doesn't write yet)
- `[*]T` — many-item pointer (mentioned, not exercised)
- `@intFromPtr(ptr)` — pointer to integer (for illustration only)

### Also needed for Exercise 3.2
- `[]i32` — mutable slice type (Module 1, now used for mutation)
- `for (slice) |item| { }` and `for (slice) |*item| { }` — iteration with pointer capture
- `var` — mutable variables to take address of (Module 1)
- `if` / comparison operators — for finding max element (Module 1)

---

## Lesson 3.3 — Allocator Interface

### Introduced (student should produce)
- `std.mem.Allocator` — the allocator interface type
- `try allocator.alloc(T, n)` — allocate a slice of n items
- `allocator.free(slice)` — free a previously allocated slice
- `try allocator.create(T)` — allocate a single item
- `allocator.destroy(ptr)` — free a single item
- `@memset(slice, value)` — fill a slice with a value
- `defer allocator.free(slice);` — free-on-scope-exit pattern
- `allocator.alloc(T, n) catch unreachable` — mentioned but discouraged

### Shown in examples (student reads but doesn't write yet)
- `@memcpy(dest, src)` — copy memory between slices
- `allocator.dupe(T, source)` — duplicate a slice
- `allocator.realloc(slice, new_len)` — resize an allocation

### Also needed for Exercise 3.3
- `try` — for error propagation from alloc (Module 2)
- `defer allocator.free(...)` — for cleanup (Module 2)
- `for (slice, 0..) |item, i| { }` — for filling/filtering (Module 1)
- `@intCast(value)` — for usize/i32 conversions (Module 1)

---

## Lesson 3.4 — GeneralPurposeAllocator

### Introduced (student should produce)
- `var gpa = std.heap.GeneralPurposeAllocator(.{}){}` — create a GPA
- `defer { const check = gpa.deinit(); }` — cleanup with leak check
- `gpa.allocator()` — get the allocator interface from GPA
- `const check = gpa.deinit();` with `check == .leak` — leak detection
- `defer { ... }` — multi-statement defer block

### Shown in examples (student reads but doesn't write yet)
- GPA configuration options (e.g., `.{ .stack_trace_frames = 8 }`)
- `std.log` for reporting leaks

### Also needed for Exercise 3.4
- `const Name = struct { ... };` — struct definition (Module 2)
- `pub fn init(allocator: std.mem.Allocator) !Name` — constructor pattern
- `pub fn deinit(self: *Name) void` — destructor pattern
- `errdefer` — for partial initialization cleanup (Module 2)
- `self.field` — struct field access
- `try allocator.alloc(T, n)` — allocation (Lesson 3.3)
- `allocator.free(slice)` — deallocation (Lesson 3.3)

---

## Lesson 3.5 — ArenaAllocator

### Introduced (student should produce)
- `var arena = std.heap.ArenaAllocator.init(backing_allocator)` — create arena
- `defer arena.deinit();` — free all arena memory at once
- `const alloc = arena.allocator();` — get allocator interface from arena
- `arena.reset(.retain_capacity)` — reset arena for reuse (free all, keep buffer)

### Shown in examples (student reads but doesn't write yet)
- `arena.reset(.free_all)` — reset and release memory to backing allocator
- Arena wrapping another arena (nested arenas)

### Also needed for Exercise 3.5
- `try allocator.alloc(T, n)` — allocation (Lesson 3.3)
- `@intCast(value)` — for size conversions (Module 1)
- `defer arena.deinit();` — arena cleanup (this lesson)
- Two-allocator pattern: arena for scratch, backing for results

---

## Lesson 3.6 — FixedBufferAllocator

### Introduced (student should produce)
- `var buf: [N]u8 = undefined;` — stack buffer for FBA
- `var fba = std.heap.FixedBufferAllocator.init(&buf);` — create FBA from buffer
- `fba.allocator()` — get allocator interface from FBA
- `fba.reset()` — reset FBA to reuse buffer

### Shown in examples (student reads but doesn't write yet)
- Using FBA in embedded/no-heap contexts
- Combining FBA with arena

### Also needed for Exercise 3.6
- `try allocator.alloc(T, n)` — allocation (Lesson 3.3)
- Error handling for `error.OutOfMemory` (Module 2 error unions)
- `@memcpy(dest, src)` — shown in 3.3, used here
- `@intCast(value)` — for size conversions (Module 1)

---

## Lesson 3.7 — Memory Patterns for ML

### Introduced (student should produce)
- No new syntax — this lesson combines patterns from 3.3–3.6
- Weight persistence pattern: alloc in init, free in deinit
- Per-inference arena: create arena, do work, deinit arena
- Two-allocator pattern: scratch arena + result allocator

### Shown in examples (student reads but doesn't write yet)
- Memory budget calculation: `weights * @sizeOf(f32) + scratch_per_inference`
- Batch processing with arena reset

### Also needed for Exercise 3.7
- Struct with `init`/`deinit` methods (Lesson 3.4)
- `errdefer` for partial init cleanup (Module 2)
- Arena allocator creation and use (Lesson 3.5)
- `try allocator.alloc(f64, n)` — allocating float slices (Lesson 3.3)
- `@as(f64, @floatFromInt(i))` — int to float conversion (Module 1)
- `defer arena.deinit();` — arena cleanup (Lesson 3.5)

---

## Lesson 3.8 — Debugging Memory Issues

### Introduced (student should produce)
- `std.testing.allocator` — leak-detecting allocator for tests (formally explained)
- Reading GPA leak reports
- Debugging patterns: check defer/errdefer, verify ownership, trace allocations

### Shown in examples (student reads but doesn't write yet)
- Valgrind integration: `valgrind ./binary`
- Common memory bug patterns and their symptoms
- `std.debug.print` for tracing allocation/deallocation

### Also needed for Exercise 3.8
- `defer allocator.free(slice);` — for fixing leaks (Lesson 3.3)
- `errdefer allocator.free(slice);` — for fixing error-path leaks (Module 2)
- Arena + backing allocator pattern — for fixing use-after-free (Lesson 3.5)
- `try allocator.alloc(T, n)` — allocation (Lesson 3.3)
- `@memcpy(dest, src)` — memory copy (Lesson 3.3)

---

## NOT YET TAUGHT (common gaps to watch for)

These are commonly needed but **not introduced in Modules 1–3**. Do not ask the student to produce them without explanation:

| Syntax | First Appears | Notes |
|--------|--------------|-------|
| `ArrayList(T)` | Module 4 | Dynamic resizable arrays |
| `HashMap` | Module 4 | Key-value collections |
| Struct methods with `self: Self` (by value) | Module 4 | Methods that don't mutate |
| Generics with `fn(comptime T: type)` | Module 4 | Type-parameterized data structures |
| `@ptrCast` | Module 4+ | Casting between pointer types |
| `@alignCast` | Module 4+ | Alignment casting |
| `std.fs` file operations | Module 6 | File I/O |
| `std.Thread` | Module 11 | Multi-threading |
| `async` / `await` | Not in course | Zig's async is being redesigned |
