set loadpath '~/.gnuplotting/gcb/diverging' \
    '~/.gnuplotting/gcb/qualitative' \
    '~/.gnuplotting/gcb/sequential' \
    '~/.gnuplotting'

set terminal wxt dash

set macro

#set borders
set style line 101 lc rgb '#303030' lt 1 lw 1.5
set border 3 back ls 101
set tics nomirror out scale 0.75


#set grid
#set style line 102 lc rgb '#808080' lt 0 lw 1
#set grid back ls 102

# function to plot histograms:
# usage:
# > p "filename" u (BIN($1,width)):(1.0) smooth freq with boxes
BIN(X,WIDTH)=WIDTH*floor(X/WIDTH)+WIDTH/2

#####  Color Palette by Paletton.com
#####  Palette URL: http://paletton.com/#uid=7030z0kuwByhaPZnOHPz4pUClgV
#*** Primary color: red
red_L     = "rgbcolor '#FF8076'"
red_l     = "rgbcolor '#FF4F41'"
red_n     = "rgbcolor '#FF1E0C'"
red_d     = "rgbcolor '#CE0F00'"
red_D     = "rgbcolor '#870A00'"
#*** Secondary color (1): yellow
yellow_L  = "rgbcolor '#FFBD76'"
yellow_l  = "rgbcolor '#FFA441'"
yellow_n  = "rgbcolor '#FF8A0C'"
yellow_d  = "rgbcolor '#CE6B00'"
yellow_D  = "rgbcolor '#874600'"
#*** Secondary color (2): blue
blue_L    = "rgbcolor '#6CBFDE'"
blue_l    = "rgbcolor '#399FC6'"
blue_n    = "rgbcolor '#0F86B3'"
blue_d    = "rgbcolor '#055F82'"
blue_D    = "rgbcolor '#033E55'"
#*** Complement color: green
green_L   = "rgbcolor '#6DEA83'"
green_l   = "rgbcolor '#38DB55'"
green_n   = "rgbcolor '#0ACF2C'"
green_d   = "rgbcolor '#009E1C'"
green_D   = "rgbcolor '#006712'"
#### Grays
gray_L    = "rgbcolor '#AAAAAA'"
gray_l    = "rgbcolor '#999999'"
gray_n    = "rgbcolor '#777777'"
gray_d    = "rgbcolor '#444444'"
gray_D    = "rgbcolor '#222222'"
