const std = @import("std");

pub fn main() void {
    // Create an array containing the integers 1 through 5
    var arr = [_]i32{ 0, 0, 0, 0, 0 }; // Fix this

    // Print the array
    std.debug.print("Array: {{ ", .{});
    for (arr) |val| {
        std.debug.print("{d}, ", .{val});
    }
    std.debug.print("}}\n", .{});

    // Calculate sum of all elements
    var sum: i32 = 0;
    // Your code here

    std.debug.print("Full slice sum: {d}\n", .{sum});

    // Create a slice of elements at indices 1, 2, 3 (values 2, 3, 4)
    const middle: []const i32 = arr[0..1]; // Fix this

    std.debug.print("Middle slice: {{ ", .{});
    for (middle) |val| {
        std.debug.print("{d}, ", .{val});
    }
    std.debug.print("}}\n", .{});

    // Calculate sum of middle slice
    var middle_sum: i32 = 0;
    // Your code here

    std.debug.print("Middle sum: {d}\n", .{middle_sum});

    // Double each element in the array
    // Your code here

    std.debug.print("After doubling: {{ ", .{});
    for (arr) |val| {
        std.debug.print("{d}, ", .{val});
    }
    std.debug.print("}}\n", .{});
}
