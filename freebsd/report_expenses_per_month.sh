#!/bin/sh

# How much do you spend each month [on X]?

Usage()
{
    echo "report_expenses_per_month.sh <ledger db file> [<expense category name>]"
}

case $# in
1) 
    ledger -f $1 --pendantic -M register expenses:$2
    ;;
2)
    ledger -f $1 --pendantic -M register expenses
    ;;
*)
    Usage()
    exit 1
    ;;
esac
