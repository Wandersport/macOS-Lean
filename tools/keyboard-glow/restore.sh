#!/usr/bin/env bash
# Restore saved timeout and idle dimming. No app uninstallation or service changes.
set -euo pipefail
if [[ "$(uname -s)" != Darwin ]]; then echo 'macOS only' >&2; exit 2; fi
if ! command -v mac-brightnessctl >/dev/null 2>&1; then
  echo 'mac-brightnessctl missing; cannot restore.' >&2; exit 2
fi
file="$HOME/Library/Application Support/macOS-Keyboard-Glow/previous-settings.txt"
if [[ ! -f "$file" ]]; then
  echo 'No saved first-run settings; refusing to guess original values.' >&2
  exit 2
fi
timeout=""
dimming=""
while IFS='=' read -r key value; do
  case "$key" in
    timeout) timeout="$value" ;;
    idle_dimming) dimming="$value" ;;
  esac
done < "$file"
if [[ ! "$timeout" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  echo 'Invalid timeout backup; refusing to apply.' >&2; exit 2
fi
case "$dimming" in
  Enabled) suspend_value=0 ;;
  Disabled) suspend_value=1 ;;
  *) echo 'Invalid idle dimming backup; refusing to apply.' >&2; exit 2 ;;
esac
printf 'Restoring timeout %s seconds; idle dimming %s.\n' "$timeout" "$dimming"
mac-brightnessctl -s "$suspend_value"
mac-brightnessctl -t "$timeout"
mac-brightnessctl -t
mac-brightnessctl -s
printf 'Quit Lowlight from its menu to restore native automatic brightness handling.\n'
printf 'Neither third-party package was uninstalled.\n'
