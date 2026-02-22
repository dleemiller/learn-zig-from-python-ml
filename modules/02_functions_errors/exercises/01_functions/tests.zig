const std = @import("std");
const exercise = @import("starter.zig");

test "multiply basic" {
    try std.testing.expectEqual(@as(i32, 15), exercise.multiply(5, 3));
    try std.testing.expectEqual(@as(i32, 0), exercise.multiply(0, 100));
    try std.testing.expectEqual(@as(i32, -12), exercise.multiply(-3, 4));
}

test "isPositive" {
    try std.testing.expect(exercise.isPositive(5));
    try std.testing.expect(exercise.isPositive(1));
    try std.testing.expect(!exercise.isPositive(0));
    try std.testing.expect(!exercise.isPositive(-5));
}

test "average" {
    const vals1 = [_]f64{ 1.0, 2.0, 3.0, 4.0, 5.0 };
    try std.testing.expectApproxEqAbs(@as(f64, 3.0), exercise.average(&vals1), 0.001);

    const vals2 = [_]f64{ 10.0, 20.0 };
    try std.testing.expectApproxEqAbs(@as(f64, 15.0), exercise.average(&vals2), 0.001);
}

test "divmod" {
    const r1 = exercise.divmod(17, 5);
    try std.testing.expectEqual(@as(i32, 3), r1.quotient);
    try std.testing.expectEqual(@as(i32, 2), r1.remainder);

    const r2 = exercise.divmod(10, 2);
    try std.testing.expectEqual(@as(i32, 5), r2.quotient);
    try std.testing.expectEqual(@as(i32, 0), r2.remainder);
}
