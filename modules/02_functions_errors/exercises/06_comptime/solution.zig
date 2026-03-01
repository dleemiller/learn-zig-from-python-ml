const std = @import("std");

// ── Part 1: Generic max ──────────────────────────────────────────────
// A generic function that works with any comparable type.
pub fn max(comptime T: type, a: T, b: T) T {
    return if (a > b) a else b;
}

// ── Part 2: Pair type constructor ────────────────────────────────────
// A function that returns a type: a struct holding two values of type T.
pub fn Pair(comptime T: type) type {
    return struct {
        first: T,
        second: T,
    };
}

// ── Part 3: Type introspection ───────────────────────────────────────
// Uses @typeInfo to check whether T is a numeric type (integer or float).
pub fn isNumeric(comptime T: type) bool {
    return switch (@typeInfo(T)) {
        .int, .float => true,
        else => false,
    };
}

// ── Part 4: Comptime factorial ───────────────────────────────────────
// 10! computed entirely at compile time using a labeled block.
pub const comptime_factorial = blk: {
    var result: u64 = 1;
    for (1..11) |i| {
        result *= @intCast(i);
    }
    break :blk result;
};
