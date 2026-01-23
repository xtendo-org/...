#!/usr/bin/env bash
set -euo pipefail

src="$1"
dst="$2"

cat "$src" | mdfootnote.py | cmark --unsafe --hardbreaks \
| awk -v H='<html><head><style>html{background:#ccc}body{background:#fff;color:#000;word-break:keep-all;max-width:38rem;padding:1em;margin:0 auto;line-height:1.5;font-family:sans-serif}code{background:#eee}</style></head><body>' \
      -v F='</body></html>' \
      'BEGIN{print H}1;END{print F}' \
> "$dst"

echo '['$(date --iso-8601=seconds)']' $dst
