const std = @import("std");
const exercise = @import("starter.zig");

test "comptime_sum is correct" {
    // Sum of 0..10 = 0+1+2+3+4+5+6+7+8+9+10 = 55
    try std.testing.expectEqual(@as(i32, 55), exercise.comptime_sum);
}

test "max with i32" {
    try std.testing.expectEqual(@as(i32, 42), exercise.max(i32, 10, 42));
    try std.testing.expectEqual(@as(i32, 100), exercise.max(i32, 100, 50));
}

test "max with f64" {
    try std.testing.expectApproxEqAbs(@as(f64, 3.14), exercise.max(f64, 3.14, 2.71), 0.01);
}

test "createArray size" {
    const arr5 = exercise.createArray(5);
    try std.testing.expectEqual(@as(usize, 5), arr5.len);

    const arr10 = exercise.createArray(10);
    try std.testing.expectEqual(@as(usize, 10), arr10.len);
}

test "createArray values" {
    const arr = exercise.createArray(5);
    try std.testing.expectEqual(@as(i32, 0), arr[0]);
    try std.testing.expectEqual(@as(i32, 4), arr[4]);
}
