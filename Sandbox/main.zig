// Main App.
const std = @import("std");

extern fn welcome() void;

pub fn main() !void {
    welcome();
}
