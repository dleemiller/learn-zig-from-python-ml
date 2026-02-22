const std = @import("std");

pub fn main() void {
    var arr = [_]i32{ 1, 2, 3, 4, 5 };

    std.debug.print("Array: {{ ", .{});
    for (arr) |val| {
        std.debug.print("{d}, ", .{val});
    }
    std.debug.print("}}\n", .{});

    var sum: i32 = 0;
    for (arr) |val| {
        sum += val;
    }
    std.debug.print("Full slice sum: {d}\n", .{sum});

    const middle: []const i32 = arr[1..4];

    std.debug.print("Middle slice [1..4]: {{ ", .{});
    for (middle) |val| {
        std.debug.print("{d}, ", .{val});
    }
    std.debug.print("}}\n", .{});

    var middle_sum: i32 = 0;
    for (middle) |val| {
        middle_sum += val;
    }
    std.debug.print("Middle sum: {d}\n", .{middle_sum});

    for (&arr) |*ptr| {
        ptr.* *= 2;
    }

    std.debug.print("After doubling: {{ ", .{});
    for (arr) |val| {
        std.debug.print("{d}, ", .{val});
    }
    std.debug.print("}}\n", .{});
}
