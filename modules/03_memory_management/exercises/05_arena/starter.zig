const std = @import("std");

/// Allocate multiple buffers (one per size in `sizes`) using an arena.
/// Fill each with 1s, sum all elements, return the total.
/// The arena handles all cleanup.
pub fn batchProcess(backing: std.mem.Allocator, sizes: []const usize) !u64 {
    // TODO: Create arena, allocate buffers, sum, return total
    _ = backing;
    _ = sizes;
    return 0;
}

/// Double each value in input. Use an arena for scratch work,
/// but allocate the result from the BACKING allocator.
/// Caller owns the returned memory.
pub fn doubleValues(backing: std.mem.Allocator, input: []const i32) ![]i32 {
    // TODO: Arena for scratch, backing for result
    _ = backing;
    _ = input;
    return error.OutOfMemory;
}
