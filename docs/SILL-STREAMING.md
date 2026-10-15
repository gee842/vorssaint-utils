# Native streaming with Sill

Install **Sill** in Settings → Features, open its Settings page, and choose
Start streaming. Pair from Sill on your iPhone or iPad, or choose Pair a device.
Streaming settings opens the native host's settings for quality, devices,
permissions and optional remote access. The companion app is linked from
https://getsill.app. No separately installed Mac copy of Sill is required.

The feature is uninstalled by default and never starts a listener merely by
being installed. Start is an explicit action each time Vorssaint launches.
Stop, feature uninstall and Vorssaint exit close the host's private control pipe.
The native host then follows Sill's normal orderly shutdown, releasing input
and restoring streamed windows. Parent crash also closes the pipe. There is no
new network control API. Quit a separately running Sill Mac app before starting
this host to avoid confusing discovery and permissions.

## Permissions and private state

The host is a nested native app under `Contents/PlugIns`, with bundle identifier
`<Vorssaint bundle ID>.streaming-host` and display name **Vorssaint Streaming Host**.
Screen Recording, Accessibility and (macOS 15+) Local Network are granted to that
host, not inferred from Vorssaint's existing grants. The permission page inside
Streaming settings requests them only when used. Stop/start the host after a
Screen Recording grant; its standalone relaunch and login item are disabled.
The host's update mechanism is also disabled: Vorssaint updates its pinned code.
Opening the nested app independently without the embedding flag is refused.

Feature availability participates in Vorssaint settings backup. Host quality,
device observations and permission onboarding remain in the host's own local
preferences; these are intentionally excluded from portable backups in this
initial integration. Pairing identity, recognition key, trust list and Require
pairing are machine-local keychain items under a separate namespace. Existing
Sill keys are never imported. Uninstalling the feature preserves host settings
and pairings, so reinstalling can restore them. Logs use the helper's own bundle
identifier under `~/Library/Logs`. Pairing remains required by default, and
Remote Access and Direct Wireless keep Sill's off-by-default behavior.

## Source, build and maintenance

`Vendor/Sill` is a pinned Git submodule, including the proposed embedding API.
Initialize it with `git submodule update --init -- Vendor/Sill` after checkout.
`build.sh` compiles Sill's existing `SillMenuBar` product and packages it with a
separate identity, original license and source attribution. No downloaded binary
is used. Nested signing happens before signing Vorssaint. CI and release
checkouts initialize the pinned submodule. The helper uses the machine’s default
current Xcode independently of the parent’s Swift 6.0 compatibility toolchain;
set `SILL_DEVELOPER_DIR` to select another suitable Xcode for the helper.

Sill is Apache-2.0 licensed; Vorssaint remains GPL-3.0-or-later. Sill's source,
license and attribution travel with the source dependency, and its license and
source link are included in the built helper. No App Store client changes are
required. The included native Sill settings retain their upstream English UI;
Vorssaint's new feature page covers all currently registered app languages.

The integration is proposed in vorssaint/vorssaint-utils#3128 and Saffsanity/sill#125.
The dependency and helper design require maintainer review before release.

## Validation boundary

Builds, parser tests, synthetic-host shutdown and controller lifecycle tests
exercise packaging and ownership. They do not prove physical iPhone/iPad pairing,
TCC attribution, HEVC playback, input forwarding, USB, AWDL, VPN or restoration of
real windows. Those require a device and explicit macOS permission grants.
