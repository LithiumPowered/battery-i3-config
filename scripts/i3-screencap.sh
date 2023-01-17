#!/usr/bin/env bash

RECORDING_DIRS=~/Videos/.recordings
SCREENCAP_DIRS=~/Pictures/.screencaps

IMG_REC=~/.config/i3/scripts/img_rec.jpg
IMG_CAP=~/.config/i3/scripts/img_cap.jpg

TIMESTAMP=`date +"%Y-%m-%d_%H:%M:%S"`
REPLACE_ID=192519

screencap-region-record() {
    mkdir -p "$RECORDING_DIRS"
    CURRENT=$(date +%F_%H:%M-%S)

    hacksaw -c FFFFFF | {
        IFS=+x read -r w h x y
        dunst-msg close

        w=$((w + w % 2))
        h=$((h + 2 % 2))

        timeout 5 ffmpeg                  \
            -v 16                         \
            -r 30                         \
            -f x11grab                    \
            -s "${w}x${h}"                \
            -i ":0.0+$x,$y"               \
            -preset superfast             \
            -c:v h264                     \
            -pix_fmt yuv420p              \
            -crf 20                       \
            "$RECORDING_DIRS/$CURRENT.mp4"
    }

    dunstify                                            \
        -a "i3-screencap"                               \
        -i $IMG_REC                                     \
        -r $REPLACE_ID                                       \
        "Region recorded! [$(date +'%H:%M:%S')]"        \
        "<i>Saved...</i> <b>$RECORDING_DIRS</b>"
}

screencap-primary() {
    mkdir -p $SCREENCAP_DIRS
    PRIMARY=`xrandr | rg primary | cut -d ' ' -f1`

    shotgun -s -f png $SCREENCAP_DIRS/$PRIMARY\_$TIMESTAMP.png

    dunstify                                            \
        -a "i3-screencap"                               \
        -i $IMG_CAP                                     \
        -r $REPLACE_ID                                       \
        "Screencap taken! [$(date +'%H:%M:%S')]"        \
        "<i>Saved...</i> <b>$SCREENCAP_DIRS</b>"
}

# Unused
screencap-region() {
    mkdir -p $SCREENCAP_DIRS

    REGION=`hacksaw -c FFFFFF`
    shotgun -g $REGION -f png $SCREENCAP_DIRS/$REGION\_$TIMESTAMP.png

    dunstify                                            \
        -a "i3-screencap"                               \
        -i $IMG_CAP                                     \
        -r $REPLACE_ID                                       \
        "Region screencapped! [$(date +'%H:%M:%S')]"    \
        "<i>Saved...</i> <b>$SCREENCAP_DIRS</b>"
}

screencap-region-to-clipboard() {
    selection=$(hacksaw -c FFFFFF)  # add hacksaw arguments inside as you wish
    shotgun -g "$selection" - | xclip -t 'image/png' -selection clipboard

    dunstify                                            \
        -a "i3-screencap"                               \
        -i $IMG_CAP                                     \
        -r $REPLACE_ID                                  \
        "Screencap copied! [$(date +'%H:%M:%S')]"       \
        "<b>Saved to clipboard</b>"
}

case $1 in
    "primary") screencap-primary;;
    "region-select") screencap-region-to-clipboard;;
    "region-record") screencap-region-record;;
esac
