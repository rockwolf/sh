#!/usr/local/bin/fish

################################################################################
# Author: Andy Nagels
# Date: 2015-03-04
#
# mousemover.sh:
# This is a small script that triggers a keyboard event
# to keep the screen from blanking when watching movies on the web.
# Ctr+C to quit.
################################################################################

set INTERVAL 300 # interval in seconds

while true
    #swarp 20 20
    swarp 1460 20
    sleep $INTERVAL
    swarp 30 50
    #swarp 1490 50
    sleep $INTERVAL
end
