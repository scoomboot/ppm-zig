const std = @import("std");
// Create some alias's
const print = std.debug.print;
const heap = std.heap;

const fs: type = std.fs;

pub fn main() !void {
    var gpa = heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const ptr = try allocator.create(u8);
    defer allocator.destroy(ptr);

    ptr.* = 42;
    print("{*}\n", .{ptr});

    const cwd = fs.cwd();
    const open_file_flags = fs.File.OpenFlags{ .mode = .read_only };
    const file_path = "./file.txt";

    const file = try cwd.openFile(file_path, open_file_flags);

    const buffer = try std.heap.page_allocator.alloc(u8, 1025);
    defer std.heap.page_allocator.free(buffer);

    const bytes_read = try file.read(buffer);

    print("file contents:\n", .{});
    print("{s}\n", .{buffer[0..bytes_read]});
}
