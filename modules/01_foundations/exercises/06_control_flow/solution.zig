const std = @import("std");

pub fn main() void {
    // Part 1: If expression
    const num: i32 = 5;
    const description: []const u8 = if (num > 0) "positive" else if (num < 0) "negative" else "zero";

    std.debug.print("{d} is {s}\n", .{ num, description });

    // Part 2: Switch statement
    const score: u8 = 85;
    const grade: u8 = switch (score) {
        90...100 => 'A',
        80...89 => 'B',
        70...79 => 'C',
        60...69 => 'D',
        else => 'F',
    };

    std.debug.print("Grade for {d}: {c}\n", .{ score, grade });

    // Part 3: For loop with range
    std.debug.print("Numbers 1-5: ", .{});
    for (1..6) |i| {
        std.debug.print("{d} ", .{i});
    }
    std.debug.print("\n", .{});

    // Part 4: While loop countdown
    std.debug.print("Countdown: ", .{});
    var countdown: i32 = 5;
    while (countdown > 0) : (countdown -= 1) {
        std.debug.print("{d} ", .{countdown});
    }
    std.debug.print("\n", .{});

    // Part 5: Sum of even numbers
    var even_sum: i32 = 0;
    for (1..11) |i| {
        if (i % 2 == 0) {
            even_sum += @intCast(i);
        }
    }
    std.debug.print("Sum of evens 1-10: {d}\n", .{even_sum});
}
