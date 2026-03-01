const std = @import("std");
const exercises = @import("starter.zig");

test "SimpleModel init creates correct sizes" {
    const allocator = std.testing.allocator;
    var model = try exercises.SimpleModel.init(allocator, 3, 2);
    defer model.deinit();

    try std.testing.expectEqual(@as(usize, 3), model.input_size);
    try std.testing.expectEqual(@as(usize, 2), model.output_size);
    try std.testing.expectEqual(@as(usize, 6), model.weights.len); // 3 * 2
    try std.testing.expectEqual(@as(usize, 2), model.bias.len);
}

test "SimpleModel weights initialized to 0.1" {
    const allocator = std.testing.allocator;
    var model = try exercises.SimpleModel.init(allocator, 2, 2);
    defer model.deinit();

    for (model.weights) |w| {
        try std.testing.expectApproxEqAbs(@as(f64, 0.1), w, 1e-10);
    }
}

test "SimpleModel bias initialized to 0.0" {
    const allocator = std.testing.allocator;
    var model = try exercises.SimpleModel.init(allocator, 2, 2);
    defer model.deinit();

    for (model.bias) |b| {
        try std.testing.expectApproxEqAbs(@as(f64, 0.0), b, 1e-10);
    }
}

test "SimpleModel predict computes correct output" {
    const allocator = std.testing.allocator;
    var model = try exercises.SimpleModel.init(allocator, 3, 2);
    defer model.deinit();

    // With weights all 0.1 and bias all 0.0:
    // output[j] = sum(input[i] * 0.1) for i in 0..3
    // For input = {1.0, 2.0, 3.0}:
    // output[0] = 1.0*0.1 + 2.0*0.1 + 3.0*0.1 = 0.6
    // output[1] = 1.0*0.1 + 2.0*0.1 + 3.0*0.1 = 0.6
    const input = [_]f64{ 1.0, 2.0, 3.0 };
    const result = try model.predict(allocator, &input);
    defer allocator.free(result);

    try std.testing.expectEqual(@as(usize, 2), result.len);
    try std.testing.expectApproxEqAbs(@as(f64, 0.6), result[0], 1e-10);
    try std.testing.expectApproxEqAbs(@as(f64, 0.6), result[1], 1e-10);
}

test "SimpleModel predict with non-zero bias" {
    const allocator = std.testing.allocator;
    var model = try exercises.SimpleModel.init(allocator, 2, 2);
    defer model.deinit();

    // Set bias manually for testing
    model.bias[0] = 1.0;
    model.bias[1] = 2.0;

    // output[0] = 1.0 + (1.0*0.1 + 1.0*0.1) = 1.2
    // output[1] = 2.0 + (1.0*0.1 + 1.0*0.1) = 2.2
    const input = [_]f64{ 1.0, 1.0 };
    const result = try model.predict(allocator, &input);
    defer allocator.free(result);

    try std.testing.expectApproxEqAbs(@as(f64, 1.2), result[0], 1e-10);
    try std.testing.expectApproxEqAbs(@as(f64, 2.2), result[1], 1e-10);
}

test "SimpleModel predict does not leak memory" {
    // std.testing.allocator will catch leaks from arena or result
    const allocator = std.testing.allocator;
    var model = try exercises.SimpleModel.init(allocator, 4, 3);
    defer model.deinit();

    const input = [_]f64{ 1.0, 0.5, 0.25, 0.125 };
    const result = try model.predict(allocator, &input);
    defer allocator.free(result);

    try std.testing.expectEqual(@as(usize, 3), result.len);
}

test "SimpleModel predict result is independent of arena" {
    // Verifies the result is not from the arena (would be garbage after deinit)
    const allocator = std.testing.allocator;
    var model = try exercises.SimpleModel.init(allocator, 2, 1);
    defer model.deinit();

    const input = [_]f64{ 1.0, 1.0 };

    // Call predict twice — each should return valid, independent results
    const r1 = try model.predict(allocator, &input);
    defer allocator.free(r1);
    const r2 = try model.predict(allocator, &input);
    defer allocator.free(r2);

    try std.testing.expectApproxEqAbs(r1[0], r2[0], 1e-10);
}
