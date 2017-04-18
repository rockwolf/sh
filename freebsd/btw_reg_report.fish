#!/usr/local/bin/fish

################################################################################
# Author: Andy Nagels
# Date: 2016-08-23
#
# btw_reg_report.fish:
# Script that prepares data for the quarterly tax reports.
# It uses ledger data as a backend and also depends on vim for transforming
# the final report outputs from txt to pdf.
################################################################################

# 1st quarter - (1/1) until 03/31
# ledger -f ledger.dat --period "until 2014/04" reg
# 2nd quarter - from 04/01 until 06/30
# 3rd quarter - from 07/01 until 10/01
# 4th quarter - from 10/01 until 31/12"
# ledger -f ledger.dat --period "from 2015/10 until 2014/12" reg
# Note: on debian, the version is lower and I have to use
#ledger -f ledger.dat -b "2016/06/01" -e "2016/07/01" reg | sort -n

set USAGE "Usage: btw_reg_report.fish [Q1|Q2|Q3|Q4|month|-h]"
set -x TERMPREFIX ">>> "

function fUsage
    echo $USAGE
    exit 1
end

function fCmdGetExportName
  #reg_(date +%Y%m%d)_V001_btw_Q1
  #Q2
  #Q3
  #Q4
  #januari
  #februari
  #march
  #april
  #may
  #june
  #july
  #august
  #september
  #oktober
  #november
  #december
end

function fCmdExportToTxt
    ledger -f ledger.dat -b "2017/01/01" -e "2017/04/01" reg | sort -n > reg_(date +%Y%m%d)_V001_btw_Q1
end

function fParseArguments
  switch $argv
    case "-h"
      fUsage
    case "Q1"
      echo $TERMPREFIX"Q1 preparation of txt export"
      fCmdExportToTxt Q1
      echo $TERMPREFIX"Q1 convert txt to pdf"
      echo $TERMPREFIX"Q1 remove txt"
    case "Q2"
      echo $TERMPREFIX"Q2 preparation of txt export"
      fCmdExportToTxt Q2
      echo $TERMPREFIX"Q2 convert txt to pdf"
      echo $TERMPREFIX"Q2 remove txt"
    case "Q3"
      echo $TERMPREFIX"Q3 preparation of txt export"
      fCmdExportToTxt Q3
      echo $TERMPREFIX"Q3 convert txt to pdf"
      echo $TERMPREFIX"Q3 remove txt"
    case "Q4"
      echo $TERMPREFIX"Q4 preparation of txt export"
      fCmdExportToTxt Q4
      echo $TERMPREFIX"Q4 convert txt to pdf"
      echo $TERMPREFIX"Q4 remove txt"
    case '*'
      # Check if valid month, otherwise unknown option error.
      if $argv in januari februari march april may june july
      # Note: this is getting complex, better use another language for it. Python? Lisp?
      echo Unknown option $argv.
      fUsage
  end
end

set args (fish -c "for el in $args; echo \$el; end")
switch (count $args)
    case 0
        fParseArguments $argv[1]
    case '*'
        fUsage
end
# Note:
# To convert to pdf, as ClearFacts needs pdf files,
# you can use vim myfile.txt -c "hardcopy > myfile.ps | q"; ps2pdf myfile.ps myfile.pdf; rm -v myfile.ps
