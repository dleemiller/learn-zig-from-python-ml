const std = @import("std");

/// Allocate a slice of n items, fill each with value, return it.
/// Caller owns the returned memory.
pub fn createFilled(allocator: std.mem.Allocator, n: usize, value: i32) ![]i32 {
    const data = try allocator.alloc(i32, n);
    @memset(data, value);
    return data;
}

/// Return a new slice containing only the even numbers from data.
/// Use the two-pass pattern: count first, then allocate exact size.
/// Caller owns the returned memory.
pub fn filterEvens(allocator: std.mem.Allocator, data: []const i32) ![]i32 {
    // Pass 1: count evens
    var count: usize = 0;
    for (data) |v| {
        if (@rem(v, 2) == 0) count += 1;
    }

    // Pass 2: allocate and fill
    const result = try allocator.alloc(i32, count);
    errdefer allocator.free(result);

    var i: usize = 0;
    for (data) |v| {
        if (@rem(v, 2) == 0) {
            result[i] = v;
            i += 1;
        }
    }

    return result;
}

/// Concatenate two slices into a new allocated slice.
/// Caller owns the returned memory.
pub fn concat(allocator: std.mem.Allocator, a: []const i32, b: []const i32) ![]i32 {
    const result = try allocator.alloc(i32, a.len + b.len);
    @memcpy(result[0..a.len], a);
    @memcpy(result[a.len..], b);
    return result;
}
