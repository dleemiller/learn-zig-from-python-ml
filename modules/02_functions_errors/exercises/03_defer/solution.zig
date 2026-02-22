const std = @import("std");

pub const Counter = struct {
    value: i32,
    cleanup_called: *bool,

    pub fn init(cleanup_flag: *bool) Counter {
        return .{ .value = 0, .cleanup_called = cleanup_flag };
    }

    pub fn increment(self: *Counter) void {
        self.value += 1;
    }

    pub fn cleanup(self: *Counter) void {
        self.cleanup_called.* = true;
        std.debug.print("Cleanup called\n", .{});
    }
};

fn useCounter() void {
    var cleanup_called = false;
    var counter = Counter.init(&cleanup_called);
    defer counter.cleanup();

    var i: i32 = 0;
    while (i < 5) : (i += 1) {
        counter.increment();
    }

    std.debug.print("Counter value: {d}\n", .{counter.value});
}

const InitError = error{SimulatedFailure};

pub fn partialInit(should_fail: bool) InitError!i32 {
    var cleanup_called = false;
    var counter = Counter.init(&cleanup_called);
    errdefer counter.cleanup();

    if (should_fail) {
        return error.SimulatedFailure;
    }

    return counter.value;
}

fn lifoDemo() void {
    defer std.debug.print("1\n", .{});
    defer std.debug.print("2, ", .{});
    defer std.debug.print("3, ", .{});
    std.debug.print("LIFO order: ", .{});
}

pub fn main() void {
    std.debug.print("Creating counter...\n", .{});
    useCounter();

    std.debug.print("Partial init: ", .{});
    _ = partialInit(true) catch {};

    lifoDemo();
}
