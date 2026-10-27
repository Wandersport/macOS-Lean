# macOS Lean — project status

**Edition:** v0.2 research documentation, 27 October 2026.

- GitHub: https://github.com/Wandersport/macOS-Lean
- Target test device: Apple MacBook Air M4, 16 GB RAM / 256 GB internal SSD.
- Candidate OS: macOS Golden Gate 27.2 (26B123, 2026-10-26), **not promoted**.
- Other possible comparison: a currently supported Tahoe 26.x build as a stock reference.
- RemoveMacAI source reviewed: 053f86a4f767e8fbbf9f3538805ab8674262474e.
- mac-os-debloat source reviewed: 1f3b1c82ddb12c0e333310c0d6c675f792320d12.
- Hardware clean install: **not performed**.
- Hardware system tweaks: **not performed**.
- Controlled battery/performance trials: **not performed**.
- SIP-off: **experimental only**, not a stable default or measured gain.
- CI: read-only/static tests; run status must be checked before claims.
- Production release: **not ready**.

## Remaining work that cannot be completed solely in GitHub

Conduct on-device stock OS benchmarking, verify exact Golden Gate compatibility, independently inspect reviewed script changes, choose intentional service exclusions, test update/reboot/rollback, and reproduce benchmark improvements. Do not simulate measurements or silently mark checkboxes complete.

## Published documentation scope

README, installation, all optimizations, debloat audit, security, tools, compatibility, benchmarks, recovery, FAQ, sources, contributor/security policy, MIT license, read-only shell scripts, Python label audit with unit tests, GitHub Actions static checks.

Opening or merging the documentation does not authorize changing any user's Mac.
