#!/usr/local/bin/fish

################################################################################
# Author: Andy Nagels
# Date: 2015-08-01
#
# mountcustom.fish:
# Script that allows mounting of discs in an easy way.
################################################################################

set DATEFORMAT "%Y-%m-%d"
set TIMEFORMAT "%H:%M"
set KEYLOCATION "/bootdir/boot/"

switch $argv[1]
case "-h"
    echo "mountcustom.fish [-h|sea00|tar00|data01]"
    echo "Note: Needs to be run as root."
case "tar00"
    echo Mounting tar00...
    geli attach -k "$KEYLOCATION/encryption_tar00.key" "/dev/da0p1"
    zpool import tar00
    echo Done. 
    true
case "sea00"
    echo Mounting sea00...
    geli attach -k "$KEYLOCATION/encryption_sea00.key" "/dev/da0p1"
    zpool import sea00
    echo Done. 
    true
case "data01"
    echo Mounting data01...
    geli attach /dev/ada2
    geli attach /dev/ada3
    zpool import data01
    echo Done. 
    true
case "max03"
    echo Mounting max03...
    geli attach /dev/da0p1
    zpool import movies00
    echo Done. 
    true
case "max04"
    echo Mounting max04...
    geli attach /dev/da0p1
    zpool import max04 
    echo Done. 
    true
case "max05"
    echo Mounting max05...
    geli attach /dev/da0p1
    zpool import max05 
    echo Done. 
    true
case "android"
    echo Mounting android...
    simple-mtpfs /mnt/android -o allow_other
    echo Done.
    true
case '*'
    echo Unknown option $argv[1].
    false
end
