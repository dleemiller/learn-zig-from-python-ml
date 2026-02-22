const std = @import("std");
const exercise = @import("starter.zig");

fn isEven(x: i32) bool {
    return @rem(x, 2) == 0;
}

fn isNegative(x: i32) bool {
    return x < 0;
}

test "findFirst found" {
    const nums = [_]i32{ 1, 3, 2, 5, 4 };
    const result = exercise.findFirst(&nums, isEven);
    try std.testing.expectEqual(@as(?i32, 2), result);
}

test "findFirst not found" {
    const nums = [_]i32{ 1, 3, 5, 7 };
    const result = exercise.findFirst(&nums, isEven);
    try std.testing.expectEqual(@as(?i32, null), result);
}

test "getWithDefault with value" {
    try std.testing.expectEqual(@as(i32, 42), exercise.getWithDefault(42, 0));
}

test "getWithDefault with null" {
    try std.testing.expectEqual(@as(i32, 99), exercise.getWithDefault(null, 99));
}

test "doubleOrZero with value" {
    try std.testing.expectEqual(@as(i32, 84), exercise.doubleOrZero(42));
}

test "doubleOrZero with null" {
    try std.testing.expectEqual(@as(i32, 0), exercise.doubleOrZero(null));
}
