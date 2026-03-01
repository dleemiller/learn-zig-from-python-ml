const std = @import("std");

/// A simple ML model that owns its weights and bias.
pub const SimpleModel = struct {
    weights: []f64,
    bias: []f64,
    input_size: usize,
    output_size: usize,
    allocator: std.mem.Allocator,

    /// Allocate weights (input_size * output_size, filled with 0.1)
    /// and bias (output_size, filled with 0.0).
    /// Use errdefer to free weights if bias allocation fails.
    pub fn init(allocator: std.mem.Allocator, input_size: usize, output_size: usize) !SimpleModel {
        // TODO: Allocate weights and bias with proper errdefer
        _ = allocator;
        _ = input_size;
        _ = output_size;
        return error.OutOfMemory;
    }

    /// Free weights and bias.
    pub fn deinit(self: *SimpleModel) void {
        // TODO: Free both allocations
        _ = self;
    }

    /// Compute output = input * weights + bias.
    /// Uses an arena for scratch work; result is from result_allocator.
    /// Caller owns the returned memory.
    pub fn predict(self: SimpleModel, result_allocator: std.mem.Allocator, input: []const f64) ![]f64 {
        // TODO: Arena for scratch, result_allocator for output
        _ = self;
        _ = result_allocator;
        _ = input;
        return error.OutOfMemory;
    }
};
