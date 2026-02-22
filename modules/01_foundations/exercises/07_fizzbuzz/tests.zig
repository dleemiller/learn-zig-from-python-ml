const std = @import("std");
const testing = std.testing;

fn fizzbuzz(n: usize) []const u8 {
    if (n % 15 == 0) return "FizzBuzz";
    if (n % 3 == 0) return "Fizz";
    if (n % 5 == 0) return "Buzz";
    return "number";
}

test "fizzbuzz logic" {
    try testing.expect(std.mem.eql(u8, fizzbuzz(3), "Fizz"));
    try testing.expect(std.mem.eql(u8, fizzbuzz(5), "Buzz"));
    try testing.expect(std.mem.eql(u8, fizzbuzz(15), "FizzBuzz"));
    try testing.expect(std.mem.eql(u8, fizzbuzz(30), "FizzBuzz"));
    try testing.expect(std.mem.eql(u8, fizzbuzz(7), "number"));
    try testing.expect(std.mem.eql(u8, fizzbuzz(9), "Fizz"));
    try testing.expect(std.mem.eql(u8, fizzbuzz(10), "Buzz"));
}
