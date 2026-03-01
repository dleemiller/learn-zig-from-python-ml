const std = @import("std");
const exercises = @import("starter.zig");

test "batchProcess sums all elements" {
    const allocator = std.testing.allocator;
    const sizes = [_]usize{ 3, 5, 2 };
    const total = try exercises.batchProcess(allocator, &sizes);
    // 3 ones + 5 ones + 2 ones = 10
    try std.testing.expectEqual(@as(u64, 10), total);
}

test "batchProcess with single size" {
    const allocator = std.testing.allocator;
    const sizes = [_]usize{7};
    const total = try exercises.batchProcess(allocator, &sizes);
    try std.testing.expectEqual(@as(u64, 7), total);
}

test "batchProcess with empty sizes" {
    const allocator = std.testing.allocator;
    const sizes = [_]usize{};
    const total = try exercises.batchProcess(allocator, &sizes);
    try std.testing.expectEqual(@as(u64, 0), total);
}

test "batchProcess with zero-size entries" {
    const allocator = std.testing.allocator;
    const sizes = [_]usize{ 0, 5, 0 };
    const total = try exercises.batchProcess(allocator, &sizes);
    try std.testing.expectEqual(@as(u64, 5), total);
}

test "doubleValues doubles each element" {
    const allocator = std.testing.allocator;
    const input = [_]i32{ 1, 2, 3, 4, 5 };
    const result = try exercises.doubleValues(allocator, &input);
    defer allocator.free(result);

    try std.testing.expectEqual(@as(usize, 5), result.len);
    try std.testing.expectEqual(@as(i32, 2), result[0]);
    try std.testing.expectEqual(@as(i32, 4), result[1]);
    try std.testing.expectEqual(@as(i32, 6), result[2]);
    try std.testing.expectEqual(@as(i32, 8), result[3]);
    try std.testing.expectEqual(@as(i32, 10), result[4]);
}

test "doubleValues with negative numbers" {
    const allocator = std.testing.allocator;
    const input = [_]i32{ -3, 0, 5 };
    const result = try exercises.doubleValues(allocator, &input);
    defer allocator.free(result);

    try std.testing.expectEqual(@as(i32, -6), result[0]);
    try std.testing.expectEqual(@as(i32, 0), result[1]);
    try std.testing.expectEqual(@as(i32, 10), result[2]);
}

test "doubleValues with empty input" {
    const allocator = std.testing.allocator;
    const input = [_]i32{};
    const result = try exercises.doubleValues(allocator, &input);
    defer allocator.free(result);
    try std.testing.expectEqual(@as(usize, 0), result.len);
}

test "doubleValues result is independent of arena" {
    // This test ensures the result is allocated from backing, not arena.
    // std.testing.allocator will detect leaks if cleanup is wrong.
    const allocator = std.testing.allocator;
    const input = [_]i32{ 10, 20 };
    const result = try exercises.doubleValues(allocator, &input);
    defer allocator.free(result);

    // If result came from the arena, it would be freed already (garbage data)
    try std.testing.expectEqual(@as(i32, 20), result[0]);
    try std.testing.expectEqual(@as(i32, 40), result[1]);
}
