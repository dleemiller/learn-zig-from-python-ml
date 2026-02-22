const std = @import("std");

pub fn main() void {
    const MAX_SCORE = 100;

    var current_score: i32 = 0;

    current_score += 25;
    current_score += 25;
    current_score += 25;

    std.debug.print("Score: {d} / {d}\n", .{ current_score, MAX_SCORE });
}
