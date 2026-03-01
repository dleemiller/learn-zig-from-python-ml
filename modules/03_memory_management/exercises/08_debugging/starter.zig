const std = @import("std");

/// Bug 1: This function leaks a temporary buffer.
/// Find the leak and fix it.
pub fn leakyDouble(allocator: std.mem.Allocator, data: []const i32) ![]i32 {
    // Temporary buffer for intermediate work
    const temp = try allocator.alloc(i32, data.len);
    // BUG: temp is never freed!

    @memcpy(temp, data);

    // Double each value in temp
    for (temp) |*v| {
        v.* *= 2;
    }

    // Allocate result and copy doubled values
    const result = try allocator.alloc(i32, data.len);
    @memcpy(result, temp);

    return result;
}

/// Bug 2: This function leaks on error paths.
/// Find the missing error cleanup and fix it.
pub fn riskyConcat(allocator: std.mem.Allocator, a: []const i32, b: []const i32) ![]i32 {
    // Allocate space for the concatenated result
    const result = try allocator.alloc(i32, a.len + b.len);
    // BUG: if the temp allocation below fails, result leaks!

    // Copy first slice
    @memcpy(result[0..a.len], a);

    // Allocate a temp buffer to process b before copying
    const temp = try allocator.alloc(i32, b.len);
    defer allocator.free(temp);

    // Process b (negate each value) then copy to result
    @memcpy(temp, b);
    for (temp) |*v| {
        v.* = -v.*;
    }
    @memcpy(result[a.len..], temp);

    return result;
}

/// Bug 3: This function returns data from the wrong allocator.
/// The result is allocated from the arena, which gets freed on return.
pub fn processWithArena(backing: std.mem.Allocator, input: []const i32) ![]i32 {
    var arena = std.heap.ArenaAllocator.init(backing);
    defer arena.deinit();
    const scratch = arena.allocator();

    // Scratch work: double each value
    const temp = try scratch.alloc(i32, input.len);
    for (input, 0..) |val, i| {
        temp[i] = val * 2;
    }

    // BUG: result is allocated from scratch (arena), not backing!
    // When arena.deinit() runs, result becomes invalid.
    const result = try scratch.alloc(i32, input.len);
    @memcpy(result, temp);

    return result;
}
