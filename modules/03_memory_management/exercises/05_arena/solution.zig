const std = @import("std");

/// Allocate multiple buffers (one per size in `sizes`) using an arena.
/// Fill each with 1s, sum all elements, return the total.
/// The arena handles all cleanup.
pub fn batchProcess(backing: std.mem.Allocator, sizes: []const usize) !u64 {
    var arena = std.heap.ArenaAllocator.init(backing);
    defer arena.deinit();
    const alloc = arena.allocator();

    var total: u64 = 0;
    for (sizes) |size| {
        const buf = try alloc.alloc(i32, size);
        @memset(buf, 1);
        for (buf) |v| {
            total += @intCast(v);
        }
    }

    return total;
}

/// Double each value in input. Use an arena for scratch work,
/// but allocate the result from the BACKING allocator.
/// Caller owns the returned memory.
pub fn doubleValues(backing: std.mem.Allocator, input: []const i32) ![]i32 {
    var arena = std.heap.ArenaAllocator.init(backing);
    defer arena.deinit();
    const scratch = arena.allocator();

    // Scratch: temporary doubled values
    const temp = try scratch.alloc(i32, input.len);
    for (input, 0..) |val, i| {
        temp[i] = val * 2;
    }

    // Result: allocated from backing (survives arena.deinit)
    const result = try backing.alloc(i32, input.len);
    @memcpy(result, temp);

    return result;
}
