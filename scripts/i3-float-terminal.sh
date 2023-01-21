#!/usr/bin/env bash
 
SCREEN_DIM="$(xrandr | rg '\*' | choose 0)"
SCREEN_X="$(choose -f 'x' 0 <<< $SCREEN_DIM)"
SCREEN_Y="$(choose -f 'x' 1 <<< $SCREEN_DIM)"
 
POS="1,28"
TERM_X="$((SCREEN_X-SCREEN_X/3))"
TERM_Y="$((SCREEN_Y-SCREEN_Y/2))"
 
i3-scratchpad -d${TERM_X}x${TERM_Y} -p${POS} -mt -atl -t \
  "kitty --class=i3_float_term -1 --instance-group=i3_term_group"
