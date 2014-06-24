#!/bin/sh

Usage()
{
    echo $0" <ledger db file>"
}

case $# in
1)
    #Note: the below is for ledger3
    #ledger -f $1 --pendantic balance ^assets ^liabilities
    #TODO: only needs the first level...
    ledger -f $1 balance ^assets ^liabilities
    ;;
*)
    Usage()
    exit 1
    ;;
esac
