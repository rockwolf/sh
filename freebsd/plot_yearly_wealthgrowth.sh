#!/bin/sh

ledger -f $1 --strict -X EUR -J reg assets -M --collapse > ledgeroutput1.tmp
ledger -f $1 --strict -X EUR -J reg liabilities -M --collapse --no-rounding --plot-total-format="%(format_date(date, \"%Y-%m-%d\"))  %(abs(quantity(scrub(display_total))))\n" > ledgeroutput2.tmp

(cat <<EOF) | gnuplot
  set terminal pngcairo size 1920,1080 enhanced font 'Inconsolata,10'
  set output 'yearly_wealthgrowth.png'
  set xdata time
  set timefmt "%Y-%m-%d"
  set xrange ["2008-01-01":"$(date +%Y)-12-31"]
  set xtics nomirror "" ,31104000 format "%Y"
  unset mxtics
  set mytics 2
  set grid xtics ytics mytics
  set title "Wealthgrowth"
  set ylabel "Amount"
  set style fill transparent solid 0.6 noborder
  plot "ledgeroutput1.tmp" using 1:2 with filledcurves x1 title "Assets" linecolor rgb "light-green", "ledgeroutput2.tmp" using 1:2 with filledcurves y1=0 title "Liabilities" linecolor rgb "light-salmon"
EOF

rm ledgeroutput*.tmp
