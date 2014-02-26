#!/bin/sh

# How much do you spend each month [on X]?

Usage()
{
    echo "report_expenses_per_month.sh <ledger db file> [<expense category name>]"
}

#TODO: add format string: -F '%A|%D|%t\n'
#but first check what the normal output is.
case $# in
1)
    #ledger -f $1 --pendantic -M register expenses
    ledger -f $1 register --monthly --period-sort -Equity -^Assets expenses
    ;;
2) 
    #ledger -f $1 --pendantic -M register expenses:$2
    ledger -f $1 register --monthly --period-sort -Equity -^Assets expenses:$2
    ;;
*)
    Usage()
    exit 1
    ;;
esac
