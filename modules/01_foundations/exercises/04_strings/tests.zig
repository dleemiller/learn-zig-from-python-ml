const std = @import("std");
const testing = std.testing;

test "string length" {
    const str = "Hello, Zig!";
    try testing.expectEqual(@as(usize, 11), str.len);
}

test "string indexing" {
    const str = "Hello, Zig!";
    try testing.expectEqual(@as(u8, 'H'), str[0]);
    try testing.expectEqual(@as(u8, '!'), str[str.len - 1]);
}

test "string slicing" {
    const str = "Hello, Zig!";
    const substring = str[0..5];
    try testing.expect(std.mem.eql(u8, substring, "Hello"));
}

test "string equality" {
    const str1 = "Hello";
    const str2 = "Hello";
    const str3 = "World";
    try testing.expect(std.mem.eql(u8, str1, str2));
    try testing.expect(!std.mem.eql(u8, str1, str3));
}
