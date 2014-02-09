#!/bin/sh

# Finding out what your average monthly expense is for any category

Usage()
{
    echo "report_budget_average_per_month.sh <ledger db file>"
}

case $# in
1) 
    ledger -f $1 -p "this year" --monthly --average --subtotal balance ^expenses
    ;;
*)
    Usage()
    exit 1
    ;;
esac
