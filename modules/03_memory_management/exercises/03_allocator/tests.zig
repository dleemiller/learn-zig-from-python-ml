const std = @import("std");
const exercises = @import("starter.zig");

test "createFilled returns slice of correct length" {
    const allocator = std.testing.allocator;
    const data = try exercises.createFilled(allocator, 5, 42);
    defer allocator.free(data);
    try std.testing.expectEqual(@as(usize, 5), data.len);
}

test "createFilled fills with given value" {
    const allocator = std.testing.allocator;
    const data = try exercises.createFilled(allocator, 3, 7);
    defer allocator.free(data);
    for (data) |v| {
        try std.testing.expectEqual(@as(i32, 7), v);
    }
}

test "createFilled with zero length" {
    const allocator = std.testing.allocator;
    const data = try exercises.createFilled(allocator, 0, 99);
    defer allocator.free(data);
    try std.testing.expectEqual(@as(usize, 0), data.len);
}

test "filterEvens returns only even numbers" {
    const allocator = std.testing.allocator;
    const input = [_]i32{ 1, 2, 3, 4, 5, 6 };
    const evens = try exercises.filterEvens(allocator, &input);
    defer allocator.free(evens);

    try std.testing.expectEqual(@as(usize, 3), evens.len);
    try std.testing.expectEqual(@as(i32, 2), evens[0]);
    try std.testing.expectEqual(@as(i32, 4), evens[1]);
    try std.testing.expectEqual(@as(i32, 6), evens[2]);
}

test "filterEvens with no even numbers" {
    const allocator = std.testing.allocator;
    const input = [_]i32{ 1, 3, 5, 7 };
    const evens = try exercises.filterEvens(allocator, &input);
    defer allocator.free(evens);
    try std.testing.expectEqual(@as(usize, 0), evens.len);
}

test "filterEvens with all even numbers" {
    const allocator = std.testing.allocator;
    const input = [_]i32{ 2, 4, 6 };
    const evens = try exercises.filterEvens(allocator, &input);
    defer allocator.free(evens);

    try std.testing.expectEqual(@as(usize, 3), evens.len);
    try std.testing.expectEqual(@as(i32, 2), evens[0]);
    try std.testing.expectEqual(@as(i32, 4), evens[1]);
    try std.testing.expectEqual(@as(i32, 6), evens[2]);
}

test "filterEvens with negative even numbers" {
    const allocator = std.testing.allocator;
    const input = [_]i32{ -4, -3, -2, -1, 0 };
    const evens = try exercises.filterEvens(allocator, &input);
    defer allocator.free(evens);

    try std.testing.expectEqual(@as(usize, 3), evens.len);
    try std.testing.expectEqual(@as(i32, -4), evens[0]);
    try std.testing.expectEqual(@as(i32, -2), evens[1]);
    try std.testing.expectEqual(@as(i32, 0), evens[2]);
}

test "concat combines two slices" {
    const allocator = std.testing.allocator;
    const a = [_]i32{ 1, 2, 3 };
    const b = [_]i32{ 4, 5 };
    const result = try exercises.concat(allocator, &a, &b);
    defer allocator.free(result);

    try std.testing.expectEqual(@as(usize, 5), result.len);
    try std.testing.expectEqual(@as(i32, 1), result[0]);
    try std.testing.expectEqual(@as(i32, 2), result[1]);
    try std.testing.expectEqual(@as(i32, 3), result[2]);
    try std.testing.expectEqual(@as(i32, 4), result[3]);
    try std.testing.expectEqual(@as(i32, 5), result[4]);
}

test "concat with empty first slice" {
    const allocator = std.testing.allocator;
    const a = [_]i32{};
    const b = [_]i32{ 7, 8, 9 };
    const result = try exercises.concat(allocator, &a, &b);
    defer allocator.free(result);

    try std.testing.expectEqual(@as(usize, 3), result.len);
    try std.testing.expectEqual(@as(i32, 7), result[0]);
}

test "concat with empty second slice" {
    const allocator = std.testing.allocator;
    const a = [_]i32{ 1, 2 };
    const b = [_]i32{};
    const result = try exercises.concat(allocator, &a, &b);
    defer allocator.free(result);

    try std.testing.expectEqual(@as(usize, 2), result.len);
    try std.testing.expectEqual(@as(i32, 1), result[0]);
    try std.testing.expectEqual(@as(i32, 2), result[1]);
}
