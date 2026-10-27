#!/usr/bin/env python3
"""Validate relative Markdown paths; no network calls or modifications."""
from pathlib import Path
from urllib.parse import unquote
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
LINK = re.compile(r"(?<!!)\[[^\]\n]+\]\(([^)\n]+)\)")
IGNORE = ("https://", "http://", "mailto:", "#", "tel:")


def check_file(path: Path):
    errors = []
    for match in LINK.finditer(path.read_text(encoding="utf-8")):
        dest = match.group(1).strip().split()[0].strip("<>")
        if dest.startswith(IGNORE) or "://" in dest:
            continue
        rel = unquote(dest.split("#", 1)[0])
        if not rel:
            continue
        candidate = (path.parent / rel).resolve()
        if not candidate.exists():
            errors.append(f"{path.relative_to(ROOT)} -> {rel} (missing)")
    return errors


def main():
    errors = []
    md = sorted(p for p in ROOT.rglob("*.md") if ".git" not in p.parts)
    for path in md:
        errors += check_file(path)
    for error in errors:
        print(error, file=sys.stderr)
    print(f"Checked {len(md)} Markdown files, {len(errors)} missing relative paths.")
    return 1 if errors else 0


if __name__ == "__main__":
    raise SystemExit(main())
