#!/bin/sh

################################################################################
# Author: Andy Nagels
# Date: 2015-03-04
#
# startwm.sh:
# Start window manager.
################################################################################

#xrandr --output --screen 0 --mode 1440x900
#xrandr --output --screen 1 --right-of --mode 1440x900
#DISPLAY=:0.1 exec dwm &
#DISPLAY=:0.0 exec dwm
exec dwm
#exec mwm
#exec xmonad
#exec spectrwm
