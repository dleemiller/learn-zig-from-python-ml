const std = @import("std");

pub fn main() void {
    // Part 1: Array indexing with type conversion
    const arr = [_]i32{ 10, 20, 30, 40, 50 };
    const index: i32 = 3;

    const value: i32 = arr[@intCast(index)];

    std.debug.print("Array value at index {d}: {d}\n", .{ index, value });

    // Part 2: Temperature conversion
    const celsius: f64 = 25.5;
    // Formula: F = C * 9/5 + 32
    const fahrenheit_float = celsius * 9.0 / 5.0 + 32.0;
    const fahrenheit: i32 = @intFromFloat(fahrenheit_float);

    std.debug.print("{d} C = {d} F\n", .{ celsius, fahrenheit });

    // Part 3: Byte to signed integer
    const byte: u8 = 200;
    const as_signed: i32 = @as(i32, byte);

    std.debug.print("Byte {d} as signed: {d}\n", .{ byte, as_signed });
}
