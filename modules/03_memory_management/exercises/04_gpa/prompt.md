# Exercise 3.4: GeneralPurposeAllocator

## Objective

Build a resource-owning struct (`DynBuffer`) with `init`/`deinit` methods, and practice `errdefer` for partial initialization cleanup.

## Requirements

1. Implement `DynBuffer` — a struct that owns a heap-allocated `[]u8` buffer
2. Implement `DynBuffer.init` — allocate the buffer, fill with zeros
3. Implement `DynBuffer.deinit` — free the buffer
4. Implement `DynBuffer.len` — return the buffer length
5. Implement `createAndCombine` — create two DynBuffers, return their combined length, ensuring both are cleaned up even if the second init fails

## Details

### `DynBuffer` struct
- Fields: `data: []u8`, `allocator: std.mem.Allocator`

### `DynBuffer.init(allocator, size) !DynBuffer`
- Allocate `size` bytes using the allocator
- Fill with zeros using `@memset`
- Return the initialized struct

### `DynBuffer.deinit(self: *DynBuffer) void`
- Free `self.data` using `self.allocator`

### `DynBuffer.len(self: DynBuffer) usize`
- Return the length of `self.data`

### `createAndCombine(allocator, size_a, size_b) !usize`
- Create a DynBuffer of `size_a`
- Create a DynBuffer of `size_b` (use `errdefer` to clean up the first if this fails)
- Return `first.len() + second.len()`
- Both buffers must be properly freed

## Syntax Reference

- `const Name = struct { ... };` — struct definition (Module 2)
- `pub fn init(allocator: std.mem.Allocator) !Name` — constructor pattern (Lesson 3.4)
- `pub fn deinit(self: *Name) void` — destructor pattern (Lesson 3.4)
- `try allocator.alloc(u8, size)` — allocate bytes (Lesson 3.3)
- `allocator.free(slice)` — free memory (Lesson 3.3)
- `@memset(slice, value)` — fill memory (Lesson 3.3)
- `errdefer` — cleanup on error (Module 2)
- `defer` — cleanup at scope exit (Module 2)

## Concepts Tested

- Resource-owning struct pattern (init/deinit)
- Storing allocator in struct for later free
- `errdefer` for partial initialization cleanup
- Combining init/deinit with business logic

## Verification

```bash
zig test tests.zig
```
