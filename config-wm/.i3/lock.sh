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

# i3lock                    \
# --insidevercolor=$V       \
# --ringvercolor=$V         \
#                           \
# --insidewrongcolor=$W     \
# --ringwrongcolor=$W       \
#                           \
# --insidecolor=$B          \
# --ringcolor=$D            \
# --linecolor=$N            \
# --separatorcolor=$D       \
#                           \
# --verifcolor=$T           \
# --wrongcolor=$T           \
# --timecolor=$T            \
# --datecolor=$T            \
# --layoutcolor=$T          \
# --keyhlcolor=$T           \
# --bshlcolor=$W            \
#                           \
# --screen 0                \
# --blur 5                  \
# --clock                   \
# --indicator               \
#                           \
# --timestr="%H:%M"         \
# --time-font="Fira Sans"   \
# --datestr="%A, %m %Y"     \
# --date-font="Fira Sans"   \
# --layout-font="Fira Sans" \
# --verif-font="Fira Sans"  \
# --wrong-font="Fira Sans"  \
# --veriftext="CHECKING..." \
# --wrongtext="WRONG!"      \
# --ring-width=3            \
# --image ${TMPF}

	letterEnteredColor=d23c3dff
	letterRemovedColor=d23c3dff
	passwordCorrect=00000000
	passwordIncorrect=d23c3dff
	background=00000000
	foreground=ffffffff
	i3lock \
		-t -i "$1" \
		--timepos='x+110:h-70' \
		--datepos='x+43:h-45' \
		--clock --date-align 1 \
		--insidecolor=$background --ringcolor=$foreground --line-uses-inside \
		--keyhlcolor=$letterEnteredColor --bshlcolor=$letterRemovedColor --separatorcolor=$background \
		--insidevercolor=$passwordCorrect --insidewrongcolor=$passwordIncorrect \
		--ringvercolor=$foreground --ringwrongcolor=$foreground --indpos='x+280:h-70' \
		--radius=20 --ring-width=4 --veriftext='' --wrongtext='' \
		--verifcolor="$foreground" --timecolor="$foreground" --datecolor="$foreground" \
		--noinputtext='' --force-clock --image ${TMPF}

rm ${TMPF}
