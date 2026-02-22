const std = @import("std");

pub fn main() void {
    const str: []const u8 = "Hello, Zig!";

    std.debug.print("String: {s}\n", .{str});

    const length: usize = str.len;
    std.debug.print("Length: {d}\n", .{length});

    const first: u8 = str[0];
    const last: u8 = str[str.len - 1];
    std.debug.print("First char: {c}\n", .{first});
    std.debug.print("Last char: {c}\n", .{last});

    const substring: []const u8 = str[0..5];
    std.debug.print("Substring [0..5]: {s}\n", .{substring});

    const other = "Hello, Zig!";
    const equal: bool = std.mem.eql(u8, str, other);
    std.debug.print("Strings equal: {}\n", .{equal});
}
