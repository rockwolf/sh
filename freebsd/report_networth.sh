#!/bin/sh

# The combined total of your Assets and Liabilities is your net worth.

Usage()
{
    echo "report_networth.sh <ledger db file>"
}

case $# in
1) 
    #Note: the below is for ledger3
    #ledger -f $1 --pendantic balance ^assets ^liabilities
    ledger -f $1 balance ^assets ^liabilities
    ;;
*)
    Usage()
    exit 1
    ;;
esac
