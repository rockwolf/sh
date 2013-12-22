#!/usr/bin/gnuplot

### Init
reset
set terminal png

### Title
set title "Income, expenses and net worth per month"

### X-axis
set xlabel "Year"
#set xdata time
#set timefmt "%Y"
#"%Y-%m-%dT%H:%M:%S"
#set format x "%Y"
#set xrange[:]
set xtics 1
set xtics rotate by -45

### Y-axis
set ylabel "Euro"
set key below
set grid
set yrange[*:*]

### Histogram options
set boxwidth 0.1
set style fill solid 1 border 0
set style histogram gap 2
set style data histogram
set bars 0.1

### Background
set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb "#ffffd7" behind

### Plot
# Note: Using vars here for the filenames does not work for some reason!
plot "gnuplot_expenses.dat" using 1:2 title "Expenses" fillcolor rgb "#d70000" with boxes, "gnuplot_income.dat" using 1:2 title "Income" fillcolor rgb "#5f8700" with boxes, "gnuplot_net-worth.dat" using 1:2 title "Net worth" with lines, 0 with lines
