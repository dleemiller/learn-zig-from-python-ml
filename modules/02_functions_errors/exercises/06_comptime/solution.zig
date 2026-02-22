const std = @import("std");

pub const comptime_sum = blk: {
    var sum: i32 = 0;
    for (0..11) |i| {
        sum += @as(i32, @intCast(i));
    }
    break :blk sum;
};

pub fn max(comptime T: type, a: T, b: T) T {
    return if (a > b) a else b;
}

pub fn createArray(comptime size: usize) [size]i32 {
    var arr: [size]i32 = undefined;
    for (0..size) |i| {
        arr[i] = @intCast(i);
    }
    return arr;
}

pub fn main() void {
    std.debug.print("Comptime sum: {d}\n", .{comptime_sum});

    std.debug.print("Max i32: {d}\n", .{max(i32, 10, 42)});
    std.debug.print("Max f64: {d}\n", .{max(f64, 3.14, 2.71)});

    const arr = createArray(10);
    std.debug.print("Array size: {d}\n", .{arr.len});
}
