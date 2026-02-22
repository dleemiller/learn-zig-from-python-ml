const std = @import("std");
const exercise = @import("starter.zig");

test "circle area" {
    const circle = exercise.Shape{ .circle = 5.0 };
    const area = exercise.calculateArea(circle);
    try std.testing.expectApproxEqAbs(@as(f64, 78.54), area, 0.01);
}

test "rectangle area" {
    const rect = exercise.Shape{ .rectangle = .{ .w = 4.0, .h = 6.0 } };
    const area = exercise.calculateArea(rect);
    try std.testing.expectApproxEqAbs(@as(f64, 24.0), area, 0.01);
}

test "triangle area" {
    const tri = exercise.Shape{ .triangle = .{ .base = 3.0, .height = 4.0 } };
    const area = exercise.calculateArea(tri);
    try std.testing.expectApproxEqAbs(@as(f64, 6.0), area, 0.01);
}
