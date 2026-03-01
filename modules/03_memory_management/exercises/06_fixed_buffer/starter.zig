const std = @import("std");

/// Allocate n i32 values from the provided buffer.
/// Fill with counting values: {0, 1, 2, ..., n-1}.
/// Returns error.OutOfMemory if buffer is too small.
pub fn countingArray(buffer: []u8, n: usize) ![]i32 {
    // TODO: Create FBA from buffer, allocate, fill with 0..n-1
    _ = buffer;
    _ = n;
    return error.OutOfMemory;
}

/// Concatenate two slices using only buffer-backed allocation.
/// Returns error.OutOfMemory if buffer is too small.
pub fn concatInBuffer(buffer: []u8, a: []const i32, b: []const i32) ![]i32 {
    // TODO: Create FBA from buffer, allocate, copy a then b
    _ = buffer;
    _ = a;
    _ = b;
    return error.OutOfMemory;
}
