const std = @import("std");
const exercises = @import("starter.zig");

test "countingArray returns counting values" {
    var buffer: [256]u8 = undefined;
    const data = try exercises.countingArray(&buffer, 5);
    try std.testing.expectEqual(@as(usize, 5), data.len);
    try std.testing.expectEqual(@as(i32, 0), data[0]);
    try std.testing.expectEqual(@as(i32, 1), data[1]);
    try std.testing.expectEqual(@as(i32, 2), data[2]);
    try std.testing.expectEqual(@as(i32, 3), data[3]);
    try std.testing.expectEqual(@as(i32, 4), data[4]);
}

test "countingArray with single element" {
    var buffer: [64]u8 = undefined;
    const data = try exercises.countingArray(&buffer, 1);
    try std.testing.expectEqual(@as(usize, 1), data.len);
    try std.testing.expectEqual(@as(i32, 0), data[0]);
}

test "countingArray with zero elements" {
    var buffer: [64]u8 = undefined;
    const data = try exercises.countingArray(&buffer, 0);
    try std.testing.expectEqual(@as(usize, 0), data.len);
}

test "countingArray returns OutOfMemory when buffer too small" {
    // 3 i32s need 12 bytes; 8-byte buffer is too small
    var buffer: [8]u8 = undefined;
    const result = exercises.countingArray(&buffer, 3);
    try std.testing.expectError(error.OutOfMemory, result);
}

test "concatInBuffer combines two slices" {
    var buffer: [256]u8 = undefined;
    const a = [_]i32{ 1, 2, 3 };
    const b = [_]i32{ 4, 5 };
    const result = try exercises.concatInBuffer(&buffer, &a, &b);

    try std.testing.expectEqual(@as(usize, 5), result.len);
    try std.testing.expectEqual(@as(i32, 1), result[0]);
    try std.testing.expectEqual(@as(i32, 2), result[1]);
    try std.testing.expectEqual(@as(i32, 3), result[2]);
    try std.testing.expectEqual(@as(i32, 4), result[3]);
    try std.testing.expectEqual(@as(i32, 5), result[4]);
}

test "concatInBuffer with empty first slice" {
    var buffer: [256]u8 = undefined;
    const a = [_]i32{};
    const b = [_]i32{ 7, 8, 9 };
    const result = try exercises.concatInBuffer(&buffer, &a, &b);

    try std.testing.expectEqual(@as(usize, 3), result.len);
    try std.testing.expectEqual(@as(i32, 7), result[0]);
}

test "concatInBuffer with empty second slice" {
    var buffer: [256]u8 = undefined;
    const a = [_]i32{ 1, 2 };
    const b = [_]i32{};
    const result = try exercises.concatInBuffer(&buffer, &a, &b);

    try std.testing.expectEqual(@as(usize, 2), result.len);
    try std.testing.expectEqual(@as(i32, 1), result[0]);
    try std.testing.expectEqual(@as(i32, 2), result[1]);
}

test "concatInBuffer returns OutOfMemory when buffer too small" {
    // 5 i32s need 20 bytes; 12-byte buffer is too small
    var buffer: [12]u8 = undefined;
    const a = [_]i32{ 1, 2, 3 };
    const b = [_]i32{ 4, 5 };
    const result = exercises.concatInBuffer(&buffer, &a, &b);
    try std.testing.expectError(error.OutOfMemory, result);
}
