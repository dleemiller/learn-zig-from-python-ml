const std = @import("std");

pub fn main() void {
    std.debug.print("Hello, Zig!\n", .{});
    std.debug.print("My name is {s}\n", .{"Student"});
}
