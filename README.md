# macOS Lean

### A reproducible, evidence-based macOS clean install and debloat handbook

**Research preview — v0.2, 27 October 2026. Not a stable one-click installer.** Golden Gate 27.2 was released on 26 October; this project has not yet verified Golden Gate 27.2 on its target **MacBook Air M4 (16 GB / 256 GB)**.

macOS Lean helps Apple Silicon owners start from clean macOS, make informed optimizations, optionally disable unnecessary features and **measure** if anything actually improved. It is designed to preserve a recovery route, not win a competition for the most disabled launchd labels.

[**Start: Complete installation guide**](docs/INSTALLATION.md) · [**All optimization options**](docs/OPTIMIZATIONS.md) · [**Debloat procedure**](docs/DEBLOAT.md) · [**Recovery**](docs/RECOVERY.md)

## Choose your profile

| Profile | SIP | Suitable for | State |
|---|---|---|---|
| **Clean** | Enabled | Everybody seeking a fresh, uncluttered system | Official processes documented; end-to-end testing pending |
| **Balanced** | Enabled | Users wanting selective Apple Intelligence/privacy/service changes | **Unvalidated** with current macOS 27.2 |
| **Experimental / SIP-off** | Disabled | Technically experienced users accepting weakened platform security | **Not a stable recommendation** |

> **Security note:** turning off System Integrity Protection reduces protections even against root-level tampering. SIP-off is an explicit experimental option, **not required** for a clean installation, better battery health or good gaming performance. Do not disable Gatekeeper, XProtect, FileVault or software updates to chase RAM numbers.

## One-page workflow

1. **Choose a stable, security-patched OS** using the [compatibility release gate](docs/COMPATIBILITY.md). Don't assume the newest or oldest macOS is automatically best.
2. **Back up twice** (Time Machine plus independent essential data). Verify you can restore files, and retain SSH keys/credentials securely.
3. **Capture a stock baseline** using the read-only shell script, then test sleep and light-use battery drain.
4. **Upgrade through Apple** if needed. Use Erase All Content and Settings for a fresh user state, or Apple Recovery for a real OS reinstall. The two procedures are not interchangeable.
5. **Start as new.** Keep FileVault, SIP, malware protection and updates on. Configure battery charging, login items, notifications, privacy, Finder, developer packages and browser habits.
6. **Measure again on stock OS.** Let indexing and iCloud settle; keep recorded tests comparable.
7. **Review optional debloating** via [RemoveMacAI](https://github.com/omlahore/RemoveMacAI) and [mac-os-debloat](https://github.com/OleksandrKrupko/mac-os-debloat). Inspect pinned source, dry-run, use a small custom preset, test each tool separately and verify rollback.
8. **Only experienced experimenters:** explicitly opt into SIP-off after reading its [risk model](docs/SECURITY.md), never via hidden one-click installer.
9. **Validate real gains and regressions**, publish measurements rather than guesses.

## Get the most useful docs

| Topic | Document |
|---|---|
| Official macOS version, backup, erase, reinstall, first boot | [Installation](docs/INSTALLATION.md) |
| Battery, UI, RAM, startup, developer environment, gaming, SSD | [Optimization matrix](docs/OPTIMIZATIONS.md) |
| Pinned upstream scripts, audit, optional SIP-off, restore | [Debloating](docs/DEBLOAT.md) |
| Which third-party utilities do what | [Tool comparison](docs/TOOLS.md) |
| What we need before recommending Golden Gate | [Compatibility](docs/COMPATIBILITY.md) |
| Controlled battery/sleep/performance trials | [Benchmarking](docs/BENCHMARKS.md) |
| Undo, Apple ID/charging fixes and Recovery | [Recovery](docs/RECOVERY.md) |
| Threat model for SIP-off and downloads | [Security](docs/SECURITY.md) |
| Apple, upstream, Reddit, and YouTube research | [Sources](docs/SOURCES.md) |
| Common questions, myths and cautions | [FAQ](docs/FAQ.md) |
| Current engineering status / promotion conditions | [PROJECT_STATUS.md](PROJECT_STATUS.md) |

## Available tools — no debloat actions

The repository currently provides **read-only local diagnostics** and a heuristic label auditor. No supplied script disables services, modifies macOS settings, installs packages, or turns off SIP.

~~~bash
git clone https://github.com/Wandersport/macOS-Lean.git
cd macOS-Lean
bash scripts/read-only-baseline.sh       # macOS only, creates local private report
bash scripts/smoke-check.sh              # macOS only, prints diagnostic state
python3 scripts/preset-audit.py file.txt # checks a proposed service list; never applies
~~~

On the research branch before merge, replace clone with the repository branch selector or checkout draft/v0.1-research. Audit output is **not** a safety certificate: a clean result does not prove labels are safe on your macOS build.

## Why this isn't '200 daemons = 20% faster'

macOS intentionally caches files in RAM; many services are lazy or wake on demand. Losing 1–2 GB reported used RAM may have no measurable effect if memory pressure was already low. On the fanless M4 Air, brightness, video decoding, browser activity, peripherals and background AI/Node tasks can dominate energy use. [Measure it](docs/BENCHMARKS.md).

**Project policy:** evidence before speed claims; documented rollback; preserve OS update/auth/charging services; no personal secrets or private system logs in GitHub. See [Contributing](CONTRIBUTING.md) and [Security](SECURITY.md).

**Third-party projects:** independent MIT-licensed upstream projects; macOS Lean is not affiliated with Apple or their maintainers. No upstream code is bundled. License: [MIT](LICENSE).

**Status:** public research guide, not a certified image or a warranty of improved performance.
