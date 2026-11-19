# Extra-dim keyboard backlight + short idle timeout

This optional, non-destructive [macOS Keyboard Glow helper](../tools/keyboard-glow/README.md) combines two independent open-source tools. No SIP changes are necessary.

- [Lowlight](https://github.com/Isaac-Harper/lowlight): below-minimum physical keyboard brightness via a private CoreBrightness fade workaround.
- [mac-brightnessctl](https://github.com/rakalex/mac-brightnessctl): custom backlight idle timeout, including two seconds.

**Important:** Lowlight is reported to work on one M4 Air, and mac-brightnessctl readback confirms a 2-second setting. However, the below-minimum **brightness hold** and the **auto-off timer** might conflict. This combined behaviour is not yet established by physical idle testing.

## Install on your Mac

~~~bash
git clone https://github.com/Wandersport/macOS-Lean.git
cd macOS-Lean/tools/keyboard-glow
bash setup.sh
~~~

The installer prompts before trusting the exact Homebrew formula and does not trust the whole tap. After it opens Lowlight, select Steps Below Minimum → 20 and choose a low brightness. Then verify the keyboard actually switches off after two idle seconds while below minimum, on wake, and after reboot.

## Inspect and restore

~~~bash
bash status.sh
bash restore.sh
~~~

If your keyboard no longer obeys auto-off at the extreme low steps, test the timeout with Lowlight turned off before assuming hardware failure. See the [helper README](../tools/keyboard-glow/README.md) for troubleshooting, security, persistence limits, and credits. Readout of the timeout does not guarantee physical behaviour.

## Vorssaint

[Vorssaint issue #2920](https://github.com/vorssaint/vorssaint-utils/issues/2920) tracks ultra-low keyboard-backlight control. A proper feature should also consider a 2-second idle-off setting with native-state restoration and macOS-specific capability detection. The existing issue #3741 concerns **time-of-day scheduling**, which is different from idle timeout.
