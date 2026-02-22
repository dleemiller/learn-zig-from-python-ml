# Lesson 2.3: Error Handling Patterns

## Learning Objectives

- [ ] Use `defer` for cleanup at scope exit
- [ ] Use `errdefer` for cleanup only on error
- [ ] Apply these patterns to resource management

## Prerequisites

- Completed Lesson 2.2
- Understand error unions and try/catch

## The Cleanup Problem

When working with resources (files, memory, connections), you need to clean up:

```python
# Python context manager
with open("file.txt") as f:
    data = f.read()
# File automatically closed
```

Zig uses `defer` instead.

## Basic `defer`

`defer` schedules code to run when the current scope exits:

```zig
pub fn main() void {
    std.debug.print("1: Start\n", .{});
    defer std.debug.print("3: Cleanup\n", .{});
    std.debug.print("2: Middle\n", .{});
}
// Output:
// 1: Start
// 2: Middle
// 3: Cleanup
```

The deferred code runs **after** the scope completes, but **before** returning.

## Multiple Defers (LIFO Order)

Multiple defers run in reverse order (last in, first out):

```zig
pub fn main() void {
    defer std.debug.print("1\n", .{});
    defer std.debug.print("2\n", .{});
    defer std.debug.print("3\n", .{});
}
// Output:
// 3
// 2
// 1
```

Think of it like a stack.

## Defer with Resources

Common pattern for file handling:

```zig
fn readFile(path: []const u8) ![]u8 {
    const file = try std.fs.cwd().openFile(path, .{});
    defer file.close();  // Will close even if error below

    const contents = try file.readToEndAlloc(allocator, max_size);
    return contents;
}
```

The file closes regardless of how the function exits.

## `errdefer` - Cleanup Only On Error

`errdefer` runs only when the scope exits due to an error:

```zig
fn allocateAndInit(allocator: std.mem.Allocator) !*Data {
    const data = try allocator.create(Data);
    errdefer allocator.destroy(data);  // Only runs if init fails

    try data.init();  // If this fails, data is freed
    return data;      // If success, caller owns data
}
```

Without `errdefer`, you'd leak memory when `init()` fails.

## Pattern: Resource Acquisition

```zig
fn process() !Result {
    // Acquire resources
    const file = try openFile();
    defer file.close();

    const buffer = try allocate(1024);
    defer free(buffer);

    // Use resources - cleanup happens automatically
    return try doWork(file, buffer);
}
```

## Pattern: Partial Initialization

```zig
const Connection = struct {
    socket: Socket,
    buffer: []u8,

    fn init(allocator: Allocator) !Connection {
        const socket = try Socket.connect();
        errdefer socket.close();  // Close if buffer alloc fails

        const buffer = try allocator.alloc(u8, 4096);
        errdefer allocator.free(buffer);  // Free if later init fails

        return Connection{
            .socket = socket,
            .buffer = buffer,
        };
    }
};
```

## Defer in Loops

Defer applies to the **current block**, not the function:

```zig
fn processFiles(paths: []const []const u8) !void {
    for (paths) |path| {
        const file = try std.fs.cwd().openFile(path, .{});
        defer file.close();  // Closes at end of each iteration

        try processFile(file);
    }
}
```

## Defer with Captures

If you need to capture a value:

```zig
var resource = try acquire();
defer release(resource);  // Captures current value of resource
```

Be careful - `defer` captures values at declaration time.

## For Python Developers

| Python | Zig |
|--------|-----|
| `with` statement | `defer` |
| `__enter__` / `__exit__` | Just use defer |
| `finally` block | `defer` (always runs) |
| Exception cleanup | `errdefer` (only on error) |

### The Mental Model

Python:
```python
try:
    f = open("file.txt")
    data = f.read()
finally:
    f.close()
```

Zig:
```zig
const f = try openFile("file.txt");
defer f.close();
const data = try f.read();
```

## Common Mistakes

### Defer After Return

```zig
fn bad() !void {
    return;
    defer cleanup();  // Never runs - code is unreachable!
}
```

### Forgetting errdefer for Partial Init

```zig
fn leaky() !*Thing {
    const a = try alloc();
    // If next line fails, a is leaked!
    const b = try init(a);
    return b;
}

// Fixed:
fn correct() !*Thing {
    const a = try alloc();
    errdefer free(a);  // Clean up a if init fails
    const b = try init(a);
    return b;
}
```

## Real-World Example: File Processing

```zig
fn processDataFile(path: []const u8, allocator: Allocator) !ProcessedData {
    // Open file
    const file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    // Read contents
    const contents = try file.readToEndAlloc(allocator, 10 * 1024 * 1024);
    defer allocator.free(contents);

    // Parse (might fail)
    const parsed = try parse(contents, allocator);
    errdefer parsed.deinit(allocator);  // Clean up if processing fails

    // Process
    const result = try process(parsed, allocator);

    return result;
}
```

## Self-Check

1. When does `defer` execute?
2. In what order do multiple `defer`s run?
3. When would you use `errdefer` instead of `defer`?
4. What happens if you put `defer` after a `return`?

## Exercises

Complete Exercise 2.3: Defer
