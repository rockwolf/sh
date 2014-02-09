#!/bin/sh

# Typical monthly expense report, balanced against budget.

Usage()
{
    echo "report_budget_per_month.sh <ledger db file>"
}

case $# in
1)  ledger -f $1 --budget --monthly register ^expenses 
    ;;
*)
    Usage()
    exit 1
    ;;
esac
