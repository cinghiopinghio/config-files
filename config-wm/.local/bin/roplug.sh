#!/usr/bin/env bash

choice=$(grep "Plug " ~/.config/nvim/config/plugins.vim |\
    cut -d\' -f2 |\
    sed 's/$/\x00icon\x1fnvim/' |\
    rofi -dmenu)

if [[ ${choice} == "" ]]; then exit; fi

echo ${choice}
firefox "https://github.com/${choice}"
