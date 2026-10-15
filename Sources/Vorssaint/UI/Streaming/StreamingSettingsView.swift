// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import SwiftUI

struct StreamingSettingsView: View {
    @ObservedObject private var service = StreamingService.shared
    @ObservedObject private var host = StreamingService.shared.host
    @ObservedObject private var l10n = L10n.shared
    private var strings: StreamingStrings { FeatureStrings.streaming(l10n.language) }

    var body: some View {
        Form {
            Section {
                Label("Sill", systemImage: "ipad.and.iphone").font(.headline)
                Text(strings.description)
                if host.state == .starting || host.state == .stopping {
                    ProgressView().controlSize(.small)
                }
                if host.state == .running {
                    Label(strings.active, systemImage: "checkmark.circle.fill")
                }
                HStack {
                    if host.state == .running || host.state == .starting || host.state == .stopping {
                        Button(strings.stop) { host.stop() }.disabled(host.state == .stopping)
                    } else {
                        Button(strings.start) { service.start() }
                    }
                    Button(strings.pair) { service.pair() }.disabled(host.state != .running)
                    Button(strings.settings) { service.showSettings() }.disabled(host.state != .running)
                }
                if service.standaloneRunning {
                    Label(strings.conflict, systemImage: "exclamationmark.triangle")
                }
                if service.unavailable || host.state == .failed {
                    Label(strings.failed, systemImage: "exclamationmark.triangle")
                }
            }
            Section {
                Text(strings.privacy).font(.callout).foregroundStyle(.secondary)
                Link("Sill · App Store", destination: URL(string: "https://apps.apple.com/app/id6816359860")!)
                Link("Sill · Apache-2.0", destination: URL(string: "https://github.com/Saffsanity/sill")!)
            }
        }
        .formStyle(.grouped)
        .disabled(!AppFeature.streaming.isAvailable)
    }
}
