#!/bin/sh

# Compare income vs expenses per year

Usage()
{
    echo "report_income_vs_expenses.sh <ledger db file> [<year>]"
}

case $# in
1)
    ledger -f $1 -y "%Y" -AYs reg --yearly --period-sort -Equity -^assets expenses income
    ;;
2) 
    #TODO: filter for given year
    ledger -f $1 -y "%Y" reg --yearly --period-sort -Equity -^assets expenses income
    ;;
*)
    Usage()
    exit 1
    ;;
esac
