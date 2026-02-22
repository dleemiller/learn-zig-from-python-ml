const std = @import("std");

pub fn main() void {
    const str: []const u8 = "Hello, Zig!";

    std.debug.print("String: {s}\n", .{str});

    // Get and print the length
    const length: usize = 0; // Fix this
    std.debug.print("Length: {d}\n", .{length});

    // Get first and last characters
    const first: u8 = 0; // Fix this
    const last: u8 = 0; // Fix this
    std.debug.print("First char: {c}\n", .{first});
    std.debug.print("Last char: {c}\n", .{last});

    // Create a substring containing "Hello" (first 5 chars)
    const substring: []const u8 = str; // Fix this
    std.debug.print("Substring [0..5]: {s}\n", .{substring});

    // Compare two strings for equality
    const other = "Hello, Zig!";
    const equal: bool = false; // Fix this
    std.debug.print("Strings equal: {}\n", .{equal});
}
