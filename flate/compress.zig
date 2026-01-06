const std = @import("std");
const flate = std.compress.flate;

pub fn main() !void {
    var threaded: std.Io.Threaded = .init_single_threaded;
    const io = threaded.io();
    const cwd = std.Io.Dir.cwd();
    var file = try cwd.createFile(io, "my_file", .{});
    defer file.close(io);

    var write_buffer: [flate.max_window_len]u8 = undefined;
    var file_writer: std.Io.File.Writer = .init(file, io, &write_buffer);

    var flate_buffer: [flate.max_window_len]u8 = undefined;
    var compress: flate.Compress = try .init(&file_writer.interface, &flate_buffer, .zlib, .level_2);
    try compress.writer.writeAll("my content\n");

    try compress.writer.flush();
    try file_writer.interface.flush();
}
