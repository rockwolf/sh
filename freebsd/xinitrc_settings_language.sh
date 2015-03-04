#!/bin/sh

################################################################################
# Author: Andy Nagels
# Date: 2015-03-04
#
# xinitrc_settigs_language.sh:
# Export language settings and UIM related vars.
################################################################################

#export LANG=ca_ES.ISO8859-1 LLC_ALL=ca_ES.ISO8859-1
#export LANG=es_ES.ISO8859-1 LLC_ALL=es_ES.ISO8859-1
#export LANG=es_ES.UTF-8 LLC_ALL=es_ES.UTF-8

export LANG=ja_JP.UTF-8 LLC_ALL=ja_JP.UTF-8
export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
export XMODIFIERS=@im='uim'

# Start uim-xim for Japanese language input.
uim-xim
