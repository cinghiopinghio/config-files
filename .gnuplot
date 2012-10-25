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

set style line 100 lc rgb '#000000' pt 1 ps 2 lt 1 lw 2
set style line 1 lc rgb '#000000' pt 2 ps 2 lt 2 lw 2
set style line 2 lc rgb '#000000' pt 3 ps 2 lt 3 lw 2
set style line 3 lc rgb '#000000' pt 4 ps 2 lt 4 lw 2
set style line 4 lc rgb '#000000' pt 5 ps 2 lt 5 lw 2
set style line 5 lc rgb '#000000' pt 6 ps 2 lt 6 lw 2
set style line 6 lc rgb '#000000' pt 7 ps 2 lt 7 lw 2
set style line 7 lc rgb '#000000' pt 8 ps 2 lt 8 lw 2
set style line 8 lc rgb '#000000' pt 9 ps 2 lt 9 lw 2
set style line 9 lc rgb '#000000' pt 10 ps 2 lt 10 lw 2
set style line 10 lc rgb '#ff181f' pt 1 ps 2 lt 1 lw 2
set style line 11 lc rgb '#ff181f' pt 2 ps 2 lt 2 lw 2
set style line 12 lc rgb '#ff181f' pt 3 ps 2 lt 3 lw 2
set style line 13 lc rgb '#ff181f' pt 4 ps 2 lt 4 lw 2
set style line 14 lc rgb '#ff181f' pt 5 ps 2 lt 5 lw 2
set style line 15 lc rgb '#ff181f' pt 6 ps 2 lt 6 lw 2
set style line 16 lc rgb '#ff181f' pt 7 ps 2 lt 7 lw 2
set style line 17 lc rgb '#ff181f' pt 8 ps 2 lt 8 lw 2
set style line 18 lc rgb '#ff181f' pt 9 ps 2 lt 9 lw 2
set style line 19 lc rgb '#ff181f' pt 10 ps 2 lt 10 lw 2
set style line 20 lc rgb '#2e8b57' pt 1 ps 2 lt 1 lw 2
set style line 21 lc rgb '#2e8b57' pt 2 ps 2 lt 2 lw 2
set style line 22 lc rgb '#2e8b57' pt 3 ps 2 lt 3 lw 2
set style line 23 lc rgb '#2e8b57' pt 4 ps 2 lt 4 lw 2
set style line 24 lc rgb '#2e8b57' pt 5 ps 2 lt 5 lw 2
set style line 25 lc rgb '#2e8b57' pt 6 ps 2 lt 6 lw 2
set style line 26 lc rgb '#2e8b57' pt 7 ps 2 lt 7 lw 2
set style line 27 lc rgb '#2e8b57' pt 8 ps 2 lt 8 lw 2
set style line 28 lc rgb '#2e8b57' pt 9 ps 2 lt 9 lw 2
set style line 29 lc rgb '#2e8b57' pt 10 ps 2 lt 10 lw 2
set style line 30 lc rgb '#0060ad' pt 1 ps 2 lt 1 lw 2
set style line 31 lc rgb '#0060ad' pt 2 ps 2 lt 2 lw 2
set style line 32 lc rgb '#0060ad' pt 3 ps 2 lt 3 lw 2
set style line 33 lc rgb '#0060ad' pt 4 ps 2 lt 4 lw 2
set style line 34 lc rgb '#0060ad' pt 5 ps 2 lt 5 lw 2
set style line 35 lc rgb '#0060ad' pt 6 ps 2 lt 6 lw 2
set style line 36 lc rgb '#0060ad' pt 7 ps 2 lt 7 lw 2
set style line 37 lc rgb '#0060ad' pt 8 ps 2 lt 8 lw 2
set style line 38 lc rgb '#0060ad' pt 9 ps 2 lt 9 lw 2
set style line 39 lc rgb '#0060ad' pt 10 ps 2 lt 10 lw 2
set style line 40 lc rgb '#ff8c00' pt 1 ps 2 lt 1 lw 2
set style line 41 lc rgb '#ff8c00' pt 2 ps 2 lt 2 lw 2
set style line 42 lc rgb '#ff8c00' pt 3 ps 2 lt 3 lw 2
set style line 43 lc rgb '#ff8c00' pt 4 ps 2 lt 4 lw 2
set style line 44 lc rgb '#ff8c00' pt 5 ps 2 lt 5 lw 2
set style line 45 lc rgb '#ff8c00' pt 6 ps 2 lt 6 lw 2
set style line 46 lc rgb '#ff8c00' pt 7 ps 2 lt 7 lw 2
set style line 47 lc rgb '#ff8c00' pt 8 ps 2 lt 8 lw 2
set style line 48 lc rgb '#ff8c00' pt 9 ps 2 lt 9 lw 2
set style line 49 lc rgb '#ff8c00' pt 10 ps 2 lt 10 lw 2
set style line 50 lc rgb '#9400d3' pt 1 ps 2 lt 1 lw 2
set style line 51 lc rgb '#9400d3' pt 2 ps 2 lt 2 lw 2
set style line 52 lc rgb '#9400d3' pt 3 ps 2 lt 3 lw 2
set style line 53 lc rgb '#9400d3' pt 4 ps 2 lt 4 lw 2
set style line 54 lc rgb '#9400d3' pt 5 ps 2 lt 5 lw 2
set style line 55 lc rgb '#9400d3' pt 6 ps 2 lt 6 lw 2
set style line 56 lc rgb '#9400d3' pt 7 ps 2 lt 7 lw 2
set style line 57 lc rgb '#9400d3' pt 8 ps 2 lt 8 lw 2
set style line 58 lc rgb '#9400d3' pt 9 ps 2 lt 9 lw 2
set style line 59 lc rgb '#9400d3' pt 10 ps 2 lt 10 lw 2
set style line 60 lc rgb '#b22222' pt 1 ps 2 lt 1 lw 2
set style line 61 lc rgb '#b22222' pt 2 ps 2 lt 2 lw 2
set style line 62 lc rgb '#b22222' pt 3 ps 2 lt 3 lw 2
set style line 63 lc rgb '#b22222' pt 4 ps 2 lt 4 lw 2
set style line 64 lc rgb '#b22222' pt 5 ps 2 lt 5 lw 2
set style line 65 lc rgb '#b22222' pt 6 ps 2 lt 6 lw 2
set style line 66 lc rgb '#b22222' pt 7 ps 2 lt 7 lw 2
set style line 67 lc rgb '#b22222' pt 8 ps 2 lt 8 lw 2
set style line 68 lc rgb '#b22222' pt 9 ps 2 lt 9 lw 2
set style line 69 lc rgb '#b22222' pt 10 ps 2 lt 10 lw 2
set style line 70 lc rgb '#556b2f' pt 1 ps 2 lt 1 lw 2
set style line 71 lc rgb '#556b2f' pt 2 ps 2 lt 2 lw 2
set style line 72 lc rgb '#556b2f' pt 3 ps 2 lt 3 lw 2
set style line 73 lc rgb '#556b2f' pt 4 ps 2 lt 4 lw 2
set style line 74 lc rgb '#556b2f' pt 5 ps 2 lt 5 lw 2
set style line 75 lc rgb '#556b2f' pt 6 ps 2 lt 6 lw 2
set style line 76 lc rgb '#556b2f' pt 7 ps 2 lt 7 lw 2
set style line 77 lc rgb '#556b2f' pt 8 ps 2 lt 8 lw 2
set style line 78 lc rgb '#556b2f' pt 9 ps 2 lt 9 lw 2
set style line 79 lc rgb '#556b2f' pt 10 ps 2 lt 10 lw 2
set style line 80 lc rgb '#dc143c' pt 1 ps 2 lt 1 lw 2
set style line 81 lc rgb '#dc143c' pt 2 ps 2 lt 2 lw 2
set style line 82 lc rgb '#dc143c' pt 3 ps 2 lt 3 lw 2
set style line 83 lc rgb '#dc143c' pt 4 ps 2 lt 4 lw 2
set style line 84 lc rgb '#dc143c' pt 5 ps 2 lt 5 lw 2
set style line 85 lc rgb '#dc143c' pt 6 ps 2 lt 6 lw 2
set style line 86 lc rgb '#dc143c' pt 7 ps 2 lt 7 lw 2
set style line 87 lc rgb '#dc143c' pt 8 ps 2 lt 8 lw 2
set style line 88 lc rgb '#dc143c' pt 9 ps 2 lt 9 lw 2
set style line 89 lc rgb '#dc143c' pt 10 ps 2 lt 10 lw 2
set style line 90 lc rgb '#6495ed' pt 1 ps 2 lt 1 lw 2
set style line 91 lc rgb '#6495ed' pt 2 ps 2 lt 2 lw 2
set style line 92 lc rgb '#6495ed' pt 3 ps 2 lt 3 lw 2
set style line 93 lc rgb '#6495ed' pt 4 ps 2 lt 4 lw 2
set style line 94 lc rgb '#6495ed' pt 5 ps 2 lt 5 lw 2
set style line 95 lc rgb '#6495ed' pt 6 ps 2 lt 6 lw 2
set style line 96 lc rgb '#6495ed' pt 7 ps 2 lt 7 lw 2
set style line 97 lc rgb '#6495ed' pt 8 ps 2 lt 8 lw 2
set style line 98 lc rgb '#6495ed' pt 9 ps 2 lt 9 lw 2
set style line 99 lc rgb '#6495ed' pt 10 ps 2 lt 10 lw 2
