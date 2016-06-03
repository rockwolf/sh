#!/usr/local/bin/fish

################################################################################
# Author: Andy Nagels
# Date: 2016-06-03
#
# umountcustom.fish:
# Script that allows mounting of discs in an easy way.
################################################################################

set DATEFORMAT "%Y-%m-%d"
set TIMEFORMAT "%H:%M"

switch $argv[1]
case "-h"
    echo "umountcustom.fish [-h|tar00|data01]"
    echo "Note: Needs to be run as root."
case "tar00"
    echo Unmounting tar00...
    zpool export tar00
    geli detach /dev/da0p1
    echo Done. 
    true
case "data01"
    echo Unmounting data01...
    zpool export data01
    geli detach /dev/ada2
    geli detach /dev/ada3
    echo Done. 
    true
case '*'
    echo Unknown option $argv[1].
    false
end
