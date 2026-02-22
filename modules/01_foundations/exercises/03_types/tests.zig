const std = @import("std");
const testing = std.testing;

test "array index conversion" {
    const arr = [_]i32{ 10, 20, 30, 40, 50 };
    const index: i32 = 3;
    const value = arr[@intCast(index)];
    try testing.expectEqual(@as(i32, 40), value);
}

test "celsius to fahrenheit" {
    const celsius: f64 = 25.5;
    const fahrenheit_float = celsius * 9.0 / 5.0 + 32.0;
    const fahrenheit: i32 = @intFromFloat(fahrenheit_float);
    try testing.expectEqual(@as(i32, 77), fahrenheit);
}

test "byte to signed" {
    const byte: u8 = 200;
    const as_signed: i32 = @as(i32, byte);
    try testing.expectEqual(@as(i32, 200), as_signed);
}
