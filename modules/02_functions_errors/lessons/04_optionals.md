# Lesson 2.4: Optionals

## Learning Objectives

- [ ] Understand optional types (`?T`)
- [ ] Use `orelse` for default values
- [ ] Safely unwrap optionals with `if`
- [ ] Know when to use optionals vs error unions

## Prerequisites

- Completed Lesson 2.3
- Understand error unions

## The Problem

How do you represent "no value"?

Python uses `None`:
```python
def find_index(items, target):
    for i, item in enumerate(items):
        if item == target:
            return i
    return None  # Not found
```

But `None` can appear anywhere, causing the billion-dollar mistake: null pointer errors.

## Zig's Optional Type

`?T` means "either a T value, or null":

```zig
fn findIndex(haystack: []const i32, needle: i32) ?usize {
    for (haystack, 0..) |item, i| {
        if (item == needle) {
            return i;
        }
    }
    return null;
}
```

The `?` before the type makes it explicit: this function might not return a value.

## Using `orelse`

Provide a default value when null:

```zig
const index = findIndex(items, 42) orelse 0;
// If not found, use 0
```

`orelse` with a block:

```zig
const index = findIndex(items, 42) orelse {
    std.debug.print("Not found!\n", .{});
    return;
};
```

## Unwrapping with `if`

Safe unwrapping with `if`:

```zig
const maybe_index = findIndex(items, 42);

if (maybe_index) |index| {
    std.debug.print("Found at {d}\n", .{index});
} else {
    std.debug.print("Not found\n", .{});
}
```

The `|index|` captures the unwrapped value inside the if block.

## The `.?` Operator

For when you're certain a value exists:

```zig
const value: ?i32 = 42;
const x = value.?;  // Unwraps to 42
```

**Warning**: If the value is `null`, this causes a panic. Use only when you can prove the value exists.

## Optional Pointers

Pointers can be optional too:

```zig
fn findFirst(items: []const Item, predicate: fn (Item) bool) ?*const Item {
    for (items) |*item| {
        if (predicate(item.*)) {
            return item;
        }
    }
    return null;
}
```

## Chaining Optionals

When working with nested optionals:

```zig
const User = struct {
    name: []const u8,
    email: ?[]const u8,  // Email is optional
};

fn getEmailDomain(user: ?User) ?[]const u8 {
    const u = user orelse return null;
    const email = u.email orelse return null;
    // ... extract domain
}
```

## Optionals vs Error Unions

When to use which:

| Use Optional `?T` | Use Error Union `!T` |
|-------------------|---------------------|
| Value might not exist | Operation can fail |
| Absence is expected | Failure is exceptional |
| No reason needed | Error type is informative |
| "Not found" scenarios | I/O, parsing, validation |

Examples:
- `findIndex()` → `?usize` (not finding is normal)
- `parseInt()` → `!i32` (invalid input is an error)
- `getOptionalConfig()` → `?Config` (config might not be set)
- `readFile()` → `![]u8` (file errors need handling)

## Optional with Error Union

You can combine them: `!?T` (error union of an optional):

```zig
fn tryGetValue(key: []const u8) !?i32 {
    const file = try openConfig();  // Might error
    defer file.close();

    return findInFile(file, key);   // Might be null
}
```

## For Python Developers

| Python | Zig |
|--------|-----|
| `None` | `null` |
| `Optional[int]` (type hint) | `?i32` (enforced) |
| `x or default` | `x orelse default` |
| `if x is not None:` | `if (x) \|val\|` |
| `x if x else y` | `x orelse y` |

### The Key Difference

Python:
```python
def get_user(id):
    return user or None  # Can return None from anywhere

name = get_user(1).name  # Might crash!
```

Zig:
```zig
fn getUser(id: u32) ?User { ... }

const user = getUser(1) orelse return;  // Must handle null
const name = user.name;  // Safe - we handled null above
```

## Pattern: Optional Fields in Structs

```zig
const Config = struct {
    name: []const u8,
    port: u16 = 8080,          // Default value
    timeout: ?u32 = null,       // Optional, defaults to null

    fn getTimeout(self: Config) u32 {
        return self.timeout orelse 30;  // Default to 30 if not set
    }
};
```

## Common Mistakes

### Forgetting to Handle null

```zig
const x: ?i32 = null;
const y = x + 1;  // Error! Can't do arithmetic on optional
```

### Using `.?` Unsafely

```zig
const maybe: ?i32 = null;
const x = maybe.?;  // Panic! Should use orelse or if
```

### Nested Optionals

```zig
const x: ??i32 = null;  // Confusing - usually a design smell
```

## Self-Check

1. What does `?T` mean?
2. How is `orelse` different from `catch`?
3. When would you use `?T` instead of `!T`?
4. How do you safely access the value inside an optional?

## Exercises

Complete Exercise 2.4: Optionals
