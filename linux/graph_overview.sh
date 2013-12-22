#!/bin/sh

### VAR 
PLOT="plot_overview"
DAT_NET_WORTH="gnuplot_net-worth.dat"
DAT_INCOME="gnuplot_income.dat"
DAT_EXPENSES="gnuplot_expenses.dat"

Usage()
{
    echo "Usage:"
    echo "    $0 <ledger db file>"
}

case $# in
1) 
    ledger -f $1 -Y -c -R -n -J reg ^assets ^liabilities > $DAT_NET_WORTH 
    ledger -f $1 -t -a -Y -c -R -n -J reg ^income > $DAT_INCOME 
    ledger -f $1 -Y -c -R -n -j reg ^expenses > $DAT_EXPENSES 
    ./$PLOT.sh > ./$PLOT.png
    feh -ZF ./$PLOT.png
    ;;
*)
    Usage
    exit 1
    ;;
esac
