#!/usr/bin/gnuplot

### Init
reset
set terminal png

### Title
set title "Income, expenses and net worth per month"

### X-axis
set xlabel "Date (month/year)"
set xdata time
set timefmt "%Y-%m-%d"
#"%Y-%m-%dT%H:%M:%S"
set format x "%m/%y"
#set xrange["2008-01-01":"2014-01-01"]
#set xtics "%m/%y"
#set xtics "2008-01-01",2592000,"2014-01-01"
set xtics rotate by -45

### Y-axis
set ylabel "Euro"
set key below
set grid
set yrange[*:*]

### Histogram options
# Note: When using time-data, the x-axis is in seconds!
# The below sets the bars to be 3600*24*<num> = <num> days in length
set boxwidth 3600*24*7
set style fill solid 1 border 0
set style histogram gap 2
set style data histogram
set bars 0.1

### Background
set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb "#ffffd7" behind

### Plot
# Note: Using vars here for the filenames does not work for some reason!
plot "gnuplot_expenses_per_month.dat" using 1:2 title "Expenses" linecolor rgb "#d70000" with boxes, "gnuplot_income_per_month.dat" using 1:2 title "Income" linecolor rgb "#5f8700" with boxes , "gnuplot_net-worth_per_month.dat" using 1:2 title "Net worth" with lines, 0 linecolor rgb "#1c1c1c" with lines, 12000 linecolor rgb "#d70000" with lines
