const std = @import("std");
const exercise = @import("starter.zig");

// ── Part 1: max ──

test "max with i32" {
    try std.testing.expectEqual(@as(i32, 42), exercise.max(i32, 10, 42));
    try std.testing.expectEqual(@as(i32, 100), exercise.max(i32, 100, 50));
}

test "max with f64" {
    try std.testing.expectApproxEqAbs(@as(f64, 3.14), exercise.max(f64, 3.14, 2.71), 0.01);
}

test "max with equal values" {
    try std.testing.expectEqual(@as(i32, 7), exercise.max(i32, 7, 7));
}

// ── Part 2: Pair ──

test "Pair(i32) struct creation and field access" {
    const IntPair = exercise.Pair(i32);
    const p = IntPair{ .first = 1000, .second = -5 };
    try std.testing.expectEqual(@as(i32, 1000), p.first);
    try std.testing.expectEqual(@as(i32, -5), p.second);
}

test "Pair uses the type parameter" {
    const FloatPair = exercise.Pair(f64);
    const p = FloatPair{ .first = 3.14, .second = 2.71 };
    try std.testing.expectApproxEqAbs(@as(f64, 3.14), p.first, 0.001);
    try std.testing.expectApproxEqAbs(@as(f64, 2.71), p.second, 0.001);
}

// ── Part 3: isNumeric ──

test "isNumeric true for integer types" {
    try std.testing.expect(exercise.isNumeric(i32));
    try std.testing.expect(exercise.isNumeric(u8));
    try std.testing.expect(exercise.isNumeric(u64));
}

test "isNumeric true for float types" {
    try std.testing.expect(exercise.isNumeric(f32));
    try std.testing.expect(exercise.isNumeric(f64));
}

test "isNumeric false for non-numeric types" {
    try std.testing.expect(!exercise.isNumeric(bool));
    try std.testing.expect(!exercise.isNumeric([]const u8));
}

// ── Part 4: comptime_factorial ──

test "comptime_factorial equals 10!" {
    try std.testing.expectEqual(@as(u64, 3628800), exercise.comptime_factorial);
}
