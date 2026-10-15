#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (C) 2026 Vorssaint
set -euo pipefail
cd "$(dirname "$0")/../.."
bin=$(mktemp -d)
trap 'rm -rf "$bin"' EXIT
swiftc -parse-as-library Sources/Vorssaint/Services/Streaming/SillHostProcess.swift \
    Tests/streaming-host-controller/main.swift -o "$bin/check"
"$bin/check"
