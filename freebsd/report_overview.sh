#!/bin/sh

# Overview report

Usage()
{
    echo "report_overview.sh <ledger db file>"
}

case $# in
1) 
    echo "Assets"
    echo "------"
    ledger -s -f $1 balance -Equity ^assets -^external
    ;;
*)
    Usage()
    exit 1
    ;;
esac
