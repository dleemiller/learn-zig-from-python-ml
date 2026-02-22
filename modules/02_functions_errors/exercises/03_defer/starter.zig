const std = @import("std");

// A simple counter that tracks cleanup.
// NOTE: This struct uses pointers (*bool, *Counter) — a Module 3 topic.
// The pointer code is pre-written. Don't modify this struct; just use it below.
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

// TODO: Use the counter and ensure cleanup happens with defer
fn useCounter() void {
    var cleanup_called = false;
    var counter = Counter.init(&cleanup_called);

    // TODO: Add defer to call counter.cleanup()

    // Increment 5 times
    var i: i32 = 0;
    while (i < 5) : (i += 1) {
        counter.increment();
    }

    std.debug.print("Counter value: {d}\n", .{counter.value});
}

const InitError = error{SimulatedFailure};

// TODO: Use errdefer to clean up on error
pub fn partialInit(should_fail: bool) InitError!i32 {
    var cleanup_called = false;
    var counter = Counter.init(&cleanup_called);

    // TODO: Add errdefer to call counter.cleanup()
    // This should only run if the function returns an error

    if (should_fail) {
        return error.SimulatedFailure;
    }

    // Success path - counter is "transferred" to caller
    // In real code, you'd return the counter
    return counter.value;
}

// TODO: Demonstrate LIFO ordering of defers
fn lifoDemo() void {
    // TODO: Add three defers that print "1", "2", "3"
    // They should print in order: 3, 2, 1 (LIFO)
    std.debug.print("LIFO order: ", .{});
}

pub fn main() void {
    std.debug.print("Creating counter...\n", .{});
    useCounter();

    std.debug.print("Partial init: ", .{});
    _ = partialInit(true) catch {};

    lifoDemo();
    std.debug.print("\n", .{});
}
