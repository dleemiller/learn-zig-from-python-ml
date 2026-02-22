const std = @import("std");
const testing = std.testing;

test "if expression" {
    const pos = if (@as(i32, 5) > 0) "positive" else "other";
    const neg = if (@as(i32, -5) > 0) "positive" else if (@as(i32, -5) < 0) "negative" else "zero";
    const zero = if (@as(i32, 0) > 0) "positive" else if (@as(i32, 0) < 0) "negative" else "zero";

    try testing.expect(std.mem.eql(u8, pos, "positive"));
    try testing.expect(std.mem.eql(u8, neg, "negative"));
    try testing.expect(std.mem.eql(u8, zero, "zero"));
}

test "switch grading" {
    const grade_a: u8 = switch (@as(u8, 95)) {
        90...100 => 'A',
        80...89 => 'B',
        else => 'F',
    };
    const grade_b: u8 = switch (@as(u8, 85)) {
        90...100 => 'A',
        80...89 => 'B',
        else => 'F',
    };
    try testing.expectEqual(@as(u8, 'A'), grade_a);
    try testing.expectEqual(@as(u8, 'B'), grade_b);
}

test "even sum" {
    var sum: i32 = 0;
    for (1..11) |i| {
        if (i % 2 == 0) {
            sum += @intCast(i);
        }
    }
    try testing.expectEqual(@as(i32, 30), sum);
}
