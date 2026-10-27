# macOS Lean — Complete Research Guide v0.1

**Research-only (27 October 2026). Untested on Golden Gate 27.2. Do not treat this as a stable installer.**

## Goal

Reproducibly clean macOS for Apple Silicon, with tracked trade-offs, optional debloating, battery/sleep tests, rollback, and current security updates. More free RAM or more disabled services does not prove increased speed or endurance.

## Profiles

| Profile | SIP | Change |
|---|---|---|
| Clean | On | Official macOS, app hygiene, optimized settings |
| Balanced | On | Reviewed RemoveMacAI changes; reviewed mac-os-debloat balanced preset |
| Experimental | Off | Pinned, reviewed balanced preset plus feature exclusions, security downgrade acknowledged |

**Never use `--disable-all` as a universal recommendation**; it can break core functionality. SIP disabling removes important system protections and has no established M4 battery or performance benefit.

## Version selection

Do not declare the newest macOS release the best. Before promoting any Golden Gate 27.x build, confirm Apple security patches, upstream debloat compatibility and rollback, real M4 battery/sleep measurements, and application compatibility (Firefox, Homebrew, Steam, VPN, coding CLIs, Apple Account and Time Machine).

## Backup and baseline

Verify a full Time Machine backup AND independent files backup. Check recovery by restoring test files. Protect university work, SSH/GPG keys, project repositories, credentials and licenses. Never upload secrets, serials or raw local logs.

Run `scripts/read-only-baseline.sh` locally, review its output, and measure 3 ordinary browser sessions plus 3 overnight sleep tests at fixed brightness and similar conditions.

## Fresh installation

**Simplest recommended path:** Upgrade to the vetted macOS version using Software Update. Then System Settings → General → Transfer or Reset → Erase All Content and Settings. This resets user data and settings, **not OS binaries or version**. Set up as new and restore selected documents without importing old launch agents and caches.

**Advanced path:** official macOS installer and Recovery erase/reinstall when system replacement or deliberate compatible downgrade is required. Confirm exact hardware support; verify multiple backups and follow Apple's Recovery/USB instructions. Do not use random macOS images.

## First boot

Enable FileVault, Find My, automatic security updates, and normal Gatekeeper protections. Review Sharing and Login Items. Leave Spotlight and backup services enabled at first. For plugged-in use set the native battery charge limit (80% if suitable), Optimized Battery Charging on, Low Power Mode on battery, and Wake for network access Never if unnecessary. Choose an early display timeout and comfortable brightness. Disable auto-start for unused Steam, Spotify, Discord and other apps, but preserve extensions required by an active VPN.

Install native/official apps, browser, package manager and necessary dev tools only. Inspect Steam games, Stremio media caches, Spotify cache, browser profiles and developer caches before deleting them; never blindly remove system directories.

## Debloat order

1. Benchmark **untweaked** macOS after indexing and cloud sync settle.
2. Review pinned RemoveMacAI release and its preview/dry-run; disable only functions you knowingly do not need. Document all changes and test reversal.
3. Restore to baseline; review pinned mac-os-debloat README and balanced dry-run. Exclude services needed for Apple ID, Spotlight, updates, AirDrop, Continuity, iPad integration, power limits and sleep. Document every disabled label and boot helper.
4. If deliberately testing SIP-off: understand the security downgrade, use Apple Silicon Recovery, record `csrutil status`, and avoid publishing it as the recommended profile. Verify ability to restore services and re-enable SIP from Recovery.
5. Reboot after each change; run smoke tests and metrics. Don't stack both tools' AI changes without checking overlap.

Previous mac-os-debloat releases reportedly interfered with native battery charge limiting by disabling power services; preserve those and verify the 80% charge limit after reboot.

## Test and recovery

Use [docs/VALIDATION.md](docs/VALIDATION.md). Measure battery %/hour, 8h sleep drain, memory pressure/swap, CPU use, disk consumption, and actual responsiveness. Test Apple Account, App Store, Software Update, Spotlight, camera, audio, Wi-Fi/Bluetooth, VPN, Time Machine, USB-C, AirDrop and charging behavior.

Before major OS updates: backup, revert debloat overrides/configuration profiles, restore SIP if disabled, install official patch, verify hardware and software, then selectively reapply changes only when compatible.

See [docs/SOURCES.md](docs/SOURCES.md) for authoritative Apple sources, upstream software, user reports and video setup guides. YouTube/Reddit suggestions are not controlled benchmarks.

**No scripts in this repository execute debloating automatically.** The baseline collector is intentionally read-only.
