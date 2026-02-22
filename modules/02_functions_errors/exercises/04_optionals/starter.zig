const std = @import("std");

// TODO: Find the first element where predicate returns true
// Return null if no element matches
pub fn findFirst(values: []const i32, predicate: *const fn (i32) bool) ?i32 {
    _ = values;
    _ = predicate;
    return null;
}

// TODO: Return the value if present, otherwise return the default
pub fn getWithDefault(maybe_value: ?i32, default: i32) i32 {
    _ = maybe_value;
    _ = default;
    return 0;
}

// TODO: If value is present, double it; otherwise return 0
pub fn doubleOrZero(maybe_value: ?i32) i32 {
    _ = maybe_value;
    return 0;
}

// Predicate functions
fn isEven(x: i32) bool {
    return @rem(x, 2) == 0;
}

fn isGreaterThan100(x: i32) bool {
    return x > 100;
}

pub fn main() void {
    const numbers = [_]i32{ 1, 3, 2, 5, 4 };

    // Find first even number
    const first_even = findFirst(&numbers, isEven);
    if (first_even) |val| {
        std.debug.print("First even: {d}\n", .{val});
    } else {
        std.debug.print("First even: (not found)\n", .{});
    }

    // Find first > 100 (won't find any)
    const first_big = findFirst(&numbers, isGreaterThan100);
    const big_value = getWithDefault(first_big, 0);
    std.debug.print("First > 100: (not found, using default {d})\n", .{big_value});

    // Test doubleOrZero
    const some_value: ?i32 = 42;
    const no_value: ?i32 = null;
    std.debug.print("Value: {d}\n", .{doubleOrZero(some_value)});
    std.debug.print("No value: {d}\n", .{doubleOrZero(no_value)});
}
