#!/bin/sh

B='#28282899'  # blank
N='#00000000'  # blank
C='#fbf1c766'  # clear ish
D='#98971acc'  # default
T='#fbf1c7ee'  # text
W='#9d0006bb'  # wrong
V='#076678bb'  # verifying

TMPF=$(mktemp /tmp/background-XXXXXXX.jpg)

newsize=$(xrandr | head -1 | sed -e 's/^.*current//' -e 's/,.*$//' -e 's/ //g')
convert ${HOME}/.local/share/background.jpg\
  -resize ${newsize}^\
  -gravity center\
  -extent ${newsize}\
  ${TMPF}

i3lock                    \
--insidevercolor=$V       \
--ringvercolor=$V         \
                          \
--insidewrongcolor=$W     \
--ringwrongcolor=$W       \
                          \
--insidecolor=$B          \
--ringcolor=$D            \
--linecolor=$N            \
--separatorcolor=$D       \
                          \
--verifcolor=$T           \
--wrongcolor=$T           \
--timecolor=$T            \
--datecolor=$T            \
--layoutcolor=$T          \
--keyhlcolor=$T           \
--bshlcolor=$W            \
                          \
--screen 0                \
--blur 5                  \
--clock                   \
--indicator               \
                          \
--timestr="%H:%M"         \
--time-font="Fira Sans"   \
--datestr="%A, %m %Y"     \
--date-font="Fira Sans"   \
--layout-font="Fira Sans" \
--verif-font="Fira Sans"  \
--wrong-font="Fira Sans"  \
--veriftext="CHECKING..." \
--wrongtext="WRONG!"      \
--ring-width=3            \
-i ${TMPF}

rm ${TMPF}
