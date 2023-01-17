#!/usr/bin/env bash

pkill xidlehook
xset dpms 0 0 3600 &

xidlehook \
    --not-when-fullscreen \
    --not-when-audio \
    --timer 300 \
        'xrandr --output eDP-1 --brightness 0.1' \
        'xrandr --output eDP-1 --brightness $(cat ~/.cache/screen_brightness)' \
    --timer 300 \
        'xrandr --output eDP-1 --brightness $(cat ~/.cache/screen_brightness); betterlockscreen -l dim --display 1 --off 120' \
        '' \
    --timer 3600 \
        'systemctl suspend' \
        ''
