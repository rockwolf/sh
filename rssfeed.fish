#!/usr/local/bin/fish

################################################################################
# Author: Andy Nagels
# Date: 2017-04-19
#
# rssfeed.fish
# Script that groups feeds with rsstail.
################################################################################

set FEED1 "http://news.kitco.com/rss/"
set TIMEFORMAT "%H:%M"

function fUsage
    echo "rssfeed [-h|-t <type>]"
    echo "example of types: gold"
    exit 1
end

rsstail -u $FEED1
#set args (getopt -s sh ht: $argv); or fUsage
#echo "1:" $args
#set args (fish -c "for el in $args; echo \$el; end")
#echo "2:" $args
#
#set i 1
#while true #"$i" < $argcount
#    echo "|"$args[$i]"|"
#    switch $args[$i]
#        case "-h"
#            fUsage
#        case "-t"
#            set i (math "$i + 1") 
#            echo $args[$i]
#            switch $args[$i]
#                case "gold"
#                    rsstail -u $FEED1
#                case "*"
#                    echo "Unknown feed"
#            end
#        case "--"
#            break
#    end
#    set i (math "$i + 1")
#end
exit 0
