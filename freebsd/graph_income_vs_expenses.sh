#!/bin/sh

### VAR 
DAT_INCOME_VS_EXPENSES="income_vs_expenses.dat"
PLOT_INCOME_VS_EXPENSES="$HOME/dev/python/ledgerplot/plot_income_vs_expenses.py"

Usage()
{
    echo "Usage:"
    echo "    $0 <ledger db file> [<year>|<start date> <end date> [total]]"
    echo "    Notes:"
    echo "    ------"
    echo "    * Start- and enddate should be in YYYY/MM/DD format."
    echo "    * Specifying total with a period, will display the total,"
    echo "      otherwise, the total per month in that period is shown."
}

case $# in
1)
    # Plot all data until now.
    report_income_vs_expenses.sh $1 > $DAT_INCOME_VS_EXPENSES
    python $PLOT_INCOME_VS_EXPENSES $DAT_INCOME_VS_EXPENSES
    ;;
2)
    # Plot all data for the given year.
    report_income_vs_expenses.sh $1 $2 > $DAT_INCOME_VS_EXPENSES
    python $PLOT_INCOME_VS_EXPENSES $DAT_INCOME_VS_EXPENSES $2
    ;;
3)
    # Plot all data for the given period
    ## per month
    report_income_vs_expenses.sh $1 $2 $3 > $DAT_INCOME_VS_EXPENSES
    python $PLOT_INCOME_VS_EXPENSES $DAT_INCOME_VS_EXPENSES $2 $3
    ;;
4)
    if [ "$4" = "total" ];
    then
        # Plot all data for the given period
        ## as the total
        report_income_vs_expenses.sh $1 $2 $3 > $DAT_INCOME_VS_EXPENSES
        python $PLOT_INCOME_VS_EXPENSES $DAT_INCOME_VS_EXPENSES $2 $3
    else
        Usage
    fi
    ;;
*)
    Usage
    exit 1
    ;;
esac
