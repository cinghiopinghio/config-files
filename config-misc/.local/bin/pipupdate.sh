#!/usr/bin/env bash

outdated=( `pip list --user --outdated --format=freeze  | grep -v '^\-e' | cut -d = -f 1` )

if [[ ${#outdated[@]} == 0 ]];
then
    echo No updates
    exit 0
fi

echo ${outdated[@]}

read -n1 -e -p "Update all? [y/n] " choice

case $choice in
    y|Y)
        pip install --user -U ${outdated[@]}
        ;;
    *)
        echo Ciao
        ;;
esac


