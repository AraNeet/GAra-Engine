const std = @import("std");

// Build Setting.
pub fn build(b: *std.Build) void {
    // Target
    const target = b.standardTargetOptions(.{});
    // Default Optimizer
    const optimize = b.standardOptimizeOption(.{});

    // Engine .dll definition.
    const engine = b.addSharedLibrary(.{
        .name = "Gara",
        .root_source_file = b.path("Gara/root.zig"),
        .target = target,
        .optimize = optimize,
        .version = .{ .major = 0, .minor = 0, .patch = 1 },
    });

    b.installArtifact(engine);

    const sandbox = b.addExecutable(.{
        .name = "GaraSandbox",
        .root_source_file = b.path("Sandbox/main.zig"),
        .target = target,
    });

    sandbox.linkLibrary(engine);

    b.installArtifact(sandbox);
    const run_exe = b.addRunArtifact(sandbox);

    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_exe.step);
}
