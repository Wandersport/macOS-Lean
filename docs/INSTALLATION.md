# macOS Lean — clean installation and first boot

**Status: research draft.** Tested procedure *references* are from Apple. The end-to-end recipe has not yet been trialled on macOS Golden Gate 27.2 and the MacBook Air M4. Nothing in this repository should erase a machine automatically.

## 0. Choose an OS deliberately

- **Current baseline:** the latest stable, security-patched macOS that is working correctly on your hardware.
- **Target:** a Golden Gate 27.x version only after the [compatibility gate](COMPATIBILITY.md) is satisfied. As of 27 October 2026, Golden Gate 27.2 (26B123) is only a day old.
- **Do not claim an objectively "best version ever".** A version ranking must use same-machine measurements, compatible app versions, reproducible tests and security-update status.
- **Do not downgrade casually.** Check the oldest OS officially supported by the model, backup/format constraints, firmware, data migration and availability of official installers. Older macOS versions may lose security coverage or the native Apple Silicon battery charge limit introduced in Tahoe 26.4.

## 1. Preflight: two verified backups

- Connect power and stable networking. Reserve at least 50 GB free working space if possible; large OS downloads and developer tools may require more.
- Complete Time Machine backup on an external drive; check when it finished, mount it, restore a test file and open it.
- Create a *separate*, independently readable copy of critical documents and projects (not simply another folder on the same SSD). Do not publish any backup to GitHub.
- Export the list of installed apps and packages. Record Homebrew formulae and casks (brew bundle dump --describe can create a Brewfile, **review and redact it** before sharing).
- Preserve password-manager access, SSH/GPG keys, 2FA recovery, VPN configs and work repositories in encrypted storage. Do not copy secrets to a public repo.
- Export browser bookmarks if sync is disabled; save local-only Steam/Cemu/game saves and university documents.
- Confirm Apple Account password, Find My/Activation Lock status, and Apple support/repair case identifiers; save repair evidence **outside** the Mac.
- Disconnect unnecessary external disks before erase. Record which storage volume you intend to wipe.
- Check System Settings > General > Device Management for work/school enrollment. An erase does not remove legitimate MDM ownership.

## 2. Capture stock baseline *before erasing*

Run the repository's read-only snapshot, inspect its output, and keep it private:

~~~bash
bash scripts/read-only-baseline.sh
~~~

Run the benchmarks described in [BENCHMARKS.md](BENCHMARKS.md). Note OS build, battery health and cycle count, charger, native charge limit, room temperature, brightness, Energy tab, Activity Monitor memory pressure, swap and sleep-drain data. The tools do not record real-world numbers on your behalf.

## 3A. Recommended: official upgrade + Erase All Content and Settings

1. Confirm your target OS is officially supported on the device and upgrade using **System Settings > General > Software Update**.
2. Finish the upgrade; confirm the build and verify Wi-Fi, sound, battery and Apple Account before reset.
3. Go to **System Settings > General > Transfer or Reset > Erase All Content and Settings**.
4. Read the erase summary, verify your backups and follow Apple's sign-out/erase process.
5. At Setup Assistant, choose **Set up as new**, not a blanket migration of old caches, launch agents or configuration profiles.
6. Reconnect your Apple Account, configure FileVault and Find My, and install all current security/rapid-response updates.
7. Restore selective data, not your entire old Library. Reinstall applications from trusted sources.
8. Let Spotlight indexing, Photos processing and cloud sync finish before evaluating idle energy use.

**Important:** Erase All Content and Settings **preserves the installed operating system**. It is a secure user-state reset, not a clean installation of new macOS binaries. For an OS reinstall use Apple's Recovery instructions.

Apple: https://support.apple.com/es-es/102664

## 3B. Advanced: Recovery-based macOS reinstall

