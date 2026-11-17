#!/usr/bin/env python3
"""Embed data/members_compact.json into dashboard.html (replaces the `const RAW = ...;` line) and
write a standalone preview to the path given as first argument (optional) for a headless-Chrome screenshot."""
import sys, pathlib
root = pathlib.Path(__file__).resolve().parent.parent
html_p = root / "dashboard.html"
s = html_p.read_text()
a = s.index("const RAW = ") + len("const RAW = "); b = s.index(";\n", a)
s = s[:a] + (root / "data" / "members_compact.json").read_text().strip() + s[b:]
html_p.write_text(s)
print(f"embedded {b-a} -> {len((root/'data'/'members_compact.json').read_text().strip())} bytes; page {len(s)} bytes")
if len(sys.argv) > 1:
    pathlib.Path(sys.argv[1]).write_text('<!doctype html><html><head><meta charset="utf-8"></head><body style="margin:0">' + s + "</body></html>")
    print("preview written to", sys.argv[1])
