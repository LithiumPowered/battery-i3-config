#!/usr/bin/env bash

pkill dunst

xrandr \
    --output eDP-1 \
    --primary \
    --mode 1920x1080 \
    --pos 0x0 \
    --brightness $(cat ~/.cache/screen_brightness) \
    --refresh 60.01 \
    --rotate normal

~/.fehbg
~/.config/polybar/launch.sh
~/.config/conky/launch.sh

dunstify \
  -u normal \
  -a "i3-startup-notification" \
  -i "~/.config/i3/scripts/img_home.jpg" \
  -r 192519 \
  " Hello ${USER^^}!" " <i>$(uname -r)</i>\n\n <b>$(fortune -sn 25)</b>\n"
