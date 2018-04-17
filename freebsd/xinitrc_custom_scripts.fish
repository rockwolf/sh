#!/usr/local/bin/fish

################################################################################
# Author: Andy Nagels
# Date: 2015-03-18
#
# xinitrc_custom_scripts.fish:
# Execute custom scripts and applications in xinitrc.
################################################################################

urxvtd &
wallpaper.fish
timetokyo.fish
stalonetray &
xmodmap /usr/local/rc/xmodmap/xmodmaprc
xmodmap -e "keycode 115 = F20" # So StumpWM can use Super_L as a prefix key
