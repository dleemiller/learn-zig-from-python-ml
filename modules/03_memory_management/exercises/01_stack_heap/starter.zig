const std = @import("std");

/// Returns a value computed from stack variables.
/// Create x = 42, y = x + 8, return y.
pub fn stackLifetime() i32 {
    // TODO: Create stack variables and return computed value
    return 0;
}

/// Returns a modified array, demonstrating value semantics.
/// Create array {1,2,3,4,5}, set first element to 99, return array.
pub fn arrayOwnership() [5]i32 {
    // TODO: Create array, modify it, return it
    return [_]i32{ 0, 0, 0, 0, 0 };
}

/// Sums all elements in a slice. Returns 0 for empty slice.
pub fn sliceSum(values: []const i32) i32 {
    // TODO: Sum the elements
    _ = values;
    return 0;
}
