#!/bin/sh

#1st quarter - (1/1) until 03/31
#ledger -f ledger.dat --period "until 2014/04" reg
#2nd quarter - from 04/01 until 06/30
#3rd quarter - from 07/01 until 10/01
#4th quarter - from 10/01 until 31/12"
#ledger -f ledger.dat --period "from 2015/10 until 2014/12" reg
#Note: on debian, the version is lower and I have to use
ledger -f ledger.dat -b "2015/01/01" -e "2015/04/02" reg
