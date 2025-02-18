const std = @import("std");
// Create some alias's
const print = std.debug.print;
const heap = std.heap;

pub fn main() !void {
    var gpa = heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const ptr = try allocator.create(u8);
    defer allocator.destroy(ptr);

    ptr.* = 42;
    print("{*}\n", .{ptr});
}
