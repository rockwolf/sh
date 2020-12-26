#!/bin/sh

#ledger -f $FILE --strict --real -X EUR -H -j reg ^Income --collapse --plot-amount-format="%(format_date(date, \"%Y-%m-%d\")) %(abs(quantity(scrub(display_amount))))\n" > ledgeroutput1.tmp
#ledger -f $1 --strict -X EUR --real -J reg income -Y --collapse --no-rounding --plot-total-format "%(format_date(date, \"%Y-%m-%d\"))  %(roundto(scrub(display_amount), 1))\n" > ledgeroutput1.tmp
#ledger -f $1 --strict -X EUR --real -J reg expenses -Y --collapse --no-rounding --plot-total-format "%(format_date(date, \"%Y-%m-%d\"))  %(roundto(scrub(display_amount), 1))\n" > ledgeroutput2.tmp
ledger -f $1 --strict -X EUR --real -J reg income -Y --collapse --no-rounding --plot-total-format "%(format_date(date, \"%Y-%m-%d\"))  %(roundto(scrub(display_amount), 10))\n" > ledgeroutput1.tmp
ledger -f $1 --strict -X EUR --real -J reg expenses -Y --collapse --no-rounding --plot-total-format "%(format_date(date, \"%Y-%m-%d\"))  %(roundto(scrub(display_amount), 10))\n" > ledgeroutput2.tmp

(cat <<EOF) | gnuplot
  set terminal pngcairo size 1920,1080 enhanced font 'Inconsolata,10'
  set output 'yearly_income_vs_expenses.png'
  set style data histogram
  set style histogram clustered gap 1
  set style fill transparent solid 0.4 noborder
  set xtics nomirror scale 0 center
  set ytics add ('' 0) scale 0
  set border 1
  set grid ytics
  set title "Yearly Income and Expenses"
  set ylabel "Amount"
  plot "ledgeroutput1.tmp" using 2:xticlabels(strftime('%Y', strptime('%Y-%m-%d', strcol(1)))) title "Income" linecolor rgb "light-green", '' using 0:2:2 with labels left font "Inconsolata,8" rotate by 45 offset -4,0.5 textcolor linestyle 0 notitle, "ledgeroutput2.tmp" using 2 title "Expenses" linecolor rgb "light-salmon", '' using 0:2:2 with labels left font "Inconsolata,8" rotate by 45 offset 0,0.5 textcolor linestyle 0 notitle
EOF

#rm ledgeroutput*.tmp
