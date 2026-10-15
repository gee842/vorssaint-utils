// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import AppKit
import Combine

@MainActor
final class StreamingService: ObservableObject {
    static let shared = StreamingService()
    let host = SillHostProcess()
    @Published private(set) var unavailable: Bool = false
    @Published private(set) var standaloneRunning: Bool = false
    private static weak var loaded: StreamingService?

    private init() { Self.loaded = self }

    /// Does not instantiate the service on uninstall or termination.
    static func stopIfLoaded() { loaded?.host.stop() }

    func start() {
        guard AppFeature.streaming.isAvailable else { return }
        standaloneRunning = !NSRunningApplication.runningApplications(
            withBundleIdentifier: "me.saffer.sill.mac").isEmpty
        guard !standaloneRunning else { return }
        guard let bundle = Bundle.main.builtInPlugInsURL?
            .appendingPathComponent("VorssaintStreamingHost.app"),
              let executable = Bundle(url: bundle)?.executableURL,
              FileManager.default.isExecutableFile(atPath: executable.path) else {
            unavailable = true
            return
        }
        unavailable = false
        host.start(executable: executable)
    }

    func pair() {
        guard AppFeature.streaming.isAvailable else { return }
        host.pair()
    }

    func showSettings() {
        guard AppFeature.streaming.isAvailable else { return }
        host.showSettings()
    }
}
