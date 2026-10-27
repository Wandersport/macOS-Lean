# macOS Lean — debloat methods and guarded execution

**Not certified on Golden Gate 27.2. No automatic service disabling is shipped here.** Applying both upstream projects together can overlap, break OS features, or make blame/rollback ambiguous.

## What these tools actually do (source: upstream authors)

### RemoveMacAI
Repository: https://github.com/omlahore/RemoveMacAI

Native Apple Silicon app and CLI. Turns off selected Apple Intelligence features, removes relevant model assets through Apple's asset service, can disable analytics/personalized ads, change Finder/Dock preferences, inspect third-party background items and clean storage. A configuration profile is involved for locked settings. The author reports SIP **stays enabled** and provides reversible changes with an undo journal. Some storage removals, such as simulator deletion or Time Machine snapshot deletion, are not equivalent to undoing a settings preference.

Current Git revision **inspected for research, not approved**: 053f86a4f767e8fbbf9f3538805ab8674262474e (2026-10-26). Test support is predominantly 27.0 and selected fixes thereafter; **27.2 compatibility remains unproven here**.

### mac-os-debloat
Repository: https://github.com/OleksandrKrupko/mac-os-debloat

Python console that uses launchctl to manage a catalog of Apple services and supplies telemetry, balanced, and disable-all choices. Source at the inspected revision documents **307 catalog labels, 188 balanced labels** before runtime platform filtering, including Siri, Apple Intelligence, iMessage, FaceTime and Continuity. The author reports approximately 1.5–2 GB less used RAM under one M4 configuration; this is **not** a measured battery gain or controlled cross-machine result.

Inspected Git revision: 1f3b1c82ddb12c0e333310c0d6c675f792320d12 (2026-10-12). Git revisions change; never assume these numbers or labels will remain fixed.

### SIP distinction
With SIP on, a subset of labels are supported for persistent disabling; the project currently documents a boot helper to reapply disable states on SIP-on systems. With SIP off, many more system labels can be suppressed persistently, with a real reduction of system integrity protections. Neither SIP-off nor a smaller process list is a performance benchmark.

The developer documents a serious charge-limiting regression from disabling com.apple.perfpowermetricd and com.apple.powerlogHelperd, and an Apple Account sign-in issue associated with com.apple.Siri.agent on some Tahoe systems. The balanced catalog is **not** an empty list of side effects.

## Recommended progression

### Level 0 — native settings only
Keep SIP on. Disable unwanted Apple Intelligence *in the supported macOS settings*, Spotlight **web suggestions** (not local indexing), analytics, unnecessary login items, widgets and startup services. Verify what your macOS version actually exposes.

