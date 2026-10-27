# Sources, evidence quality, and research date

**Snapshot: 27 October 2026.** This document distinguishes authoritative Apple statements, upstream author claims, public community anecdotes and editorial video recommendations. The repository's M4 Air validation has **not** been run yet.

## Level A — Apple platform documentation

- [Golden Gate 27.2 Apple security release](https://support.apple.com/en-us/149521) — released 26 October 2026.
- [Apple Developer release information](https://developer.apple.com/news/releases/?id=10052026f) — macOS 27.2 build 26B123.
- [Erase All Content and Settings](https://support.apple.com/es-es/102664) — preserves the current OS while erasing user data, apps and settings.
- [Apple silicon Recovery](https://support.apple.com/en-us/102518) — supported reinstall path.
- [Download/install macOS](https://support.apple.com/en-us/102662) and [bootable installer](https://support.apple.com/en-ie/101578).
- [Battery charge limit and Optimized Battery Charging](https://support.apple.com/en-ie/102338) — charge-limit option introduced Tahoe 26.4 on Apple Silicon; occasional 100% calibration charges expected.
- [System Integrity Protection](https://support.apple.com/en-ca/guide/security/secb7ea06b49/web) — enforced constraints on critical macOS changes.
- [Apple Silicon startup security](https://support.apple.com/en-gb/guide/security/sec7d92dc49f/web).
- [macOS security update listing](https://support.apple.com/en-us/100100).

## Level B — third-party tool docs (maintainer claims, not independent verification)

- [RemoveMacAI](https://github.com/omlahore/RemoveMacAI) — reviewed Git commit 053f86a4f767e8fbbf9f3538805ab8674262474e; 2026-10-26. Selective Apple Intelligence, privacy and UI settings; rollback limitations. The maintainer documents 27.0 and later incremental changes, **not a complete 27.2 validation here**.
- [mac-os-debloat](https://github.com/OleksandrKrupko/mac-os-debloat) — reviewed Git commit 1f3b1c82ddb12c0e333310c0d6c675f792320d12; 2026-10-12. Documents 307 launchd labels and 188 balanced catalog labels. Any RAM benefit or safe disable catalog is upstream-reported.
- [mac-os-debloat releases](https://github.com/OleksandrKrupko/mac-os-debloat/releases) — reports prior battery-limit breakage when powerlogHelperd/perfpowermetricd were disabled.
- [Power limit regression issue #21](https://github.com/OleksandrKrupko/mac-os-debloat/issues/21).
- [Siri agent login issue #7](https://github.com/OleksandrKrupko/mac-os-debloat/issues/7).

## Level C — community experience (anecdotal)

- [macOS 27.2 release discussion](https://www.reddit.com/r/MacOS/comments/1xg3yia/macos_272_released_to_public/) — preliminary feedback; no reliable M4-specific statistical comparison.
- [RemoveMacAI developer/community discussion](https://www.reddit.com/r/MacOS/comments/1ww1exr/macos_27_dropped_the_apple_intelligence_off/) — illustrates interest in removing models; author has an obvious stake in project success.
- [Golden Gate vs Sequoia experiences](https://www.reddit.com/r/MacOS/comments/1xfri4y/going_back_to_sequoia/) — uncontrolled user reports.

These discussions can identify issues to test, but have hardware, app, temperature, brightness and release-selection bias.

## Level D — YouTube configuration ideas (editorial)

- [Proper Honest Tech — macOS setup](https://www.youtube.com/watch?v=vT83_ypgd6k).
- [AppleTheme — macOS adjustments](https://www.youtube.com/watch?v=T1Q4iCc3ses).

Use UI convenience and privacy tips as hypotheses. Independent battery and performance data are still required. A tutorial's popularity or advertising does not prove an optimization.

## Claim policy

Every numeric result in this repo must carry date, OS/build, model, source, independent-vs-maintainer status and testing conditions. No extrapolation of 1 machine's used RAM, 5-minute CPU samples or one night's standby drain into guaranteed gains for all Macs. Recheck links before any future stable release.
