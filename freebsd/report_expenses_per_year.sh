#!/bin/sh

# How much do you spend each year [on X]?

Usage()
{
    echo "report_expenses_per_year.sh <ledger db file> [<expense category name>]"
}

#TODO: add format string: -F '%A|%D|%t\n'
#but first check what the normal output is.
case $# in
1)
    #ledger -f $1 --pendantic -Y register expenses
    ledger -f $1 register --yearly --period-sort -Equity -^Assets expenses
    ;;
2) 
    #ledger -f $1 --pendantic -Y register expenses:$2
    ledger -f $1 register --yearly --period-sort $DTFORMAT -Equity -^Assets expenses:$2
    ;;
*)
    Usage()
    exit 1
    ;;
esac
