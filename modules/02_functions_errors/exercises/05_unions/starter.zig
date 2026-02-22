const std = @import("std");

// TODO: Define a tagged union for shapes with their dimensions
// - circle: needs radius (f64)
// - rectangle: needs width and height (struct with w, h as f64)
// - triangle: needs base and height (struct with base, height as f64)
pub const Shape = union(enum) {
    circle: f64,
    // TODO: Add rectangle and triangle variants
};

// TODO: Calculate the area of a shape using exhaustive switch
// - Circle: pi * r * r
// - Rectangle: width * height
// - Triangle: 0.5 * base * height
pub fn calculateArea(shape: Shape) f64 {
    _ = shape;
    return 0.0;
}

pub fn main() void {
    const circle = Shape{ .circle = 5.0 };
    // TODO: Create rectangle (4x6) and triangle (base 3, height 4)

    std.debug.print("Circle area: {d:.2}\n", .{calculateArea(circle)});
    // TODO: Print rectangle and triangle areas
}
