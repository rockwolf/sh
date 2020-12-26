#!/bin/sh

# Note: Using -M causes a bug with a spike for the reverse stock split of 2014_binb00.dat.
ledger -f $1 --price-db prices.db --strict --real -X EUR -J reg assets -D --collapse > ledgeroutput1.tmp
ledger -f $1 --price-db prices.db --strict --real -X EUR -J reg liabilities -D --collapse --no-rounding --plot-total-format="%(format_date(date, \"%Y-%m-%d\"))  %(abs(quantity(scrub(display_total))))\n" > ledgeroutput2.tmp

(cat <<EOF) | gnuplot
  set terminal pngcairo size 1920,1080 enhanced font 'Inconsolata,10'
  set output 'yearly_wealthgrowth.png'
  set xdata time
  set timefmt "%Y-%m-%d"
  set xrange ["$2-01-01":"$(date +%Y)-12-31"]
  #set xtics nomirror "" ,31104000 format "%Y"
  #set xtics offset 0 nomirror "" ,31104000 format "%Y-%m-%d"
  #set xtics offset 0 nomirror "" ,365 format "%Y-%m"
  set xtics format "%Y"
  #set xtics rotate by 60 right
  #set xtics "2008-01-01", 31449600, "2020-12-31"
  set mxtics 2
  set mytics 2
  set grid xtics mxtics ytics mytics
  set title "Wealthgrowth"
  set ylabel "Amount"
  set style fill transparent solid 0.6 noborder
  plot "ledgeroutput1.tmp" using 1:2 with filledcurves x1 title "Assets" linecolor rgb "light-green", "ledgeroutput2.tmp" using 1:2 with filledcurves y1=0 title "Liabilities" linecolor rgb "light-salmon"
EOF

rm ledgeroutput*.tmp
