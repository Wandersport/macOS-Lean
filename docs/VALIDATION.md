# Validation entrypoint

The authoritative current benchmark protocol is [BENCHMARKS.md](BENCHMARKS.md). Current OS readiness is [COMPATIBILITY.md](COMPATIBILITY.md).

**As of 2026-10-27: no verified A/B results or SIP-off hardware validation.**

Before publishing a stable setup, require:
- [ ] Exact macOS version/build and upstream Git SHAs pinned.
- [ ] Apple Silicon M4 installation, hardware and update tests pass.
- [ ] Three repeated tests per battery, sleep and responsiveness workload; stock and after changes, same macOS build.
- [ ] Native 80% charge limit demonstrably functions across restart.
- [ ] Apple Account, App Store, Find My, Software Update, Spotlight, AirDrop, Wi-Fi, Bluetooth, audio, camera, VPN, Time Machine and USB-C pass.
- [ ] Tool rollback and SIP-on restoration pass.
- [ ] At least one independent reproduction before broad stable claim.

Publishing a draft with clear warnings is permitted; it is not a stable installation endorsement.
