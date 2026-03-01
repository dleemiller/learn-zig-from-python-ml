const std = @import("std");

/// Swap the values pointed to by a and b.
pub fn swap(a: *i32, b: *i32) void {
    // TODO: Swap the values at the two pointers
    _ = a;
    _ = b;
}

/// Add delta to every element in the slice, modifying in place.
pub fn addToAll(values: []i32, delta: i32) void {
    // TODO: Modify each element in place
    _ = values;
    _ = delta;
}

/// Return a pointer to the maximum element in the slice.
/// Assumes the slice is non-empty.
pub fn maxElement(values: []i32) *i32 {
    // TODO: Find and return a pointer to the largest element
    _ = values;
    unreachable;
}
