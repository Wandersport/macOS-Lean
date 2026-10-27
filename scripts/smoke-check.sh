#!/bin/bash
# Report-only diagnostics for Apple Silicon macOS. Run locally; no sudo, mutation or networking.
set -u
if [[ "$(uname -s)" != "Darwin" ]]; then
    printf 'This script is for macOS only.\n' >&2
    exit 2
fi
echo "macOS Lean read-only smoke check. Review output before sharing."
echo "== OS/version =="; sw_vers
echo "== Architecture =="; uname -m
echo "== SIP =="; csrutil status 2>&1 || true
echo "== Battery =="; pmset -g batt 2>&1 || true
echo "== Sleep assertions =="; pmset -g assertions 2>&1 || true
echo "== Disk =="; df -h / 2>&1 || true
echo "== Spotlight =="; mdutil -s / 2>&1 || true
echo "== FileVault =="; fdesetup status 2>&1 || true
echo "== Gatekeeper =="; spctl --status 2>&1 || true
echo "== Manual tests required =="
echo "Wi-Fi, Bluetooth, Apple Account, Find My, Software Update, App Store, charge-limit control, lid-closed sleep, USB, audio, camera, VPN, Time Machine, AirDrop/Continuity."
