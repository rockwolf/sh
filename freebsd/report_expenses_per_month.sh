#!/bin/sh

# How much do you spend each month [on X]?

DTFORMAT="%Y-%m-%d"

Usage()
{
    echo "report_expenses_per_month.sh <ledger db file> [<expense category name>]"
}

case $# in
1)
    #ledger -f $1 --pendantic -M register expenses
    ledger -f $1 register --monthly --date-format $DTFORMAT -Equity -^Assets expenses
    ;;
2) 
    #ledger -f $1 --pendantic -M register expenses:$2
    ledger -f $1 register --monthly --date-format $DTFORMAT -Equity -^Assets expenses:$2
    ;;
*)
    Usage()
    exit 1
    ;;
esac
