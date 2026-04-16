#!/usr/bin/env bash
set -euo pipefail

src="$(realpath "$1")"
dst="/tmp/$(echo -n "$src" | base64 -w0 | tr '+/' '-_' | tr -d '=').html"

mdrender.sh "$src" "$dst"

firefox -P Reset --private-window "$dst" &
disown -h %1
