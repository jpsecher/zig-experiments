const std = @import("std");

pub fn main() !void {
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;
    var count: u8 = 1;
    while (count < 70) : (count += 1) {
        if (count % 3 == 0 and count % 5 == 0) {
            try stdout.writeAll("Fizz Buzz\n");
        } else if (count % 3 == 0) {
            try stdout.writeAll("Fizz\n");
        } else if (count % 5 == 0) {
            try stdout.writeAll("Buzz\n");
        } else try stdout.print("{}\n", .{count});
    }
    try stdout.flush();
}

test "trivials" {
    const expectEq = std.testing.expectEqual;
    try expectEq(1, 1);
}
