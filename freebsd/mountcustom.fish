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

# tar00:
geli attach -k "$KEYLOCATION/encryption_tar00.key" "/dev/da0p1"
zpool import tar00
