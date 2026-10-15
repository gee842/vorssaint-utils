#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (C) 2026 Vorssaint
set -euo pipefail
cd "$(dirname "$0")/.."
# The parent app has a Swift 6.0 compatibility build. The pinned Sill host
# uses newer SDK APIs, so build it with the machine's default Xcode, independently.
if [ -n "${SILL_DEVELOPER_DIR:-}" ]; then
    export DEVELOPER_DIR="$SILL_DEVELOPER_DIR"
else
    unset DEVELOPER_DIR
fi
source_dir="$PWD/Vendor/Sill"
destination="${1:?usage: build-streaming-host.sh APP_CONTENTS BUNDLE_ID}"
identity="${2:?missing parent bundle identifier}.streaming-host"
if [ ! -f "$source_dir/Package.swift" ]; then
    echo 'Missing pinned Sill source. Run: git submodule update --init -- Vendor/Sill' >&2
    exit 1
fi
swift build --package-path "$source_dir" -c release --product SillMenuBar
binary_dir=$(swift build --package-path "$source_dir" -c release --show-bin-path)
app="$destination/PlugIns/VorssaintStreamingHost.app"
mkdir -p "$app/Contents/MacOS" "$app/Contents/Resources"
cp "$binary_dir/SillMenuBar" "$app/Contents/MacOS/Sill"
cp "$source_dir/Packaging/Info.plist" "$app/Contents/Info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier $identity" "$app/Contents/Info.plist"
/usr/libexec/PlistBuddy -c 'Set :CFBundleName Vorssaint Streaming Host' "$app/Contents/Info.plist"
/usr/libexec/PlistBuddy -c 'Set :CFBundleDisplayName Vorssaint Streaming Host' "$app/Contents/Info.plist"
/usr/libexec/PlistBuddy -c 'Add :SillManagedHost bool true' "$app/Contents/Info.plist"
/usr/libexec/PlistBuddy -c 'Delete :CFBundleIconFile' "$app/Contents/Info.plist"
/usr/libexec/PlistBuddy -c 'Delete :CFBundleIconName' "$app/Contents/Info.plist"
cp "$source_dir/LICENSE" "$app/Contents/Resources/Sill-LICENSE"
printf '%s\n' 'Sill by Saffsanity · https://github.com/Saffsanity/sill · Apache-2.0' > "$app/Contents/Resources/Sill-NOTICE"
