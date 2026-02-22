const std = @import("std");

pub fn main() void {
    // Part 1: If expression
    const num: i32 = 5;
    // TODO: Use if as an expression to set description
    // Should be "positive", "negative", or "zero"
    const description: []const u8 = "unknown"; // Fix this

    std.debug.print("{d} is {s}\n", .{ num, description });

    // Part 2: Switch statement
    const score: u8 = 85;
    // TODO: Use switch to determine grade
    // 90-100: A, 80-89: B, 70-79: C, 60-69: D, else: F
    // Hint: Range syntax is X...Y
    const grade: u8 = '?'; // Fix this

    std.debug.print("Grade for {d}: {c}\n", .{ score, grade });

    // Part 3: For loop with range
    std.debug.print("Numbers 1-5: ", .{});
    // TODO: Print numbers 1 through 5 using a for loop

    std.debug.print("\n", .{});

    // Part 4: While loop countdown
    std.debug.print("Countdown: ", .{});
    // TODO: Count down from 5 to 1 using a while loop

    std.debug.print("\n", .{});

    // Part 5: Sum of even numbers
    // TODO: Calculate the sum of even numbers from 1 to 10
    var even_sum: i32 = 0;

    std.debug.print("Sum of evens 1-10: {d}\n", .{even_sum});
}
