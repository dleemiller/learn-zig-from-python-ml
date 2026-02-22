const std = @import("std");

pub fn multiply(a: i32, b: i32) i32 {
    return a * b;
}

pub fn isPositive(x: i32) bool {
    return x > 0;
}

pub fn average(values: []const f64) f64 {
    var sum: f64 = 0.0;
    for (values) |v| {
        sum += v;
    }
    return sum / @as(f64, @floatFromInt(values.len));
}

pub const DivResult = struct {
    quotient: i32,
    remainder: i32,
};

pub fn divmod(a: i32, b: i32) DivResult {
    return .{
        .quotient = @divTrunc(a, b),
        .remainder = @rem(a, b),
    };
}

pub fn main() void {
    std.debug.print("{d} * {d} = {d}\n", .{ 5, 3, multiply(5, 3) });
    std.debug.print("{d} is positive: {}\n", .{ 5, isPositive(5) });
    std.debug.print("{d} is positive: {}\n", .{ -3, isPositive(-3) });

    const values = [_]f64{ 1.0, 2.0, 3.0, 4.0, 5.0 };
    std.debug.print("Average: {d}\n", .{average(&values)});

    const result = divmod(17, 5);
    std.debug.print("{d} / {d} = {d} remainder {d}\n", .{ 17, 5, result.quotient, result.remainder });
}
