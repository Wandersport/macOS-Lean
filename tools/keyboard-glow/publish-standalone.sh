#!/usr/bin/env bash
# Create a separate public repo from ONLY this directory. No source changes.
set -euo pipefail
repo="Wandersport/macOS-Keyboard-Glow"
src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v gh >/dev/null 2>&1; then
  printf 'GitHub CLI is required. Install with: brew install gh\n' >&2; exit 2
fi
if ! command -v git >/dev/null 2>&1; then
  printf 'Git is required.\n' >&2; exit 2
fi
if ! gh auth status >/dev/null 2>&1; then
  printf 'Please authenticate first: gh auth login\n' >&2; exit 2
fi
actual="$(gh api user --jq .login)"
if [[ "$actual" != "Wandersport" ]]; then
  printf 'Authenticated as %s, not Wandersport. Refusing to publish.\n' "$actual" >&2
  exit 2
fi
if gh repo view "$repo" >/dev/null 2>&1; then
  printf 'Repository already exists: https://github.com/%s\n' "$repo" >&2
  printf 'No files were overwritten.\n' >&2
  exit 1
fi

printf 'This will create https://github.com/%s as a PUBLIC repository.\n' "$repo"
printf 'Only the contents of %s will be copied.\n' "$src"
if [[ "${1:-}" != "--yes" ]]; then
  read -r -p 'Publish this standalone project? [y/N] ' answer || exit 1
  case "$answer" in y|Y|yes|YES) ;; *) printf 'Cancelled.\n'; exit 0 ;; esac
fi

temp="$(mktemp -d)"
trap 'rm -rf "$temp"' EXIT
cp -R "$src/." "$temp/"
cd "$temp"
git init -b main
git add .
git commit -m "Initial release: keyboard glow setup and rollback"
gh repo create "$repo" --public --source=. --remote=origin --push \
  --description "Below-minimum MacBook keyboard backlight + configurable 2-second idle dimming"
printf '\nPublished: https://github.com/%s\n' "$repo"
