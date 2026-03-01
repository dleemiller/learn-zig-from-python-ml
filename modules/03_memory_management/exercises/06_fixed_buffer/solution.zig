const std = @import("std");

/// Allocate n i32 values from the provided buffer.
/// Fill with counting values: {0, 1, 2, ..., n-1}.
/// Returns error.OutOfMemory if buffer is too small.
pub fn countingArray(buffer: []u8, n: usize) ![]i32 {
    var fba = std.heap.FixedBufferAllocator.init(buffer);
    const allocator = fba.allocator();

    const data = try allocator.alloc(i32, n);
    for (data, 0..) |*v, i| {
        v.* = @intCast(i);
    }
    return data;
}

/// Concatenate two slices using only buffer-backed allocation.
/// Returns error.OutOfMemory if buffer is too small.
pub fn concatInBuffer(buffer: []u8, a: []const i32, b: []const i32) ![]i32 {
    var fba = std.heap.FixedBufferAllocator.init(buffer);
    const allocator = fba.allocator();

    const result = try allocator.alloc(i32, a.len + b.len);
    @memcpy(result[0..a.len], a);
    @memcpy(result[a.len..], b);
    return result;
}
