// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint
import Foundation

@main
struct StreamingControllerChecks {
    @MainActor static func wait(_ expected: SillHostProcess.State, _ host: SillHostProcess) async throws {
        for _ in 0..<200 {
            if host.state == expected { return }
            try await Task.sleep(for: .milliseconds(25))
        }
        preconditionFailure("Expected \(expected), got \(host.state)")
    }

    @MainActor static func main() async throws {
        let folder = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: folder) }
        let script = folder.appendingPathComponent("host.sh")
        let trace = folder.appendingPathComponent("trace")
        let body = """
        #!/bin/sh
        [ "$1" = '--embedded' ] || exit 42
        cd "$(dirname "$0")"
        printf SILL_EMBEDDED_
        sleep 0.05
        printf 'READY\\n'
        while IFS= read -r line; do
            case "$line" in
                settings|pair) printf '%s\\n' "$line" >> trace ;;
                *) exit 42 ;;
            esac
        done
        printf 'eof\\n' >> trace
        """
        try body.write(to: script, atomically: true, encoding: .utf8)
        try FileManager.default.setAttributes([.posixPermissions: 0o700], ofItemAtPath: script.path)
        let host = SillHostProcess()
        host.start(executable: script)
        // A second Start during launch must not replace the owned process.
        host.start(executable: URL(fileURLWithPath: "/missing-host"))
        try await wait(.running, host)
        host.showSettings()
        host.pair()
        host.stop()
        host.stop()
        try await wait(.stopped, host)
        let commands = try String(contentsOf: trace, encoding: .utf8)
        precondition(commands == "settings\npair\neof\n", commands)
        host.start(executable: script)
        try await wait(.running, host)
        host.stop()
        try await wait(.stopped, host)
        host.start(executable: script)
        host.stop()
        try await wait(.stopped, host)
        host.start(executable: URL(fileURLWithPath: "/missing-host"))
        precondition(host.state == .failed)
        host.start(executable: script, arguments: ["bad-argument"])
        try await wait(.failed, host)
        print("streaming controller: fragmented readiness, commands, EOF, duplicate start/stop, early stop, restart, missing binary and child failure passed")
    }
}
