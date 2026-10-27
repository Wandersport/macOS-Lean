# macOS compatibility matrix and version gate

**Last researched:** 2026-10-27. Claims below are status snapshots; the tester has **not** run these combinations on the target M4 Air.

| Platform / product | Status | Evidence |
|---|---|---|
| macOS Golden Gate 27.2, build 26B123 | Official public release 2026-10-26; too new for confidence | [Apple security notes](https://support.apple.com/en-us/149521), [Apple developer releases](https://developer.apple.com/news/releases/?id=10052026f) |
| RemoveMacAI on Golden Gate 27.2 | **Not validated here**; maintainer documents primarily 27.0 and fixes for 27.0.1 | [README](https://github.com/omlahore/RemoveMacAI) |
| mac-os-debloat on Golden Gate 27 | Maintainer supports macOS 27 family; **not separately validated on 27.2 by this project** | [README](https://github.com/OleksandrKrupko/mac-os-debloat) |
| macOS Tahoe 26.4+ | Native 80%–100% Apple Silicon charging limit exists | [Apple](https://support.apple.com/en-ie/102338) |
| macOS Sequoia 15.x | Possible M4 factory OS; lacks native Tahoe 26.4 charge-limit controls | Verify Apple support + app compatibility |
| M4 Air 16/256 testing | **Not started** | [BENCHMARKS.md](BENCHMARKS.md) |

## When will Golden Gate be 'mature enough'?

Not by arbitrary calendar date or minor version alone. Require ALL:

- [ ] Public stable build and current security updates.
- [ ] No unresolved widespread M4 regression in sleep, display, Wi-Fi, battery, Finder/WindowServer or Terminal workflow.
- [ ] Every intended app works (browser, Spotify, Steam/Dolphin/Cemu if used, VPN, Git/CLI/Node/Python, coding agents).
- [ ] Both upstream projects explicitly support the particular **27.x build**, or a safe reviewed fallback excludes unsupported changes.
- [ ] Charge limit, charging state, Apple Account, App Store and Software Update pass stock and post-tweak smoke tests.
- [ ] Recovery and rollback procedures have been demonstrated.
- [ ] Real M4 baseline and post-debloat benchmarks are documented.
- [ ] Document known limitations, security downgrade and reproducibility.

## Promotion states

- **Research draft**: instructions based on documentation and upstream claims only.
- **Candidate**: static checks pass and tested on target hardware, but insufficient repetition.
- **Validated profile**: functional tests + rollback + repeatable measurements pass for a pinned OS/tool combination.
- **Stable guide**: independent reproduction and no unresolved critical regressions.

Neither an online star count nor a maintainer's 'works on macOS 27' statement by itself proves Golden Gate 27.2 support.
