#!/bin/sh

### VAR 
DAT_INCOME_VS_EXPENSES="income_vs_expenses.dat"
PLOT_INCOME_VS_EXPENSES="$HOME/dev/python/ledgerplot/plot_income_vs_expenses.py"

Usage()
{
    echo "Usage:"
    echo "    $0 <ledger db file> [<year>|<start date> <end date>]"
    echo "    Note: start- and enddate should be in YYYY/MM/DD format."
}

case $# in
1) 
    report_income_vs_expenses.sh $1 > $DAT_INCOME_VS_EXPENSES
    python $PLOT_INCOME_VS_EXPENSES $DAT_INCOME_VS_EXPENSES
    ;;
2)
    report_income_vs_expenses.sh $1 $2 > $DAT_INCOME_VS_EXPENSES
    python $PLOT_INCOME_VS_EXPENSES $DAT_INCOME_VS_EXPENSES $2
    ;;
3)
    report_income_vs_expenses.sh $1 $2 $3 > $DAT_INCOME_VS_EXPENSES
    python $PLOT_INCOME_VS_EXPENSES $DAT_INCOME_VS_EXPENSES $2 $3
    ;;
*)
    Usage
    exit 1
    ;;
esac