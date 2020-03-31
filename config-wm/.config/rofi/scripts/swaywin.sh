#!/usr/bin/env bash

if [ "$@" ]; then
    con_id=`echo $@ | cut -d ' ' -f 1`
    swaymsg -q "[con_id =${con_id}]" focus
else
    swaymsg -t get_tree | jq -r 'recurse(.nodes[]?)|recurse(.floating_nodes[]?)|select(.type=="con"),select(.type=="floating_con")|(.id|tostring)+" ["+.app_id+"]: "+.name+"\u0000icon\u001f"+.app_id'
fi
