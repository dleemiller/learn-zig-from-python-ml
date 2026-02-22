const std = @import("std");

pub fn findFirst(values: []const i32, predicate: *const fn (i32) bool) ?i32 {
    for (values) |v| {
        if (predicate(v)) {
            return v;
        }
    }
    return null;
}

pub fn getWithDefault(maybe_value: ?i32, default: i32) i32 {
    return maybe_value orelse default;
}

pub fn doubleOrZero(maybe_value: ?i32) i32 {
    if (maybe_value) |val| {
        return val * 2;
    }
    return 0;
}

fn isEven(x: i32) bool {
    return @rem(x, 2) == 0;
}

fn isGreaterThan100(x: i32) bool {
    return x > 100;
}

pub fn main() void {
    const numbers = [_]i32{ 1, 3, 2, 5, 4 };

    const first_even = findFirst(&numbers, isEven);
    if (first_even) |val| {
        std.debug.print("First even: {d}\n", .{val});
    } else {
        std.debug.print("First even: (not found)\n", .{});
    }

    const first_big = findFirst(&numbers, isGreaterThan100);
    const big_value = getWithDefault(first_big, 0);
    std.debug.print("First > 100: (not found, using default {d})\n", .{big_value});

    const some_value: ?i32 = 42;
    const no_value: ?i32 = null;
    std.debug.print("Value: {d}\n", .{doubleOrZero(some_value)});
    std.debug.print("No value: {d}\n", .{doubleOrZero(no_value)});
}
