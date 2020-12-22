#!/usr/local/bin/fish

################################################################################
# Author: Andy Nagels
# Date: 2015-03-18
#
# xinitrc_settigs_language.fish:
# Export language settings and UIM related vars.
################################################################################

#set -Ux LANG=ca_ES.ISO8859-1 LC_ALL=ca_ES.ISO8859-1
#set -Ux LANG=es_ES.ISO8859-1 LC_ALL=es_ES.ISO8859-1
#set -Ux LANG=es_ES.UTF-8 LLC_ALL=es_ES.UTF-8

#set -Ux LANG "ja_JP.UTF-8"
#set -Ux LC_ALL "ja_JP.UTF-8"
#set -Ux LLC_ALL "ja_JP.UTF-8"
#set -Ux LC_CTYPE "ja_JP.UTF-8"
set -Ux LANG "en_US.UTF-8"
set -Ux LC_ALL "en_US.UTF-8"
set -Ux LLC_ALL "en_US.UTF-8"
set -Ux LC_CTYPE "en_US.UTF-8"
set -Ux XMODIFIERS "@im=fcitx"
set -Ux GTK_IM_MODULE "fcitx"
set -Ux QT_IM_MODULE "xim"

# Start uim-xim for Japanese language input.
# 2015-07-30: switched to ibus
# See: http://redundancy.redundancy.org/fbsd_japanese.html
#uim-xim
fcitx -r -d
