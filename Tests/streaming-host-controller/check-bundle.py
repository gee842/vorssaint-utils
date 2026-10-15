# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (C) 2026 Vorssaint
"""Check the packaged identity and refuse an independent helper launch."""
import pathlib
import plistlib
import subprocess
import sys

app = pathlib.Path(sys.argv[1]).resolve()
parent = plistlib.loads((app / 'Contents/Info.plist').read_bytes())
host = app / 'Contents/PlugIns/VorssaintStreamingHost.app'
info = plistlib.loads((host / 'Contents/Info.plist').read_bytes())
assert info['SillManagedHost'] is True
assert info['CFBundleIdentifier'] == parent['CFBundleIdentifier'] + '.streaming-host'
assert info['NSBonjourServices'] == ['_sill._tcp']
assert info['NSLocalNetworkUsageDescription']
assert (host / 'Contents/Resources/Sill-LICENSE').is_file()
assert (host / 'Contents/Resources/Sill-NOTICE').is_file()
result = subprocess.run([str(host / 'Contents/MacOS/Sill')], capture_output=True, timeout=8)
assert result.returncode == 2, result.returncode
assert b'must be started by its containing app' in result.stderr
print('streaming bundle: isolated identity, managed launch, network declaration and attribution passed')
