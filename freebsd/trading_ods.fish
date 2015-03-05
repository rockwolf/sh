#!/usr/local/bin/fish

################################################################################
# Author: Andy Nagels
# Date: 2015-03-05
#
# trading_ods.fish:
# This script cd's to the prd dir for nintai
# and loads the given ods with soffice.
################################################################################

set DIR $HOME/nintai/prd/doc
set ODS trade_20140311_V001_position_trading.ods

cd $DIR
soffice $ODS&
