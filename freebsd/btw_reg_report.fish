#!/usr/local/bin/fish

# 1st quarter - (1/1) until 03/31
# ledger -f ledger.dat --period "until 2014/04" reg
# 2nd quarter - from 04/01 until 06/30
# 3rd quarter - from 07/01 until 10/01
# 4th quarter - from 10/01 until 31/12"
# ledger -f ledger.dat --period "from 2015/10 until 2014/12" reg
# Note: on debian, the version is lower and I have to use
ledger -f ledger.dat -b "2016/06/01" -e "2016/07/01" reg | sort -n

# Note:
# To convert to pdf, as ClearFacts needs pdf files,
# you can use vim myfile.txt -c "hardcopy > myfile.ps | q"; ps2pdf myfile.ps myfile.pdf; rm -v myfile.ps
