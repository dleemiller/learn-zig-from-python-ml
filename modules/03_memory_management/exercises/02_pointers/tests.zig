const std = @import("std");
const exercises = @import("starter.zig");

test "swap exchanges values" {
    var a: i32 = 10;
    var b: i32 = 20;
    exercises.swap(&a, &b);
    try std.testing.expectEqual(@as(i32, 20), a);
    try std.testing.expectEqual(@as(i32, 10), b);
}

test "swap with same value" {
    var a: i32 = 5;
    var b: i32 = 5;
    exercises.swap(&a, &b);
    try std.testing.expectEqual(@as(i32, 5), a);
    try std.testing.expectEqual(@as(i32, 5), b);
}

test "swap with negative values" {
    var a: i32 = -3;
    var b: i32 = 7;
    exercises.swap(&a, &b);
    try std.testing.expectEqual(@as(i32, 7), a);
    try std.testing.expectEqual(@as(i32, -3), b);
}

test "addToAll adds delta to each element" {
    var data = [_]i32{ 1, 2, 3, 4, 5 };
    exercises.addToAll(&data, 10);
    try std.testing.expectEqual(@as(i32, 11), data[0]);
    try std.testing.expectEqual(@as(i32, 12), data[1]);
    try std.testing.expectEqual(@as(i32, 13), data[2]);
    try std.testing.expectEqual(@as(i32, 14), data[3]);
    try std.testing.expectEqual(@as(i32, 15), data[4]);
}

test "addToAll with negative delta" {
    var data = [_]i32{ 10, 20, 30 };
    exercises.addToAll(&data, -5);
    try std.testing.expectEqual(@as(i32, 5), data[0]);
    try std.testing.expectEqual(@as(i32, 15), data[1]);
    try std.testing.expectEqual(@as(i32, 25), data[2]);
}

test "addToAll with zero delta" {
    var data = [_]i32{ 1, 2, 3 };
    exercises.addToAll(&data, 0);
    try std.testing.expectEqual(@as(i32, 1), data[0]);
    try std.testing.expectEqual(@as(i32, 2), data[1]);
    try std.testing.expectEqual(@as(i32, 3), data[2]);
}

test "maxElement returns pointer to largest" {
    var data = [_]i32{ 3, 7, 1, 9, 4 };
    const max_ptr = exercises.maxElement(&data);
    try std.testing.expectEqual(@as(i32, 9), max_ptr.*);
}

test "maxElement returns live pointer into original data" {
    var data = [_]i32{ 3, 7, 1, 9, 4 };
    const max_ptr = exercises.maxElement(&data);
    // Modify through the pointer
    max_ptr.* = 100;
    // The original array should be modified
    try std.testing.expectEqual(@as(i32, 100), data[3]);
}

test "maxElement with single element" {
    var data = [_]i32{42};
    const max_ptr = exercises.maxElement(&data);
    try std.testing.expectEqual(@as(i32, 42), max_ptr.*);
}

test "maxElement with first element being max" {
    var data = [_]i32{ 99, 1, 2, 3 };
    const max_ptr = exercises.maxElement(&data);
    try std.testing.expectEqual(@as(i32, 99), max_ptr.*);
}
