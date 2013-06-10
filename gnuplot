set loadpath '~/.gnuplotting/gcb/diverging' \
    '~/.gnuplotting/gcb/qualitative' \
    '~/.gnuplotting/gcb/sequential' \
    '~/.gnuplotting'

set terminal wxt dash

#set borders
set style line 101 lc rgb '#303030' lt 1 lw 1.5
set border 3 back ls 101
set tics nomirror out scale 0.75


#set grid
set style line 102 lc rgb '#808080' lt 0 lw 1
set grid back ls 102


# add arrows to the graph
#set arrow from graph 1,0 to graph 1.05,0 size screen 0.025,15,60 #    filled ls 100
#set arrow from graph 0,1 to graph 0,1.05 size screen 0.025,15,60 #    filled ls 100


# function to plot histograms:
# usage:
# p "filename" u (BIN($1,width)):(1.0) smooth freq with boxes
BIN(X,WIDTH)=WIDTH*floor(X/WIDTH)+WIDTH/2


