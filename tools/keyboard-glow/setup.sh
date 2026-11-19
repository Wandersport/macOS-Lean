#!/usr/bin/env bash
# macOS Keyboard Glow — transparent installer of two independent tools.
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  printf 'This setup only runs on macOS.\n' >&2; exit 2
fi
if [[ "$(uname -m)" != "arm64" ]]; then
  printf 'Lowlight requires an Apple Silicon MacBook. Detected: %s\n' "$(uname -m)" >&2; exit 2
fi
if ! command -v brew >/dev/null 2>&1; then
  printf 'Install Homebrew from https://brew.sh first; then rerun this script.\n' >&2; exit 2
fi
if [[ "${1:-}" != "" && "${1:-}" != "--yes" ]]; then
  printf 'Usage: bash setup.sh [--yes]\n' >&2; exit 2
fi

printf '\nmacOS Keyboard Glow (opt-in)\n'
printf '  1. Trust ONLY rakalex/mac-brightnessctl/mac-brightnessctl formula\n'
printf '  2. Install mac-brightnessctl and Lowlight\n'
printf '  3. Save first-run idle-dimming state and timeout\n'
printf '  4. Enable idle dimming; set timeout to 2 seconds\n'
printf '  5. Open Lowlight (sub-minimum slider is selected manually)\n'
printf 'Upstream: https://github.com/rakalex/mac-brightnessctl\n'
printf 'Upstream: https://github.com/Isaac-Harper/lowlight\n'
if [[ "${1:-}" != "--yes" ]]; then
  read -r -p 'Trust this specific Homebrew formula and continue? [y/N] ' answer || exit 1
  case "$answer" in y|Y|yes|YES) ;; *) printf 'Cancelled.\n'; exit 0 ;; esac
fi

brew tap rakalex/mac-brightnessctl
brew trust --formula rakalex/mac-brightnessctl/mac-brightnessctl
brew install rakalex/mac-brightnessctl/mac-brightnessctl
brew install --cask isaac-harper/tap/lowlight

if ! command -v mac-brightnessctl >/dev/null 2>&1; then
  printf 'mac-brightnessctl not in PATH. Open a new shell and retry.\n' >&2; exit 1
fi
state_dir="$HOME/Library/Application Support/macOS-Keyboard-Glow"
state_file="$state_dir/previous-settings.txt"
umask 077
mkdir -p "$state_dir"
if [[ ! -e "$state_file" ]]; then
  previous_timeout="$(mac-brightnessctl -t | sed -nE 's/^Idle dim time set to: ([0-9]+([.][0-9]+)?) seconds$/\1/p')"
  previous_dimming="$(mac-brightnessctl -s | sed -nE 's/^Idle dimming is: (Enabled|Disabled)$/\1/p')"
  if [[ -z "$previous_timeout" || -z "$previous_dimming" ]]; then
    printf 'Could not reliably read old settings; refusing to change.\n' >&2
    exit 1
  fi
  printf 'timeout=%s\nidle_dimming=%s\n' "$previous_timeout" "$previous_dimming" > "$state_file"
  chmod 600 "$state_file"
else
  printf 'Preserving first-run settings backup: %s\n' "$state_file"
fi

mac-brightnessctl -s 0
mac-brightnessctl -t 2
observed="$(mac-brightnessctl -t | sed -nE 's/^Idle dim time set to: ([0-9]+([.][0-9]+)?) seconds$/\1/p')"
if [[ ! "$observed" =~ ^2([.]0+)?$ ]]; then
  printf 'WARNING: timeout readback was %s, not 2 seconds.\n' "$observed" >&2
  exit 1
fi
open -a Lowlight
printf '\nConfigured timeout: 2 seconds. Lowlight opened.\n'
printf 'Use Lowlight menu: Steps Below Minimum -> 20, then select a low step.\n'
printf 'TEST: Does the keyboard actually go dark after 2 s while Lowlight is below minimum?\n'
printf 'The two private CoreBrightness interfaces may conflict; readback is not proof.\n'
printf 'Run: bash status.sh\n'
