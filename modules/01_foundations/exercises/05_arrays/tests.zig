const std = @import("std");
const testing = std.testing;

test "array creation" {
    const arr = [_]i32{ 1, 2, 3, 4, 5 };
    try testing.expectEqual(@as(usize, 5), arr.len);
    try testing.expectEqual(@as(i32, 3), arr[2]);
}

test "slice sum" {
    const arr = [_]i32{ 1, 2, 3, 4, 5 };
    var sum: i32 = 0;
    for (arr) |val| {
        sum += val;
    }
    try testing.expectEqual(@as(i32, 15), sum);
}

test "middle slice" {
    const arr = [_]i32{ 1, 2, 3, 4, 5 };
    const middle = arr[1..4];
    try testing.expectEqual(@as(usize, 3), middle.len);
    try testing.expectEqual(@as(i32, 2), middle[0]);
    try testing.expectEqual(@as(i32, 4), middle[2]);
}

test "mutable slice modification" {
    var arr = [_]i32{ 1, 2, 3, 4, 5 };
    for (&arr) |*ptr| {
        ptr.* *= 2;
    }
    const expected = [_]i32{ 2, 4, 6, 8, 10 };
    try testing.expectEqualSlices(i32, &expected, &arr);
}
