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
        const weights = try allocator.alloc(f64, input_size * output_size);
        errdefer allocator.free(weights);
        @memset(weights, 0.1);

        const bias = try allocator.alloc(f64, output_size);
        @memset(bias, 0.0);

        return .{
            .weights = weights,
            .bias = bias,
            .input_size = input_size,
            .output_size = output_size,
            .allocator = allocator,
        };
    }

    /// Free weights and bias.
    pub fn deinit(self: *SimpleModel) void {
        self.allocator.free(self.weights);
        self.allocator.free(self.bias);
    }

    /// Compute output = input * weights + bias.
    /// Uses an arena for scratch work; result is from result_allocator.
    /// Caller owns the returned memory.
    pub fn predict(self: SimpleModel, result_allocator: std.mem.Allocator, input: []const f64) ![]f64 {
        // Arena for scratch computation
        var arena = std.heap.ArenaAllocator.init(result_allocator);
        defer arena.deinit();
        const scratch_alloc = arena.allocator();

        // Scratch buffer for intermediate computation
        const scratch = try scratch_alloc.alloc(f64, self.output_size);

        // Compute: scratch[j] = bias[j] + sum(input[i] * weights[i * output_size + j])
        for (0..self.output_size) |j| {
            var sum: f64 = self.bias[j];
            for (0..self.input_size) |i| {
                sum += input[i] * self.weights[i * self.output_size + j];
            }
            scratch[j] = sum;
        }

        // Result from result_allocator (survives arena.deinit)
        const result = try result_allocator.alloc(f64, self.output_size);
        @memcpy(result, scratch);

        return result;
    }
};
