# Controlled benchmarks: performance, battery, and storage

The objective is **proof**, not a screenshot showing fewer processes. Never claim an optimization improves battery life without a same-device, same-build comparison.

## A/B design

A = factory stock; B = selected macOS preference changes; C = audited RemoveMacAI subset (SIP on); D = custom balanced launchd preset (SIP on); E = experimental custom balanced + SIP off. **Change one variable at a time**. Revert and return to baseline between different debloating tools, or record combined setups separately.

**Record**: Mac model, macOS complete build number, chip, RAM, SSD, battery cycles/health, display brightness (physical setting), refresh rate, ambient temperature, charger state, Low Power Mode, charge limit, VPN status, Wi-Fi network, connected peripherals, browser and website set, selected tweaks and exact upstream Git commit. Document which macOS background tasks were still indexing.

## Tests and measurements

| Test | Procedure | Primary result | Controls |
|---|---|---|---|
| Browser endurance | 120 min repeatable local/offline browsing with scripted or fixed pages and scroll patterns | battery percentage points/hour | same browser/version, brightness and network |
| Coding | 120 min realistic editor/CLI task | percentage points/hour and CPU | same repo state, same task and tool versions |
| Idle plugged in | 30 min after 20 min warmup | median CPU, memory pressure, swap, power reporting | no indexing/downloads |
| Sleep | 8 hours with lid closed and no external devices | battery percentage points lost | same Wi-Fi/standby and wake network settings |
| Responsiveness | cold app start and repeated Spotlight/Finder interactions | median elapsed time | identical apps/data, warmed/cold distinguished |
| Storage | df and du breakdowns before/after | actually reclaimable user-facing GiB | separate caches from system/APFS snapshots |
| Startup | restart and time to usable desktop | seconds | no background setup |
| Stability | multi-day ordinary work | crash/thermal/feature regressions | record failures, not just success |

Repeat independent battery tests at least **three times**. Start each discharge test with similar battery percentage, e.g. 80% to ~65%; compare in **percentage points per hour**, avoid comparing a 2-minute test to a 2-hour test. Report median, range, and rough uncertainty; battery capacity is an estimate, not a power meter.

For cross-version claims, compare the same machine on stable system versions, but disclose firmware changes and the impossibility of perfect isolation. Don't conflate differences between macOS 26 and 27 with differences introduced by a debloat script.

## Example result template (fill only with observed numbers)

| Metric | Stock | Balanced SIP-on | Experimental SIP-off | Change | Notes |
|---|---:|---:|---:|---:|---|
| Battery pp/hour | TBD | TBD | TBD | TBD | Three controlled 2h runs |
| Sleep drain pp/8h | TBD | TBD | TBD | TBD | Three nights |
| App open latency (s) | TBD | TBD | TBD | TBD | 10 repeats |
| Memory pressure | TBD | TBD | TBD | TBD | Read Activity Monitor |
| Swap usage (GiB) | TBD | TBD | TBD | TBD | Observe not optimize for zero |
| Reclaimable SSD (GiB) | TBD | TBD | TBD | TBD | Distinguish app caches |
| Functional regression count | TBD | TBD | TBD | TBD | Link issue reports |

## Interpret responsibly

- High used RAM is not inherently bad: macOS uses spare RAM as file cache. Use **memory pressure and swap activity** alongside real-world app performance.
- Battery wear from a small number of cycles isn't validated by a few changes in macOS maximum-capacity estimates.
- MacBook Air M4 is passively cooled. Sustained CPU and enclosure temperature can influence throttling and benchmark variance.
- Light browsing battery gains on Safari vs Firefox are workload- and extension-dependent.
- A charge limit is a battery longevity policy, not proof of higher runtime while disconnected.
- A faster benchmark with SIP off must be weighed against documented security losses.

## Acceptance gate

A profile is publishable as a stable recommendation only if (1) hardware critical paths remain functional, (2) rollback succeeds and survives reboot, (3) benchmark results demonstrate at least a meaningful reproducible gain or a clear privacy preference without claiming performance, and (4) the exact OS build and upstream tool revision are pinned. Any critical Apple Account, OS update, sleep, charging or security regression blocks promotion.
