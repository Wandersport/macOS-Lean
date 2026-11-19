# macOS Keyboard Glow — below-minimum brightness + 2-second timeout

A **small, transparent wrapper** around two independent macOS utilities. It is **not** a fork or redistribution of either app.

- **Lowlight**: sets the built-in keyboard's backlight below the normal macOS brightness minimum, using an optional menu-bar interface. Source: https://github.com/Isaac-Harper/lowlight
- **mac-brightnessctl**: configures a custom inactivity timeout for the built-in keyboard backlight. Source: https://github.com/rakalex/mac-brightnessctl

**Validation status:** A MacBook Air M4 user reports that Lowlight's ultra-low setting works and the mac-brightnessctl timeout setting reads back as **2.00 seconds**. We have **not confirmed** that the keyboard actually goes dark after two seconds **while Lowlight is holding below-minimum brightness**. The two components use Apple's private CoreBrightness interfaces and may conflict. Don't market this wrapper as a guaranteed fix.

## Quick setup

Requirements: Apple Silicon MacBook, a Lowlight-compatible macOS release (upstream requires macOS 26), Homebrew installed. SIP can remain enabled.

For the version currently hosted in macOS Lean:

~~~bash
git clone https://github.com/Wandersport/macOS-Lean.git
cd macOS-Lean/tools/keyboard-glow
bash setup.sh
~~~

Review the shell script before running. It asks for consent before trusting **one exact Homebrew formula**, rather than trusting an entire third-party tap. It then installs both utilities, saves the original keyboard timeout and idle-dimming state on first run, sets the timeout to two seconds and opens Lowlight.

After Lowlight opens, select **Steps Below Minimum → 20** from its moon menu-bar icon, then choose a faint visible step. There is no supported CLI to choose its ultra-low step from this installer.

To check the software settings:

~~~bash
bash status.sh
~~~

The core timeout commands used by setup.sh are:

~~~bash
mac-brightnessctl -s 0
mac-brightnessctl -t 2
mac-brightnessctl -t
~~~

The -s 0 command enables idle-dimming behaviour (it cancels suspension). It does not itself turn the backlight off.

## Test that BOTH functions work together

1. Set Lowlight below the macOS minimum, but keep the letters faintly visible.
2. Type, remove your hands from keyboard and trackpad, and observe the backlight.
3. Check whether the lights physically go dark after approximately two seconds.
4. Start typing again and check that the below-minimum setting returns.
5. Repeat 3 times, and after sleep/wake and logout/login.

**A readback of 2.00 seconds is not proof** that the physical keyboard turns off on time. If the countdown is ignored only at Lowlight's extra-dim setting, return to normal brightness for a control test and record the macOS build. Do not disable SIP to fix this.

## Rollback and caveats

~~~bash
bash restore.sh
~~~

The first setup run saves the then-current values in a private local file:

    ~/Library/Application Support/macOS-Keyboard-Glow/previous-settings.txt

Re-running setup preserves that initial saved state. If you've **already** configured a 2-second timeout before running this wrapper, the saved 'previous' value may also be 2 seconds. The restore script will not guess an older value or erase user data.

Quit Lowlight from its menu to return to normal Apple keyboard backlight control. Optional package removal after restore:

~~~bash
brew uninstall --cask lowlight
brew uninstall mac-brightnessctl
~~~

No LaunchAgent, root service, background daemon, or system modification is installed by our scripts. The 2-second property may not survive a reboot or macOS update; verify it before assuming persistent behaviour. We intentionally don't auto-install a login helper until longevity/compatibility has been tested.

## Separate repository

The contents of this folder are self-contained and may be published separately as **Wandersport/macOS-Keyboard-Glow**. The connected GitHub integration currently cannot create a new repository; use **publish-standalone.sh** from a Mac that has the GitHub CLI authenticated, or create a new blank repository via GitHub and push the folder.

The publish script copies only this directory to a temporary Git working tree and asks for permission before creating a **public** GitHub repository. It does not publish macOS Lean's entire repository.

## Vorssaint request

The independent [Vorssaint](https://github.com/vorssaint/vorssaint-utils) app has an existing request [#2920: ultra-low keyboard backlight](https://github.com/vorssaint/vorssaint-utils/issues/2920). Integrating a selectable sub-minimum brightness and an **idle** timeout (e.g. 2 seconds) would require first-party Swift implementation, lifecycle handling, supported-device detection, UI and regression testing. Idle inactivity is not the same as scheduled clock-time lighting requested in issue #3741.

This wrapper is **not** a Vorssaint PR or integration, and we cannot write directly to their main branch.

## Trust and credits

- Our scripts are MIT-licensed (see LICENSE).
- Each dependency retains its own copyright and license. Check its official repo and current release before installing.
- Homebrew trust allows formula installation code to run; it is not an independent source audit.
- Both upstream projects rely on private Apple APIs that may change across macOS versions.
- No SIP-off, no System Volume modifications, no remote curl-pipe-to-shell.
