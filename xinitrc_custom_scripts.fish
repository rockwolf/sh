#!/usr/local/bin/fish

################################################################################
# Author: Andy Nagels
# Date: 2015-03-18
#
# xinitrc_custom_scripts.fish:
# Execute custom scripts and applications in xinitrc.
################################################################################

urxvtd &
wallpaper.fish &
timetokyo.fish &
emacs --daemon &
