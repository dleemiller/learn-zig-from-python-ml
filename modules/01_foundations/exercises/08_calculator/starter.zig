const std = @import("std");

// TODO: Implement this function
// Handle +, -, *, / operators
// For unknown operators or division by zero, return 0
fn calculate(a: f64, b: f64, op: u8) f64 {
    return 0; // Fix this
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
