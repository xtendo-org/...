#!/usr/bin/env bash
BASEDIR=$(dirname "$0")
sed -e "s|#.*||" -e "/^\$/d" $BASEDIR/list_of_packages | sudo pacman --needed -S -
