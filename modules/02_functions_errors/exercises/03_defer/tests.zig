const std = @import("std");
const exercise = @import("starter.zig");

// Note: These tests verify behavior conceptually
// The actual exercise is more about understanding than testing

test "Counter cleanup" {
    var cleanup_called = false;
    var counter = exercise.Counter.init(&cleanup_called);
    counter.cleanup();
    try std.testing.expect(cleanup_called);
}

test "partialInit on failure path" {
    // On failure, errdefer should trigger cleanup
    const result = exercise.partialInit(true);
    try std.testing.expectError(error.SimulatedFailure, result);
}

test "partialInit on success path" {
    // On success, errdefer should NOT run
    const result = try exercise.partialInit(false);
    try std.testing.expectEqual(@as(i32, 0), result);
}
