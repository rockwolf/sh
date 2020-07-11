#!/bin/sh

# Note: follow by e.g.: expenses -p oct

# TODO: add usage file income|expenses [period identifier]
ledger -f $1 -J --strict -X EUR bal "$2" --sort="-abs(amount)" --flat --no-total --plot-total-format="%(partial_account(options.flat)) %(abs(quantity(scrub(total))))\n" > ledgeroutput1.tmp

(cat <<EOF) | gnuplot
  set terminal pngcairo size 1920,1080 enhanced font 'Inconsolata,10'
  set output 'expenses_for_category_in_period.png'
  set style data histogram
  set style histogram clustered gap 1
  set style fill transparent solid 0.4 noborder
  set xtics nomirror scale 0 rotate by -45
  set ytics add ('' 0) scale 0
  set border 1
  set grid ytics
  set title "Histogram of $2"
  set ylabel "Amount"
  plot "ledgeroutput1.tmp" using 2:xticlabels(1) notitle linecolor rgb "light-green", '' using 0:2:2 with labels font "Inconsolata,8" offset 0,0.5 textcolor linestyle 0 notitle
EOF

#rm ledgeroutput*.tmp
