#!/bin/sh

# VAR 
PLOT="plot_overview_per_month"
DAT_NET_WORTH="gnuplot_net-worth_per_month.dat"
DAT_INCOME="gnuplot_income_per_month.dat"
DAT_EXPENSES="gnuplot_expenses_per_month.dat"

Usage()
{
    echo "Usage:"
    echo "    $0 <ledger db file> <year>"
}

case $# in
2) 
    ledger -f $1 --begin "$2/01/01" --end "$2/12/31" -M -c -R -n -J reg ^assets ^liabilities > $DAT_NET_WORTH 
    ledger -f $1 --begin "$2/01/01" --end "$2/12/31" -t -a -M -c -R -n -j reg ^income > $DAT_INCOME 
    ledger -f $1 --begin "$2/01/01" --end "$2/12/31" -M -c -R -n -j reg ^expenses > $DAT_EXPENSES 
    ./$PLOT.sh > ./$PLOT.png
    feh ./$PLOT.png
    ;;
*)
    Usage
    exit 1
    ;;
esac
