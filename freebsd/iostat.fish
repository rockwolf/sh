#!/usr/local/bin/fish

################################################################################
# Author: Andy Nagels
# Date: 2017-08-26
#
# iostat.sh:
# This is a small script that shows the output of zpool iostat,
# but in a loop with refresh.
################################################################################

set INTERVAL 2 # interval in seconds

while true
    clear
    zpool iostat
    echo "Last update: "(date +"%Y%m%d %H:%M:%S")
    sleep $INTERVAL
end
