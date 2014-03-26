#!/bin/sh

### VAR 
DAT_INCOME_VS_EXPENSES="income_vs_expenses.dat"
PLOT_INCOME_VS_EXPENSES="$HOME/dev/python/ledgerplot/plot_income_vs_expenses.py"

Usage()
{
    echo "Usage:"
    echo "    $0 <ledger db file> [<year>]"
}

case $# in
1) 
    report_income_vs_expenses.sh $1 > $DAT_INCOME_VS_EXPENSES.DAT
    ;;
2)
    report_income_vs_expenses.sh $1 $2 > $DAT_INCOME_VS_EXPENSES.DAT
    ;;
*)
    Usage
    exit 1
    ;;
esac
python $PLOT_INCOME_VS_EXPENSES $DAT_INCOME_VS_EXPENSES.DAT
