#!/usr/bin/env bash
sed -i 's/^resolver: .*/resolver: '$(curl -s https://www.stackage.org/snapshots | grep -o -m 1 "nightly-[0-9]\+-[0-9]\+-[0-9]\+")'/' stack.yaml
