#!/usr/bin/env bash
if [ -z $1 ]; then
    echo "missing package name"
    exit 1
fi
cd ~/package && git clone --depth=1 https://aur.archlinux.org/$1.git && cd $1 && makepkg -sri
