#!/usr/bin/env bash
sudo pacman -Syu && date +%s >> ~/.upgrade.log
cower -vu
