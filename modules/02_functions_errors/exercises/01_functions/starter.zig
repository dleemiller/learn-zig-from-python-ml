const std = @import("std");

// TODO: Implement multiply - returns the product of a and b
pub fn multiply(a: i32, b: i32) i32 {
    _ = a;
    _ = b;
    return 0;
}

// TODO: Implement isPositive - returns true if x > 0
pub fn isPositive(x: i32) bool {
    _ = x;
    return false;
}

// TODO: Implement average - returns the average of a slice of f64
pub fn average(values: []const f64) f64 {
    _ = values;
    return 0.0;
}

// Struct for divmod result
pub const DivResult = struct {
    quotient: i32,
    remainder: i32,
};

// TODO: Implement divmod - returns quotient and remainder
pub fn divmod(a: i32, b: i32) DivResult {
    _ = a;
    _ = b;
    return .{ .quotient = 0, .remainder = 0 };
}

pub fn main() void {
    // Test multiply
    std.debug.print("{d} * {d} = {d}\n", .{ 5, 3, multiply(5, 3) });

    // Test isPositive
    std.debug.print("{d} is positive: {}\n", .{ 5, isPositive(5) });
    std.debug.print("{d} is positive: {}\n", .{ -3, isPositive(-3) });

    // Test average
    const values = [_]f64{ 1.0, 2.0, 3.0, 4.0, 5.0 };
    std.debug.print("Average: {d}\n", .{average(&values)});

    // Test divmod
    const result = divmod(17, 5);
    std.debug.print("{d} / {d} = {d} remainder {d}\n", .{ 17, 5, result.quotient, result.remainder });
}
