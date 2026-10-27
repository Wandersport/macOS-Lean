# Recovery and rollback playbook

Read this **before** disabling Apple background services or SIP. Validate the applicable actions on your own machine and OS; the third-party tools may change interfaces in later releases.

## If an app or Apple service stops working

1. Identify the most recent change and its exact source/version. Do not stack additional optimizers on top.
2. Check Activity Monitor and macOS settings; confirm the problem occurs after reboot.
3. If RemoveMacAI caused a tracked change, use its UI 'Undo Everything' or the documented CLI:

~~~bash
removemacai revert
~~~

4. If mac-os-debloat changes caused it, run the **same pinned version** and inspect:

~~~bash
python3 debloat-reviewed.py --status
python3 debloat-reviewed.py --restore
~~~

5. The upstream --enable-all re-enables its whole catalog, so it is **not identical** to restoring previously recorded state.
6. Review third-party background daemon persistence and configuration profiles. Follow the tool's official uninstall method; do not randomly delete /Library/LaunchDaemons entries.
7. Reboot, verify Software Update, Apple Account, Wi-Fi, Bluetooth, VPN, Spotlight, battery charging, sleep and critical apps.

## If the 80% charging limit stops working

The upstream mac-os-debloat project has documented failures after disabling two services. Restore them in the tool's own interface as appropriate:

- com.apple.perfpowermetricd
- com.apple.powerlogHelperd

Then restart and verify the macOS charge-limit setting and reported charging behavior. This isn't a reason to run high discharge/recharge cycles as a test.

## If Apple ID login fails

Check the upstream known issue regarding com.apple.Siri.agent, restore that service if it was disabled, reboot and retest. Account services can be interconnected even when Siri appears unused.

## If Command-Space breaks on macOS 27

Upstream reports com.apple.campo may affect the macOS 27 launcher. Restore it if suppressed. Command-Space behavior should also be tested before classifying a profile as working.

## If SIP was disabled

Restore all relevant debloat service overrides first, then boot into Apple Silicon Recovery and re-enable SIP:

~~~bash
csrutil enable
~~~

Reboot and run:

~~~bash
csrutil status
~~~

Re-enabling SIP does not automatically repair altered LaunchDaemons, configuration profiles, deleted files or a corrupt data volume.

## If macOS will not update or boot

- Use **official Apple Recovery** and documented reinstall procedures. Do not execute anonymous 'fix Apple updater' shell scripts.
- Before erase, inspect which version Recovery offers and preserve data/backups.
- A reinstall may not erase user files, while Erase All Content and Settings does erase them but keeps the current OS.
- If the device remains unbootable, seek Apple support or an authorized service provider; do not attempt DFU firmware restoration without understanding data-loss consequences.

Apple: https://support.apple.com/en-us/102518

## Post-incident report

Record date, macOS build, hardware model, profile, upstream revision, SIP status, exact regression and recovery outcome. Remove serials, real user accounts, private paths, Wi-Fi details and logs before publicly filing an issue.
