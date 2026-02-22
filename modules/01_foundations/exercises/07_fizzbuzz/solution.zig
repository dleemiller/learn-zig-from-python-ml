const std = @import("std");

pub fn main() void {
    for (1..21) |i| {
        if (i % 15 == 0) {
            std.debug.print("FizzBuzz\n", .{});
        } else if (i % 3 == 0) {
            std.debug.print("Fizz\n", .{});
        } else if (i % 5 == 0) {
            std.debug.print("Buzz\n", .{});
        } else {
            std.debug.print("{d}\n", .{i});
        }
    }
}
