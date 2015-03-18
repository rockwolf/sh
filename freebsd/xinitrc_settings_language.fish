#!/usr/local/bin/fish

################################################################################
# Author: Andy Nagels
# Date: 2015-03-18
#
# xinitrc_settigs_language.fish:
# Export language settings and UIM related vars.
################################################################################

#set -x LANG=ca_ES.ISO8859-1 LLC_ALL=ca_ES.ISO8859-1
#set -x LANG=es_ES.ISO8859-1 LLC_ALL=es_ES.ISO8859-1
#set -x LANG=es_ES.UTF-8 LLC_ALL=es_ES.UTF-8

set -x LANG=ja_JP.UTF-8 LLC_ALL=ja_JP.UTF-8
set -x GTK_IM_MODULE='uim'
set -x QT_IM_MODULE='uim'
set -x XMODIFIERS=@im='uim'

# Start uim-xim for Japanese language input.
uim-xim
