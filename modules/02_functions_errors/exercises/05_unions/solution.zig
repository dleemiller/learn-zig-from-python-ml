const std = @import("std");

pub const Shape = union(enum) {
    circle: f64,
    rectangle: struct { w: f64, h: f64 },
    triangle: struct { base: f64, height: f64 },
};

pub fn calculateArea(shape: Shape) f64 {
    return switch (shape) {
        .circle => |r| 3.14159 * r * r,
        .rectangle => |rect| rect.w * rect.h,
        .triangle => |tri| 0.5 * tri.base * tri.height,
    };
}

pub fn main() void {
    const circle = Shape{ .circle = 5.0 };
    const rectangle = Shape{ .rectangle = .{ .w = 4.0, .h = 6.0 } };
    const triangle = Shape{ .triangle = .{ .base = 3.0, .height = 4.0 } };

    std.debug.print("Circle area: {d:.2}\n", .{calculateArea(circle)});
    std.debug.print("Rectangle area: {d:.2}\n", .{calculateArea(rectangle)});
    std.debug.print("Triangle area: {d:.2}\n", .{calculateArea(triangle)});
}
