#!/usr/bin/env bash
# Read-only status.
set -u
if [[ "$(uname -s)" != Darwin ]]; then
  printf 'macOS only.\n' >&2; exit 2
fi
printf '%s\n' '== Keyboard Glow status =='
if command -v mac-brightnessctl >/dev/null 2>&1; then
  mac-brightnessctl -t
  mac-brightnessctl -s
  mac-brightnessctl -a
else
  printf 'mac-brightnessctl not in PATH.\n'
fi
if [[ -d /Applications/Lowlight.app ]]; then
  printf 'Lowlight.app installed.\n'
else
  printf 'Lowlight.app not found in /Applications.\n'
fi
if pgrep -x Lowlight >/dev/null 2>&1; then
  printf 'Lowlight running.\n'
else
  printf 'Lowlight not currently running.\n'
fi
if [[ -f "$HOME/Library/Application Support/macOS-Keyboard-Glow/previous-settings.txt" ]]; then
  printf 'First-run settings backup found.\n'
else
  printf 'No first-run settings backup found.\n'
fi
printf 'Manually test below-minimum brightness and physical 2-second auto-off.\n'