Use this only when an actual OS reinstall is needed. On Apple Silicon, start from a powered-off Mac and **press and hold the power button until Startup Options appear**, then use Options/Recovery. Choose **Reinstall macOS** through the official Recovery interface, and verify the offered version before proceeding. A reinstall on its own can preserve user data; deliberately erasing the internal storage is a separate destructive step.

If deliberately erasing storage, follow Apple's exact Disk Utility instructions for the chosen model and APFS volume group. Do not improvise deletion of hidden APFS volumes or firmware partitions. If making a bootable USB installer, use Apple's official download and createinstallmedia process. Do not use unofficial macOS ISO/DMG downloads.

Apple: https://support.apple.com/en-us/102518 and https://support.apple.com/en-us/102662 and https://support.apple.com/en-ie/101578

## 4. First-boot settings

### Security and account
- FileVault **on**; keep the recovery key secure.
- SIP **on** for Clean and Balanced; Gatekeeper, XProtect and other Apple security services **on**.
- Find My **on** unless your use case requires otherwise.
- Automatic security updates **on**. Don't disable update services in pursuit of debloating.
- Remove unused sharing services under System Settings > General > Sharing, but do not confuse Apple RemoteManagementAgent process names with evidence of device enrollment.

### Power
- On supported Apple Silicon releases, native 80% charge limit and Optimized Battery Charging **on** for mainly desk use. Use 100% when a day away from power requires it.
- Low Power Mode **only on battery** for light work if performance is adequate.
- Wake for network access **Never** if network wake is unnecessary; a setting should be tested rather than assumed present in every macOS release.
- Display off after 3–5 minutes while on battery, brightness comfortable indoors, stop unwanted background audio/video.
- Closing the lid invokes sleep in ordinary portable use; don't conflate pressing Touch ID to lock with sleeping.
- Ensure the case is ventilated; avoid putting the Mac in a bag while heat-producing workloads are still active.

Apple battery information: https://support.apple.com/es-es/102338

### Productivity & clean desktop
- Finder > View: Show Path Bar, Show Status Bar. Finder > Settings: Show all file extensions if useful.
- Dock: disable recently used apps if unwanted; set icon size, magnification and auto-hide by preference.
- Review notifications, Focus, desktop widgets, dynamic wallpaper and automatic app opening.
- Trackpad: choose gestures and natural scrolling to suit your use; there is no confirmed major battery saving from reversing a gesture.
- Use native app versions for Apple Silicon where possible; consider Safari as a measured low-power browser option instead of a guaranteed winner under all workloads.

### Applications
- Install only what you use. Review System Settings > General > Login Items & Extensions regularly.
- For developer workloads: Xcode Command Line Tools only if required, Homebrew with a curated Brewfile, and pin necessary CLI tools where reproducibility matters.
- Do not install blanket "RAM cleaners", task killers or unverified kernel extensions.
- Keep VPN helper components enabled only while their associated VPN actually needs them. Uninstall unused apps with their official uninstaller and verify leftovers before touching /Library.

## 5. Storage hygiene

System Data is a category, **not** a single macOS directory. Steam games, Stremio video cache, Spotify cache, browser profiles, container data, SDKs, logs and local snapshots can be classified there. Inspect before deletion:

~~~bash
du -xhd 1 "$HOME" 2>/dev/null | sort -h
du -sh "$HOME/Library/Application Support/"* 2>/dev/null | sort -h | tail -25
du -sh "$HOME/Library/Caches/"* 2>/dev/null | sort -h | tail -25
tmutil listlocalsnapshots /
df -h /
~~~

Use the **app's own storage management/uninstaller** for games, VMs and IDEs. Quit apps before cache cleanup. Do not delete random data under /System, /private or /Library, or purge Time Machine snapshots merely because they appear large.

## 6. Checkpoint before debloating

Run at least a day of normal work on stock macOS, ensure charge limiting and lid sleep work and get a baseline. Only then proceed to [DEBLOAT.md](DEBLOAT.md). If the Mac is already responsive and efficient, further debloating can produce zero measurable gain.
