const std = @import("std");

/// A dynamically-allocated buffer that owns its memory.
pub const DynBuffer = struct {
    data: []u8,
    allocator: std.mem.Allocator,

    /// Allocate a buffer of `size` bytes, filled with zeros.
    pub fn init(allocator: std.mem.Allocator, size: usize) !DynBuffer {
        // TODO: Allocate, fill with zeros, return struct
        _ = allocator;
        _ = size;
        return error.OutOfMemory;
    }

    /// Free the buffer.
    pub fn deinit(self: *DynBuffer) void {
        // TODO: Free self.data using self.allocator
        _ = self;
    }

    /// Return the length of the buffer.
    pub fn len(self: DynBuffer) usize {
        // TODO: Return the buffer length
        _ = self;
        return 0;
    }
};

/// Create two DynBuffers, return their combined length.
/// Both buffers must be cleaned up — even if the second init fails.
pub fn createAndCombine(allocator: std.mem.Allocator, size_a: usize, size_b: usize) !usize {
    // TODO: Create first buffer (ensure cleanup if second init fails),
    // create second buffer, compute result, clean up both
    _ = allocator;
    _ = size_a;
    _ = size_b;
    return error.OutOfMemory;
}
