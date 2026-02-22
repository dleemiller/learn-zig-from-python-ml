//! Learn Zig: ML Inference Engine Components
//!
//! This module provides the core library components developed throughout
//! the course, culminating in the capstone ML inference engine.

const std = @import("std");

// Re-export capstone components (added as course progresses)
// pub const tensor = @import("tensor.zig");
// pub const safetensors = @import("safetensors.zig");
// pub const layers = @import("layers.zig");
// pub const simd = @import("simd.zig");

/// Course version
pub const version = "0.1.0";

/// Placeholder test to verify build system works
test "build system works" {
    try std.testing.expect(true);
}
