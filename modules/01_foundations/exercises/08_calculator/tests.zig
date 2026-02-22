const std = @import("std");
const testing = std.testing;

fn calculate(a: f64, b: f64, op: u8) f64 {
    return switch (op) {
        '+' => a + b,
        '-' => a - b,
        '*' => a * b,
        '/' => if (b != 0) a / b else 0,
        else => 0,
    };
}

test "addition" {
    try testing.expectEqual(@as(f64, 15.0), calculate(10.0, 5.0, '+'));
    try testing.expectEqual(@as(f64, 0.0), calculate(-5.0, 5.0, '+'));
}

test "subtraction" {
    try testing.expectEqual(@as(f64, 5.0), calculate(10.0, 5.0, '-'));
    try testing.expectEqual(@as(f64, -10.0), calculate(-5.0, 5.0, '-'));
}

test "multiplication" {
    try testing.expectEqual(@as(f64, 50.0), calculate(10.0, 5.0, '*'));
    try testing.expectEqual(@as(f64, -25.0), calculate(-5.0, 5.0, '*'));
}

test "division" {
    try testing.expectEqual(@as(f64, 2.0), calculate(10.0, 5.0, '/'));
    try testing.expectEqual(@as(f64, 0.0), calculate(10.0, 0.0, '/')); // Division by zero
}

test "unknown operator" {
    try testing.expectEqual(@as(f64, 0.0), calculate(10.0, 5.0, '%'));
}
