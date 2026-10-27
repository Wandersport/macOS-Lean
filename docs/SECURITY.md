# Security and privacy model

## Why a 'lighter' Mac can be *less* reliable

A launchd service may serve more than the name suggests. Suppressing one subsystem can affect login, app installation, updates, hardware charging, power-management diagnostics, shared frameworks, account recovery or security checks. With SIP disabled, a malicious process running as root can make modifications that SIP would ordinarily prevent.

macOS has *different* layers: SIP, Signed System Volume, Gatekeeper, XProtect, FileVault, TCC privacy permissions, Apple Silicon startup security and hardware-protected components. They are not interchangeable. **Do not disable additional layers because a tutorial says "maximum debloat."**

Apple reference: https://support.apple.com/en-ca/guide/security/secb7ea06b49/web

## Profile threat model

**Clean (public default):** SIP + FileVault + Gatekeeper + XProtect enabled. Low risk, maximal vendor-supported compatibility.

**Balanced (selective, public only after testing):** SIP enabled; Apple features disabled by preference or config profile and/or a restricted launchd preset. Privacy/user-experience trade-offs, possible unexpected app and update effects, plus third-party app/code supply-chain risk.

**Experimental SIP-off:** local kernel/system integrity protections are weakened. Bad scripts and root-level malware have more power. Recovery may be required to restore. Some iPhone/iPad apps on Apple Silicon Macs may stop working when reduced system security is selected (according to upstream), and other restrictions vary. No promise of battery or gaming performance gains.

## Rules for this repository

1. No one-click installer that automatically disables SIP, kernel protections or updates.
2. No curl | bash and curl | python3 pattern in *recommended* instructions. Fetch version-pinned source, audit it, verify the publisher, then execute deliberately.
3. Every change must have reason, before/after state, known feature losses, rollback path and macOS build.
4. An allowlist of required functions is more useful than a blanket count of disabled jobs.
5. Do not disable Apple software updates, identity/security/signing, Find My, power charging components or essential display/input/network functionality.
6. Preserve independent offline backups of critical material before destructive actions.
7. No automated file deletion without an explicit preview. An undo of a preference cannot restore deleted user content.
8. No repo commits of tokens, private keys, browser profiles, personal battery logs, serial numbers or Apple support case identifiers.
9. Do not assume a popular public GitHub repo is secure; review commits/releases and use locked revisions.
10. On a shared/family/corporate Mac, SIP-off and root launchd changes affect more than one user. Respect device management policy.

## Supply-chain review checklist

- Inspect install scripts for arbitrary remote downloads, code execution, sudo writes, profiles, LaunchDaemons, launchctl and osascript.
- Check upstream's LICENSE and THIRD-PARTY-NOTICES before copying code; this repository links to upstream rather than vendoring it.
- Record upstream commit SHA, local SHA-256 and date. A local hash alone doesn't verify authorship.
- Evaluate update behavior and launchd persistence, especially on SIP-on systems.
- Maintain an actionable uninstaller/recovery procedure separate from the installer itself.
- Gate CI to static checks and read-only tests; never run system-mutating optimizers in GitHub Actions.

## Responsible claims

It is appropriate to say 'disables 188 catalog labels according to upstream at commit X', or 'one tester measured N GiB lower reported RAM usage'. It is **not** appropriate to say 'guaranteed extra hours of battery' or 'Apple Intelligence is spyware' without independent evidence.

Report suspected security defects privately to the repo maintainer before publishing exploit details.
