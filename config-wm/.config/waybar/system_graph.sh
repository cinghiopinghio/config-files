#!/bin/sh
BLOCKS="_▁▂▃▄▅▆▇█"

function print_bloc (){
    perc=`echo "$1*${#BLOCKS} / 101" | bc`
    echo -n "${BLOCKS:${perc}:1}"
}

AVAIL_MEM=`free | grep "^Mem" | awk '{printf("%.0f\n",100*$7/$2)}'`

for cpu in `top -bn1 -p 1 | grep -i "^%CPU" | awk '{print $3}' | sed 's/\..*//'`; do
    print_bloc $cpu
done

echo -n "|"
print_bloc "(100 - ${AVAIL_MEM})"
