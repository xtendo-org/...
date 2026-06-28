#!/usr/bin/env bash

while true; do
  date --iso-8601=ns
  if [[ -n $(find . -type d -name .git -prune -o -type f -mmin -10 -print -quit) ]]; then
    echo "change in the last 10m exists, do not commit"
  else
    git add -A
    git commit -v -a -m autosync
  fi

  ~/.../bin/until +10m || break
done
