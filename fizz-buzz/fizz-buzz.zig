const std = @import("std");

pub fn main() !void {
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;
    var count: u8 = 1;
    while (count < 70) : (count += 1) {
        const div_3 = @intFromBool(count % 3 == 0);
        const div_5 = @intFromBool(count % 5 == 0);
        switch (@as(u2, div_3) << 1 | div_5) {
            0b00 => try stdout.print("{}\n", .{count}),
            0b10 => try stdout.writeAll("Fizz\n"),
            0b01 => try stdout.writeAll("Buzz\n"),
            0b11 => try stdout.writeAll("Fizz Buzz\n"),
        }
    }
    try stdout.flush();
}
