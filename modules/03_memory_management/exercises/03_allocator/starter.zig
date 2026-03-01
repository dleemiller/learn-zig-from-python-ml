const std = @import("std");

/// Allocate a slice of n items, fill each with value, return it.
/// Caller owns the returned memory.
pub fn createFilled(allocator: std.mem.Allocator, n: usize, value: i32) ![]i32 {
    // TODO: Allocate, fill, and return
    _ = allocator;
    _ = n;
    _ = value;
    return error.OutOfMemory;
}

/// Return a new slice containing only the even numbers from data.
/// Use the two-pass pattern: count first, then allocate exact size.
/// Caller owns the returned memory.
pub fn filterEvens(allocator: std.mem.Allocator, data: []const i32) ![]i32 {
    // TODO: Count evens, allocate, fill, return
    _ = allocator;
    _ = data;
    return error.OutOfMemory;
}

/// Concatenate two slices into a new allocated slice.
/// Caller owns the returned memory.
pub fn concat(allocator: std.mem.Allocator, a: []const i32, b: []const i32) ![]i32 {
    // TODO: Allocate a+b length, copy both, return
    _ = allocator;
    _ = a;
    _ = b;
    return error.OutOfMemory;
}
