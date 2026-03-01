const std = @import("std");

/// Swap the values pointed to by a and b.
pub fn swap(a: *i32, b: *i32) void {
    const temp = a.*;
    a.* = b.*;
    b.* = temp;
}

/// Add delta to every element in the slice, modifying in place.
pub fn addToAll(values: []i32, delta: i32) void {
    for (values) |*v| {
        v.* += delta;
    }
}

/// Return a pointer to the maximum element in the slice.
/// Assumes the slice is non-empty.
pub fn maxElement(values: []i32) *i32 {
    var max_ptr: *i32 = &values[0];
    for (values[1..]) |*v| {
        if (v.* > max_ptr.*) {
            max_ptr = v;
        }
    }
    return max_ptr;
}
