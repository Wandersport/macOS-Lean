#!/usr/bin/env bash
# Linux CI simulation with mocked macOS commands; no third-party installers run.
set -euo pipefail
source_dir="$(cd "$(dirname "$0")/.." && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$tmp/bin" "$tmp/home"
cat > "$tmp/bin/uname" <<'MOCK'
#!/usr/bin/env bash
case "$1" in -s) echo Darwin;; -m) echo arm64;; *) /usr/bin/uname "$@";; esac
MOCK
cat > "$tmp/bin/brew" <<'MOCK'
#!/usr/bin/env bash
printf '%s\n' "$*" >> "$HOME/mock_brew.log"
MOCK
cat > "$tmp/bin/open" <<'MOCK'
#!/usr/bin/env bash
printf '%s\n' "$*" >> "$HOME/mock_open.log"
MOCK
cat > "$tmp/bin/mac-brightnessctl" <<'MOCK'
#!/usr/bin/env bash
set -eu
case "$1" in
  -t)
    if [[ $# == 1 ]]; then
      printf 'Idle dim time set to: %s seconds\n' "$(cat "$HOME/mock_timeout" 2>/dev/null || echo '5.00')"
    else
      printf '%s\n' "$2" > "$HOME/mock_timeout"
      printf 'Idle dim time set to: %.2f seconds\n' "$2"
    fi
    ;;
  -s)
    if [[ $# == 1 ]]; then
      printf 'Idle dimming is: %s\n' "$(cat "$HOME/mock_dimming" 2>/dev/null || echo Enabled)"
    else
      if [[ "$2" == 0 ]]; then echo Enabled > "$HOME/mock_dimming"; else echo Disabled > "$HOME/mock_dimming"; fi
      printf 'Idle dimming %s\n' "$(cat "$HOME/mock_dimming")"
    fi
    ;;
  -a) echo 'Auto-brightness is: Enabled' ;;
  *) exit 2 ;;
esac
MOCK
chmod +x "$tmp/bin/"*
export HOME="$tmp/home"
export PATH="$tmp/bin:$PATH"
bash "$source_dir/setup.sh" --yes
state="$HOME/Library/Application Support/macOS-Keyboard-Glow/previous-settings.txt"
test -f "$state"
grep -qx 'timeout=5.00' "$state"
grep -qx 'idle_dimming=Enabled' "$state"
grep -qx '2' "$HOME/mock_timeout"
bash "$source_dir/setup.sh" --yes
grep -qx 'timeout=5.00' "$state"
bash "$source_dir/restore.sh"
grep -qx '5.00' "$HOME/mock_timeout"
grep -qx 'Enabled' "$HOME/mock_dimming"
grep -q 'trust --formula rakalex/mac-brightnessctl/mac-brightnessctl' "$HOME/mock_brew.log"
if grep -q 'trust rakalex/mac-brightnessctl$' "$HOME/mock_brew.log"; then
  echo 'ERROR: broad tap trust used' >&2
  exit 1
fi
echo 'PASS: installer, first-run backup, specific-formula trust, and rollback'
