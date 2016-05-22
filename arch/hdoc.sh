#!/usr/bin/env bash

firefox $(stack path --snapshot-doc-root)/$(stack list-dependencies | grep $1 | head -n 1 | sed -e 's/ /-/')/index.html
