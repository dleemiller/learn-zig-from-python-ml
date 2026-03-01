const std = @import("std");
const exercises = @import("starter.zig");

// --- Bug 1: leakyDouble tests ---

test "leakyDouble doubles each value" {
    const allocator = std.testing.allocator;
    const input = [_]i32{ 1, 2, 3, 4, 5 };
    const result = try exercises.leakyDouble(allocator, &input);
    defer allocator.free(result);

    try std.testing.expectEqual(@as(usize, 5), result.len);
    try std.testing.expectEqual(@as(i32, 2), result[0]);
    try std.testing.expectEqual(@as(i32, 4), result[1]);
    try std.testing.expectEqual(@as(i32, 6), result[2]);
    try std.testing.expectEqual(@as(i32, 8), result[3]);
    try std.testing.expectEqual(@as(i32, 10), result[4]);
}

test "leakyDouble does not leak temporary buffer" {
    // std.testing.allocator will fail if temp buffer is not freed
    const allocator = std.testing.allocator;
    const input = [_]i32{ 10, 20, 30 };
    const result = try exercises.leakyDouble(allocator, &input);
    defer allocator.free(result);
    try std.testing.expectEqual(@as(i32, 20), result[0]);
}

// --- Bug 2: riskyConcat tests ---

test "riskyConcat concatenates with negated second slice" {
    const allocator = std.testing.allocator;
    const a = [_]i32{ 1, 2 };
    const b = [_]i32{ 3, 4 };
    const result = try exercises.riskyConcat(allocator, &a, &b);
    defer allocator.free(result);

    try std.testing.expectEqual(@as(usize, 4), result.len);
    try std.testing.expectEqual(@as(i32, 1), result[0]);
    try std.testing.expectEqual(@as(i32, 2), result[1]);
    try std.testing.expectEqual(@as(i32, -3), result[2]);
    try std.testing.expectEqual(@as(i32, -4), result[3]);
}

test "riskyConcat does not leak on success" {
    // std.testing.allocator catches any leaks
    const allocator = std.testing.allocator;
    const a = [_]i32{5};
    const b = [_]i32{10};
    const result = try exercises.riskyConcat(allocator, &a, &b);
    defer allocator.free(result);
    try std.testing.expectEqual(@as(i32, 5), result[0]);
    try std.testing.expectEqual(@as(i32, -10), result[1]);
}

// --- Bug 3: processWithArena tests ---

test "processWithArena doubles each value" {
    const allocator = std.testing.allocator;
    const input = [_]i32{ 5, 10, 15 };
    const result = try exercises.processWithArena(allocator, &input);
    defer allocator.free(result);

    try std.testing.expectEqual(@as(usize, 3), result.len);
    try std.testing.expectEqual(@as(i32, 10), result[0]);
    try std.testing.expectEqual(@as(i32, 20), result[1]);
    try std.testing.expectEqual(@as(i32, 30), result[2]);
}

test "processWithArena result survives arena cleanup" {
    // If result was from arena, it would be freed already
    const allocator = std.testing.allocator;
    const input = [_]i32{ 1, 2, 3 };
    const result = try exercises.processWithArena(allocator, &input);
    defer allocator.free(result);

    // Access values — would be garbage if from freed arena
    try std.testing.expectEqual(@as(i32, 2), result[0]);
    try std.testing.expectEqual(@as(i32, 4), result[1]);
    try std.testing.expectEqual(@as(i32, 6), result[2]);
}

test "processWithArena with empty input" {
    const allocator = std.testing.allocator;
    const input = [_]i32{};
    const result = try exercises.processWithArena(allocator, &input);
    defer allocator.free(result);
    try std.testing.expectEqual(@as(usize, 0), result.len);
}
