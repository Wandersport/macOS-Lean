#!/bin/bash
# Read-only; no sudo, remote access, or destructive changes.
set -u
if [[ "$(uname -s)" != "Darwin" ]]; then echo "Only for macOS" >&2; exit 1; fi
OUTPUT="${1:-$HOME/Desktop/macos-lean-baseline.txt}"
if [[ -e "$OUTPUT" ]]; then echo "Refusing to overwrite $OUTPUT" >&2; exit 1; fi
umask 077
{
  date
  sw_vers
  uname -m
  sysctl -n hw.model 2>/dev/null || true
  csrutil status 2>&1 || true
  pmset -g batt 2>&1 || true
  pmset -g custom 2>&1 || true
  pmset -g assertions 2>&1 || true
  sysctl vm.swapusage 2>&1 || true
  df -h / 2>&1 || true
  mdutil -s / 2>&1 || true
} > "$OUTPUT"
chmod 600 "$OUTPUT"
echo "Saved locally: $OUTPUT. Review before sharing."
