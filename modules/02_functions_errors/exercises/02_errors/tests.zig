const std = @import("std");
const exercise = @import("starter.zig");

test "safeDivide success" {
    const result = try exercise.safeDivide(10, 2);
    try std.testing.expectEqual(@as(i32, 5), result);
}

test "safeDivide by zero" {
    const result = exercise.safeDivide(10, 0);
    try std.testing.expectError(error.DivisionByZero, result);
}

test "parseDigit valid" {
    try std.testing.expectEqual(@as(u8, 0), try exercise.parseDigit('0'));
    try std.testing.expectEqual(@as(u8, 5), try exercise.parseDigit('5'));
    try std.testing.expectEqual(@as(u8, 9), try exercise.parseDigit('9'));
}

test "parseDigit invalid" {
    try std.testing.expectError(error.InvalidDigit, exercise.parseDigit('a'));
    try std.testing.expectError(error.InvalidDigit, exercise.parseDigit('x'));
    try std.testing.expectError(error.InvalidDigit, exercise.parseDigit(' '));
}

test "processValue success" {
    const result = try exercise.processValue('4', 1);
    try std.testing.expectEqual(@as(i32, 14), result);

    const result2 = try exercise.processValue('0', 2);
    try std.testing.expectEqual(@as(i32, 5), result2);
}

test "processValue propagates errors" {
    try std.testing.expectError(error.InvalidDigit, exercise.processValue('x', 1));
    try std.testing.expectError(error.DivisionByZero, exercise.processValue('5', 0));
}
