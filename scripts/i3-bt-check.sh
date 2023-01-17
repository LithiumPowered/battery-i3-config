#!/usr/bin/env bash

BT_CHECK="$(bluetooth | cut -f2 -d '=' | xargs -0)"

case $BT_CHECK in
     *"on"*)
         dunstify -r 192519 --icon=~/.config/i3/scripts/img_bt.jpg "BT Status" "Bluetooth is Enabled"
     ;;
    *"off"*)
        dunstify -r 192519 --icon=~/.config/i3/scripts/img_bt.jpg "BT Status" "Bluetooth is Disabled"
     ;;
    *)
        dunstify -r 192519 --icon=~/.config/i3/scripts/img_bt.jpg "BT Error" "$(bluetooth)"
     ;;
esac
