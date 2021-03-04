#!/bin/sh
BLOCKS="_▁▂▃▄▅▆▇█"

top -bn1 -p 1 -w 20 |\
    grep -i "^%CPU" |\
    awk 'BEGIN{BLOCKS="_▁▂▃▄▅▆▇█"; lb=length(BLOCKS)}{printf("%s", substr(BLOCKS, int($3 * lb / 101), 1))}'
echo -n "|"
free |\
    grep "^Mem" |\
    awk 'BEGIN{BLOCKS="_▁▂▃▄▅▆▇█"; lb=length(BLOCKS)}{printf("%s\n",substr(BLOCKS, int((1 - $7/$2) * lb), 1))}'
echo "System monitor (cpu|mem)"
