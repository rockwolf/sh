#!/bin/sh

# Compare income vs expenses per year

Usage()
{
    echo "report_income_vs_expenses.sh <ledger db file> [<year>]"
}

case $# in
1)
    #-y "%Y"
    #ledger -f $1 --real -s -B -d "T&l<=1" bal --yearly --period-sort -Equity -^assets expenses income
    ledger -f $1 --real -s -d "T&l<=1" bal -Equity -^assets expenses income
    ;;
2) 
    ledger -f $1 --real -s -p $2 bal --yearly --period-sort -Equity -^assets expenses income
    ;;
*)
    Usage()
    exit 1
    ;;
esac
