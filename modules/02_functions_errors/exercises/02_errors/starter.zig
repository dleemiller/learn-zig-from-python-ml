const std = @import("std");

pub const MathError = error{
    DivisionByZero,
    InvalidDigit,
};

// TODO: Implement safeDivide
// Return error.DivisionByZero if b is 0
pub fn safeDivide(a: i32, b: i32) MathError!i32 {
    _ = a;
    _ = b;
    return 0;
}

// TODO: Implement parseDigit
// Convert '0'-'9' to 0-9
// Return error.InvalidDigit for non-digit characters
pub fn parseDigit(c: u8) MathError!u8 {
    _ = c;
    return 0;
}

// TODO: Implement processValue
// 1. Parse the digit character
// 2. Add 10 to it
// 3. Divide by the divisor
// Use try to propagate errors
pub fn processValue(digit_char: u8, divisor: i32) MathError!i32 {
    _ = digit_char;
    _ = divisor;
    return 0;
}

pub fn main() void {
    // Test safeDivide
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

    // Test parseDigit
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

    // Test processValue
    if (processValue('4', 1)) |result| {
        std.debug.print("Processed: {d}\n", .{result});
    } else |err| {
        std.debug.print("Process error: {s}\n", .{@errorName(err)});
    }
}
