const std = @import("std");

/// A dynamically-allocated buffer that owns its memory.
pub const DynBuffer = struct {
    data: []u8,
    allocator: std.mem.Allocator,

    /// Allocate a buffer of `size` bytes, filled with zeros.
    pub fn init(allocator: std.mem.Allocator, size: usize) !DynBuffer {
        const data = try allocator.alloc(u8, size);
        @memset(data, 0);
        return .{
            .data = data,
            .allocator = allocator,
        };
    }

    /// Free the buffer.
    pub fn deinit(self: *DynBuffer) void {
        self.allocator.free(self.data);
    }

    /// Return the length of the buffer.
    pub fn len(self: DynBuffer) usize {
        return self.data.len;
    }
};

/// Create two DynBuffers, return their combined length.
/// Both buffers must be cleaned up — even if the second init fails.
pub fn createAndCombine(allocator: std.mem.Allocator, size_a: usize, size_b: usize) !usize {
    var first = try DynBuffer.init(allocator, size_a);
    defer first.deinit();

    var second = try DynBuffer.init(allocator, size_b);
    defer second.deinit();

    return first.len() + second.len();
}
