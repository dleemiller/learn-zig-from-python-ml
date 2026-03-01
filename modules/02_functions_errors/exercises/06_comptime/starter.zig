const std = @import("std");

// ── Part 1: Generic max ──────────────────────────────────────────────
// TODO: Implement a generic max function.
// It takes a comptime type parameter T and two values of that type,
// and returns the larger value.
pub fn max(comptime T: type, a: T, b: T) T {
    _ = a;
    _ = b;
    return 0;
}

// ── Part 2: Pair type constructor ────────────────────────────────────
// TODO: Make this function return a struct type whose fields use T.
// Right now it ignores T and hardcodes u8 — fix it so the returned
// struct actually uses the type parameter.
pub fn Pair(comptime T: type) type {
    _ = T;
    return struct {
        first: u8,
        second: u8,
    };
}

// ── Part 3: Type introspection ───────────────────────────────────────
// TODO: Return true if T is an integer or float type, false otherwise.
// Hint: switch on @typeInfo(T) and check for .int and .float
pub fn isNumeric(comptime T: type) bool {
    _ = T;
    return false;
}

// ── Part 4: Comptime factorial ───────────────────────────────────────
// TODO: Compute 10! (= 3628800) entirely at compile time.
// Replace the 0 with a labeled block: blk: { ... break :blk result; }
// Use a loop inside the block to compute the factorial.
pub const comptime_factorial: u64 = 0;
