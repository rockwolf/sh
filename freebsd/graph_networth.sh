#!/bin/sh

### VAR 
DAT_NETWORTH="networth.dat"
PLOT_NETWORTH="$HOME/dev/python/ledgerplot/plot_networth.py"

Usage()
{
    echo "Usage:"
    echo "    $0 <ledger db file> [<year>]"
}

case $# in
1)
    # Plot all data until now.
    report_networth.sh $1 > $DAT_NETWORTH
    python $PLOT_NETWORTH $DAT_NETWORTH
    ;;
2)
    # Plot all data for the given year.
    report_networth.sh $1 $2 > $DAT_NETWORTH
    python $PLOT_NETWORTH $DAT_NETWORTH $2
    ;;
*)
    Usage
    exit 1
    ;;
esac
