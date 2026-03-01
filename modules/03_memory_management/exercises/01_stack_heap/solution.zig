const std = @import("std");

/// Returns a value computed from stack variables.
/// Create x = 42, y = x + 8, return y.
pub fn stackLifetime() i32 {
    const x: i32 = 42;
    const y = x + 8;
    return y;
}

/// Returns a modified array, demonstrating value semantics.
/// Create array {1,2,3,4,5}, set first element to 99, return array.
pub fn arrayOwnership() [5]i32 {
    var arr = [_]i32{ 1, 2, 3, 4, 5 };
    arr[0] = 99;
    return arr;
}

/// Sums all elements in a slice. Returns 0 for empty slice.
pub fn sliceSum(values: []const i32) i32 {
    var total: i32 = 0;
    for (values) |v| {
        total += v;
    }
    return total;
}
