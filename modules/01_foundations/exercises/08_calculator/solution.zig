const std = @import("std");

fn calculate(a: f64, b: f64, op: u8) f64 {
    return switch (op) {
        '+' => a + b,
        '-' => a - b,
        '*' => a * b,
        '/' => if (b != 0) a / b else 0,
        else => 0,
    };
}

pub fn main() void {
    const a: f64 = 10.0;
    const b: f64 = 5.0;

    const ops = [_]u8{ '+', '-', '*', '/' };

    for (ops) |op| {
        const result = calculate(a, b, op);
        std.debug.print("{d} {c} {d} = {d}\n", .{ a, op, b, result });
    }
}
