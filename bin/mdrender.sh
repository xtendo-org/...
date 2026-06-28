#!/usr/bin/env bash
set -euo pipefail

src="$1"
dst="$2"
srcbase=$(basename "$1")
header="<!DOCTYPE html>\n<html><head><title>$srcbase</title><link rel='stylesheet' href='/home/user/pkgs/highlight-js/default.min.css'><script src='/home/user/pkgs/highlight-js/highlight.min.js'></script><style>html{background:#ccc}body{background:#fff;color:#000;word-break:keep-all;max-width:38rem;padding:1em;margin:0 auto;line-height:1.5;font-family:sans-serif}code{background:#eee}</style></head><body><h1>$src</h1>"
footer='<script>hljs.highlightAll();</script></body></html>'

cat "$src" | mdfootnote.py | cmark --unsafe --hardbreaks \
| awk -v H="$header" \
      -v F="$footer" \
      'BEGIN{print H}1;END{print F}' \
> "$dst"

echo '['$(date --iso-8601=seconds)']' $dst
