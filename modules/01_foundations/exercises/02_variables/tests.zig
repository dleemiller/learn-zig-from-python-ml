const std = @import("std");
const testing = std.testing;

test "const and var declarations work" {
    const MAX_SCORE = 100;
    var current_score: i32 = 0;

    current_score += 25;
    current_score += 25;
    current_score += 25;

    try testing.expectEqual(@as(i32, 75), current_score);
    try testing.expectEqual(@as(i32, 100), MAX_SCORE);
}
