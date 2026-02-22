const std = @import("std");

pub const MathError = error{
    DivisionByZero,
    InvalidDigit,
};

pub fn safeDivide(a: i32, b: i32) MathError!i32 {
    if (b == 0) {
        return error.DivisionByZero;
    }
    return @divTrunc(a, b);
}

pub fn parseDigit(c: u8) MathError!u8 {
    if (c >= '0' and c <= '9') {
        return c - '0';
    }
    return error.InvalidDigit;
}

pub fn processValue(digit_char: u8, divisor: i32) MathError!i32 {
    const digit = try parseDigit(digit_char);
    const value = @as(i32, digit) + 10;
    return try safeDivide(value, divisor);
}

pub fn main() void {
    if (safeDivide(10, 2)) |result| {
        std.debug.print("10 / 2 = {d}\n", .{result});
    } else |err| {
        std.debug.print("10 / 2 = Error: {}\n", .{err});
    }

    if (safeDivide(10, 0)) |result| {
        std.debug.print("10 / 0 = {d}\n", .{result});
    } else |err| {
        std.debug.print("10 / 0 = Error: {s}\n", .{@errorName(err)});
    }

    if (parseDigit('5')) |result| {
        std.debug.print("parseDigit('5') = {d}\n", .{result});
    } else |err| {
        std.debug.print("parseDigit('5') = Error: {s}\n", .{@errorName(err)});
    }

    if (parseDigit('x')) |result| {
        std.debug.print("parseDigit('x') = {d}\n", .{result});
    } else |err| {
        std.debug.print("parseDigit('x') = Error: {s}\n", .{@errorName(err)});
    }

    if (processValue('4', 1)) |result| {
        std.debug.print("Processed: {d}\n", .{result});
    } else |err| {
        std.debug.print("Process error: {s}\n", .{@errorName(err)});
    }
}
