#!/usr/bin/env bash

pkill dunst

# Set Display
xrandr \
    --output eDP-1 --brightness $(cat ~/.cache/screen_brightness) --primary --mode 1920x1080 --pos 0x0 --rotate normal \
    --output DP-1 --off \
    --output HDMI-1 --off \
    --output DP-1 --off \
    --output HDMI-1 --off \
    --output DP-2 --off \
    --output HDMI-2 --off

# Wallpaper setter 
~/.fehbg

# Conky Launcher
~/.config/conky/launch.sh

# Play Greeter after wallpaper -- also starts dunst
dunstify \
  -u normal \
  -a "i3-startup-notification" \
  -i "~/.config/i3/scripts/img_home.jpg" \
  -r 192519 \
  " Hello ${USER^^}!" " <i>$(uname -r)</i>\n\n <b>$(fortune -sn 25)</b>\n"

exit 0