### Level 1 — RemoveMacAI review
After backing up, download only from the [official releases](https://github.com/omlahore/RemoveMacAI/releases) and verify release signature/checksums where published. Inspect its interface. To use a reviewed CLI installed according to its current documentation, start read-only:

~~~bash
removemacai status
removemacai tweaks
~~~

Its README documents --dry-run on applicable modifying commands. Select individual changes and **document what was selected** rather than automatically taking every preset. Do **not** choose cleanup of snapshots, Xcode data or caches without understanding irreversibility.

Undo of its tracked modifications (as documented by upstream):

~~~bash
removemacai revert
~~~

Verify the configuration profile was removed and the Apple features you want have recovered. Undo can't magically restore files permanently deleted outside Trash.

### Level 2 — mac-os-debloat audit (SIP on initially)
Prefer downloading a specific reviewed upstream revision instead of piping an unknown future version into Python. At the revision above:

~~~bash
curl -fL --proto '=https' --tlsv1.2 \
  https://raw.githubusercontent.com/OleksandrKrupko/mac-os-debloat/1f3b1c82ddb12c0e333310c0d6c675f792320d12/debloat \
  -o debloat-reviewed.py
shasum -a 256 debloat-reviewed.py
python3 debloat-reviewed.py --help
python3 debloat-reviewed.py --audit
python3 debloat-reviewed.py --preset balanced --dry-run
~~~

**Review the downloaded code yourself or with a competent auditor.** Pinning fixes a version; it does **not** establish trustworthiness. The hash shown locally is for your audit record; it is not independently authenticated by the same download server.

The balanced selection disables services that may matter, including Apple Intelligence, Siri, iMessage, FaceTime and Continuity. The exact label list must be reviewed for your macOS build. A safer method is a **custom preset** derived from the current balanced list while retaining needed features. The upstream documentation describes:

~~~bash
python3 debloat-reviewed.py --list --preset balanced > balanced-review.txt
# Edit balanced-review.txt and REMOVE every label needed by your workflow.
python3 scripts/preset-audit.py balanced-review.txt
mkdir -p "$HOME/.mac-os-debloat/presets"
cp balanced-review.txt "$HOME/.mac-os-debloat/presets/macos-lean-review.txt"
python3 debloat-reviewed.py --preset macos-lean-review --dry-run
~~~

**This stops at dry-run intentionally.** The resulting profile is not automatically certified or applied. Only apply it once the current implementation has been audited, [tests](BENCHMARKS.md) have a baseline, and there is a verified way to restore the exact disabled labels. The repo's preset-audit script is **a warning tool, not a guarantee of safety**.

To inspect system state or undo through the same pinned upstream executable, its README documents:

~~~bash
python3 debloat-reviewed.py --status
python3 debloat-reviewed.py --restore
# --enable-all is broader than --restore; it enables all catalog services
~~~

An upstream installer may add a boot reapply daemon when SIP is on. Inspect whether the installed component is removed after --restore / --enable-all. Confirm the result after reboot. If the pinned script's options or persistence differ from this guide, **stop**, don't guess.

### Level 3 — Experimental SIP disabled

**Not the public default.** SIP protects macOS system files and important runtime policy from even root-level processes. On Apple Silicon, changing startup security settings requires explicit owner authentication and may require the Recovery environment. Turning SIP off increases the potential damage from malware or from a malicious sudo command, and can affect iOS/iPadOS app behavior on Mac.

Use only on a backed-up machine with a full recovery plan and an explicit acceptance that weakened security may exceed any RAM savings. If Apple Silicon Recovery permits it, the usual Recovery Terminal command is:

~~~bash
csrutil disable
~~~

Restart and verify in normal macOS:

~~~bash
csrutil status
~~~

Do not disable Signed System Volume protection, Gatekeeper, XProtect, FileVault or software updates as an additional "speed boost". SIP-off should **never be hidden** in an installer or automatic preset. For reversal, first restore the changed services and reboot; then return to Recovery and re-enable SIP using:

~~~bash
csrutil enable
~~~

After another restart verify state, Apple Account, charge limit, Software Update, Spotlight, camera, VPN, sleep and your core apps. SIP re-enable does **not** necessarily undo service overrides automatically.

## Never disable without thorough separate evidence

System/application UI: Finder, Dock, WindowServer, SystemUIServer, Control Center, Notification Center.

Security/auth/updates: securityd, trustd, syspolicyd, XProtect, softwareupdated, Apple Account/SSO and Find My dependencies.

Power: powerlogHelperd, perfpowermetricd, battery-related SMC/power management, sleep-wake/power assertions. These should be protected in all published presets.

Workflow-specific: Spotlight index, camera and microphones, Time Machine, USB/Thunderbolt, iCloud Drive/Keychain, AirDrop/Sidecar/AirPlay, Wi-Fi/Bluetooth, VPN networking. Some are inside balanced presets: **make an explicit opt-in exclusion decision**.

## Before a macOS update

1. Save snapshots of the current debloat state, tool revisions, modifications and personal data.
2. Undo RemoveMacAI, restore mac-os-debloat changes/boot helpers, and re-enable SIP when possible.
3. Install the official patch, verify it actually completes and retains security settings.
4. Rerun stock smoke tests and build a new macOS-specific profile only if supported.

If an OS update is blocked, don't attempt random patches: use [RECOVERY.md](RECOVERY.md).
