#!/usr/local/bin/fish

################################################################################
# Author: Andy Nagels
# Date: 2015-03-04
#
# timetokyo.fish:
# Script that shows clocks in different timezones.
# Used for display in DWM's status bar.
################################################################################

set DATEFORMAT "%Y-%m-%d"
set TIMEFORMAT "%H:%M"

while true
    set VAR0 (env TZ="Europe/Brussels" date +$DATEFORMAT)
    set VAR1 (env TZ="Europe/Brussels" date +$TIMEFORMAT)
    set VAR2 (env TZ="Asia/Tokyo" date +$TIMEFORMAT)
    set VAR3 (env TZ="America/New_York" date +$TIMEFORMAT)
    set VAR4 (env TZ="GMT" date +$TIMEFORMAT)
    xsetroot -name "[VL $VAR0][US $VAR3 | VL $VAR1 | 日本 $VAR2 | GMT $VAR4]"
    sleep 60
end
