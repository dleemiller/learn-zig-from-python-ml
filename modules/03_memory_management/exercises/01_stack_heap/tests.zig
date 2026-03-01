const std = @import("std");
const exercises = @import("starter.zig");

test "stackLifetime returns 50" {
    try std.testing.expectEqual(@as(i32, 50), exercises.stackLifetime());
}

test "arrayOwnership returns modified array" {
    const arr = exercises.arrayOwnership();
    try std.testing.expectEqual(@as(i32, 99), arr[0]);
    try std.testing.expectEqual(@as(i32, 2), arr[1]);
    try std.testing.expectEqual(@as(i32, 3), arr[2]);
    try std.testing.expectEqual(@as(i32, 4), arr[3]);
    try std.testing.expectEqual(@as(i32, 5), arr[4]);
}

test "arrayOwnership demonstrates value semantics" {
    const arr1 = exercises.arrayOwnership();
    const arr2 = exercises.arrayOwnership();
    // Each call returns an independent copy
    try std.testing.expectEqual(arr1[0], arr2[0]);
}

test "sliceSum of multiple elements" {
    const data = [_]i32{ 10, 20, 30, 40 };
    try std.testing.expectEqual(@as(i32, 100), exercises.sliceSum(&data));
}

test "sliceSum of single element" {
    const data = [_]i32{42};
    try std.testing.expectEqual(@as(i32, 42), exercises.sliceSum(&data));
}

test "sliceSum of empty slice" {
    const data = [_]i32{};
    try std.testing.expectEqual(@as(i32, 0), exercises.sliceSum(&data));
}

test "sliceSum with negative numbers" {
    const data = [_]i32{ -5, 10, -3, 8 };
    try std.testing.expectEqual(@as(i32, 10), exercises.sliceSum(&data));
}
