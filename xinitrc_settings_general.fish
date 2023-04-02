#!/bin/sh

################################################################################
# Author: Andy Nagels
# Date: 2015-03-04
#
# xinitrc_settigs_general.sh:
# Load general settings like keyboard-layout, Xresources, etc. in xinitrc.
################################################################################

setxkbmap us -variant colemak
xmodmap -e "clear mod4"
xmodmap -e "keycode 113 = F20"
xrdb -nocpp -merge ~/.Xresources
xset s off
wacom_config.fish
