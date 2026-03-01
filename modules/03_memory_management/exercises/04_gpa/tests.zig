const std = @import("std");
const exercises = @import("starter.zig");

test "DynBuffer init creates buffer of correct size" {
    const allocator = std.testing.allocator;
    var buf = try exercises.DynBuffer.init(allocator, 100);
    defer buf.deinit();
    try std.testing.expectEqual(@as(usize, 100), buf.len());
}

test "DynBuffer init fills with zeros" {
    const allocator = std.testing.allocator;
    var buf = try exercises.DynBuffer.init(allocator, 10);
    defer buf.deinit();
    for (buf.data) |byte| {
        try std.testing.expectEqual(@as(u8, 0), byte);
    }
}

test "DynBuffer init with zero size" {
    const allocator = std.testing.allocator;
    var buf = try exercises.DynBuffer.init(allocator, 0);
    defer buf.deinit();
    try std.testing.expectEqual(@as(usize, 0), buf.len());
}

test "DynBuffer data is writable" {
    const allocator = std.testing.allocator;
    var buf = try exercises.DynBuffer.init(allocator, 5);
    defer buf.deinit();
    buf.data[0] = 42;
    buf.data[4] = 99;
    try std.testing.expectEqual(@as(u8, 42), buf.data[0]);
    try std.testing.expectEqual(@as(u8, 99), buf.data[4]);
}

test "createAndCombine returns combined length" {
    const allocator = std.testing.allocator;
    const combined = try exercises.createAndCombine(allocator, 100, 200);
    try std.testing.expectEqual(@as(usize, 300), combined);
}

test "createAndCombine with zero sizes" {
    const allocator = std.testing.allocator;
    const combined = try exercises.createAndCombine(allocator, 0, 0);
    try std.testing.expectEqual(@as(usize, 0), combined);
}

test "createAndCombine does not leak memory" {
    // std.testing.allocator will fail this test if there are any leaks
    const allocator = std.testing.allocator;
    const combined = try exercises.createAndCombine(allocator, 50, 75);
    try std.testing.expectEqual(@as(usize, 125), combined);
}
