#!/bin/sh

################################################################################
# Author: Andy Nagels
# Date: 2015-03-04
#
# timetokyo.sh:
# Script that shows clocks in different timezones.
# Used for display in DWM's status bar.
################################################################################

DATEFORMAT="%Y-%m-%d"
TIMEFORMAT="%H:%M"

while true; do
    VAR0=`TZ="Europe/Brussels" date +$DATEFORMAT`
    VAR1=`TZ="Europe/Brussels" date +$TIMEFORMAT`
    VAR2=`TZ="Asia/Tokyo" date +$TIMEFORMAT`
    VAR3=`TZ="US/Eastern" date +$TIMEFORMAT`
    VAR4=`TZ="GMT" date +$TIMEFORMAT`
    xsetroot -name "[VL $VAR0][US $VAR3 | VL $VAR1 | 日本 $VAR2 | GMT $VAR4]"
    sleep 60
done
