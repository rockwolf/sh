#!/bin/sh

#echo "Using toc-file $1"
echo "Burning all wav files in directory..."
cdrdao write --speed 8 --device 3,0,0 $1
#wodim -v -eject speed=8 dev=/dev/sg0 -pad -audio *.wav

#wodim -v -eject $1
