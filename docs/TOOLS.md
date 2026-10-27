# Tool selection and audit register

**Never combine tools blindly.** RemoveMacAI focuses on Apple Intelligence/privacy/UI toggles and cleanup. mac-os-debloat focuses on launchd labels and boot persistence. Both can overlap on AI functionality.

| Approach | SIP necessary? | Reversibility | Recommended use |
|---|---|---|---|
| Native System Settings | No | Manual revert | First-line optimization |
| RemoveMacAI | No | Upstream revert/undo journal for settings; some deletions irreversible | Optional selective review |
| mac-os-debloat telemetry | No; reduced scope on SIP-on | Upstream --restore with caveats | Research-only until tested |
| mac-os-debloat balanced | No, but SIP-off unlocks more labels | Upstream --restore / service re-enable | Custom reviewed subset, not blanket |
| mac-os-debloat disable-all | Some labels require SIP off | Risk of wide regression | Not recommended |
| AlDente or batt charge limiter | Not needed on Tahoe 26.4+ for simple 80% cap | App-dependent | Only if special charging behavior required |
| CleanMyMac/other 'cleaners' | No automatic justification | Product-dependent | Avoid replacing targeted diagnosis with blind cleanup |
| OnyX | No for ordinary settings; some maintenance tasks may need authorization | Task-dependent | Advanced troubleshooting, not default optimization |

### Frozen upstream research references

- RemoveMacAI: 053f86a4f767e8fbbf9f3538805ab8674262474e, checked 2026-10-27.
- mac-os-debloat: 1f3b1c82ddb12c0e333310c0d6c675f792320d12, checked 2026-10-27.

These are **reference snapshots, not approved or security-audited releases**. Updating either upstream reference requires re-auditing behavior and running the validation matrix. Do not automatically track main in an install script.

### Exact operation classes

- **Read-only:** status, audit, enumerate files, inspect battery and power, metadata.
- **Preference modification:** Finder/Dock settings, analytics opt-outs, profiles. Restorable if journaled.
- **Service alteration:** launchctl disable, boot helpers; boot/update behavior must be tested.
- **Storage deletion:** snapshots, game files, Xcode data, models; requires specific backup/undo semantics.
- **Security alteration:** SIP/SSV/Gatekeeper/AMFI changes. This project documents SIP-off only as a conscious experimental exception and does not bundle automatic commands to do it.

### What 'best' would mean

Best for one user could mean 8h more battery, or preserving AirDrop and iPhone integration, or freeing disk space. There is no universal setting. Document your own features required and choose the smallest reviewed set of changes that delivers a measurable benefit.

Official alternative to unnecessary third-party battery charging utilities: https://support.apple.com/en-ie/102338
