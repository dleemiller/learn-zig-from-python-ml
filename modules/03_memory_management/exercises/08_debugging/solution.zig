const std = @import("std");

/// Bug 1 FIXED: Added defer to free the temporary buffer.
pub fn leakyDouble(allocator: std.mem.Allocator, data: []const i32) ![]i32 {
    // Temporary buffer for intermediate work
    const temp = try allocator.alloc(i32, data.len);
    defer allocator.free(temp); // FIX: free temp when done

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

/// Bug 2 FIXED: Added errdefer to free result if temp allocation fails.
pub fn riskyConcat(allocator: std.mem.Allocator, a: []const i32, b: []const i32) ![]i32 {
    // Allocate space for the concatenated result
    const result = try allocator.alloc(i32, a.len + b.len);
    errdefer allocator.free(result); // FIX: free result on error

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

/// Bug 3 FIXED: Result is allocated from backing, not the arena.
pub fn processWithArena(backing: std.mem.Allocator, input: []const i32) ![]i32 {
    var arena = std.heap.ArenaAllocator.init(backing);
    defer arena.deinit();
    const scratch = arena.allocator();

    // Scratch work: double each value
    const temp = try scratch.alloc(i32, input.len);
    for (input, 0..) |val, i| {
        temp[i] = val * 2;
    }

    // FIX: allocate result from backing (survives arena.deinit)
    const result = try backing.alloc(i32, input.len);
    @memcpy(result, temp);

    return result;
}
