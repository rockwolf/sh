#!/usr/local/bin/fish

## Stylus
#xsetwacom set "wacom stylus" RawSample 8
#xsetwacom set "wacom stylus" PressureCurve 0 10 90 100
xsetwacom set "wacom stylus" Area 0 0 44800 29600
xsetwacom set "wacom stylus" Mode Relative

## Eraser
#xsetwacom set "wacom eraser" RawSample 8
#xsetwacom set "wacom eraser" PressureCurve 5 0 100 95
xsetwacom set "wacom eraser" Area 0 0 44800 29600
xsetwacom set "wacom eraser" Mode Relative

## Touch (2FGT)
#xsetwacom set "wacom touch" ScrollDistance 18
#xsetwacom set "wacom touch" TapTime 220

## Pad
#xsetwacom set "wacom pad" Button 1 "key ctrl t"  # key combination for toggle touch script
#xsetwacom set "wacom pad" Button 2 "key backspace"
#xsetwacom set "wacom pad" Button 3 3  # right mouse click
#xsetwacom set "wacom pad" Button 4 1  # left mouse click
