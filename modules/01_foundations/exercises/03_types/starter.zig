const std = @import("std");

pub fn main() void {
    // Part 1: Array indexing with type conversion
    const arr = [_]i32{ 10, 20, 30, 40, 50 };
    const index: i32 = 3;

    const value: i32 = 0; // Fix: access arr at index

    std.debug.print("Array value at index {d}: {d}\n", .{ index, value });

    // Part 2: Temperature conversion (F = C * 9/5 + 32)
    const celsius: f64 = 25.5;

    const fahrenheit: i32 = 0; // Fix: convert celsius to fahrenheit, then to i32

    std.debug.print("{d} C = {d} F\n", .{ celsius, fahrenheit });

    // Part 3: Byte to signed integer
    const byte: u8 = 200;

    const as_signed: i32 = 0; // Fix: convert byte to i32

    std.debug.print("Byte {d} as signed: {d}\n", .{ byte, as_signed });
}
