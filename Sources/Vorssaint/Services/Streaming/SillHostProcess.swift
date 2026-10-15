// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import Foundation
import Combine
import Darwin

/// Owns only the bundled host. Closing stdin ends it through Sill's existing
/// AppKit shutdown, releasing held input and restoring streamed windows.
@MainActor
final class SillHostProcess: ObservableObject {
    enum State: Equatable { case stopped, starting, running, stopping, failed }
    @Published private(set) var state = State.stopped
    private var process: Process?
    private var input: FileHandle?
    private var output: FileHandle?
    private var startupTimeout: Task<Void, Never>?

    func start(executable: URL, arguments: [String] = ["--embedded"]) {
        guard process == nil else { return }
        let child = Process(), commands = Pipe(), messages = Pipe()
        child.executableURL = executable
        child.arguments = arguments
        child.standardInput = commands
        child.standardOutput = messages
        child.standardError = FileHandle.nullDevice
        child.terminationHandler = { [weak self] child in
            Task { @MainActor in self?.didExit(child) }
        }
        process = child
        state = .starting
        do {
            try child.run()
            // The parent must not keep either child end open: EOF is the
            // lifecycle guarantee, including when Vorssaint crashes.
            try? commands.fileHandleForReading.close()
            try? messages.fileHandleForWriting.close()
            input = commands.fileHandleForWriting
            output = messages.fileHandleForReading
            let reader = messages.fileHandleForReading
            DispatchQueue.global(qos: .utility).async { [weak self] in
                var line = Data(), dropping = false
                while true {
                    var buffer = [UInt8](repeating: 0, count: 4096)
                    let count = Darwin.read(reader.fileDescriptor, &buffer, buffer.count)
                    if count < 0 && errno == EINTR { continue }
                    guard count > 0 else { break }
                    let chunk = Data(buffer.prefix(count))
                    for byte in chunk {
                        if byte == 10 {
                            let marker = dropping ? nil : String(data: line, encoding: .utf8)
                            line.removeAll(keepingCapacity: true)
                            dropping = false
                            if marker == "SILL_EMBEDDED_READY" || marker == "SILL_EMBEDDED_FAILED" {
                                Task { @MainActor [weak self] in self?.receive(marker!, from: child) }
                            }
                        } else if line.count < 4096 && !dropping {
                            line.append(byte)
                        } else {
                            dropping = true
                        }
                    }
                }
            }
            startupTimeout = Task { [weak self, weak child] in
                do { try await Task.sleep(for: .seconds(30)) } catch { return }
                guard let self, let child, self.process === child, self.state == .starting else { return }
                self.state = .failed
                self.stop()
            }
        } catch {
            try? commands.fileHandleForWriting.close()
            try? commands.fileHandleForReading.close()
            try? messages.fileHandleForReading.close()
            try? messages.fileHandleForWriting.close()
            process = nil
            state = .failed
        }
    }

    func showSettings() { send("settings") }
    func pair() { send("pair") }

    func stop() {
        guard let child = process else { return }
        startupTimeout?.cancel()
        if state != .failed { state = .stopping }
        // EOF cannot fail with EPIPE/SIGPIPE, unlike writing a quit command to
        // a host that has already exited. Sill handles EOF exactly as Quit.
        try? input?.close()
        input = nil
        Task { [weak self, weak child] in
            try? await Task.sleep(for: .seconds(6))
            guard let self, let child, self.process === child, child.isRunning else { return }
            child.terminate()
        }
    }

    private func send(_ command: String) {
        guard state == .running, let input else { return }
        // Ignore SIGPIPE only for the duration of this write is not safe in a
        // multithreaded app. A socket-free pipe uses F_SETNOSIGPIPE on macOS.
        _ = fcntl(input.fileDescriptor, F_SETNOSIGPIPE, 1)
        do { try input.write(contentsOf: Data((command + "\n").utf8)) }
        catch { state = .failed; stop() }
    }

    private func receive(_ marker: String, from child: Process) {
        guard process === child, state == .starting else { return }
        startupTimeout?.cancel()
        if marker == "SILL_EMBEDDED_READY" { state = .running }
        else { state = .failed; stop() }
    }

    private func didExit(_ child: Process) {
        guard process === child else { return }
        let stoppedByUser = state == .stopping
        let failed = state == .failed || (!stoppedByUser && child.terminationStatus != 0)
        startupTimeout?.cancel()
        try? input?.close()
        try? output?.close()
        input = nil
        output = nil
        process = nil
        state = failed ? .failed : .stopped
    }
}
