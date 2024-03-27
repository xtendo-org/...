#!/bin/bash

for ((i = 0; i < 32; i++)); do
    for ((j = 0; j < 8; j++)); do
        val=$((i * 8 + j))
        val_fmt=$(printf "%3d" $val)
        echo -ne "\e[48;5;${val}m ${val_fmt} \e[0m"
    done
    echo # New line
done
