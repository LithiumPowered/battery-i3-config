# Get geometry information of the currently active window.
GEOMETRY=`xdotool getwindowgeometry $(xdotool getactivewindow)`
# Extract information about the dimensions of the window and divide
# both of them by 2.
DIMENSIONS=$(printf "$GEOMETRY" | grep -Po "[0-9]+x[0-9]+")
X=$(printf $DIMENSIONS | sed 's/x[0-9]\+//g')
Y=$(printf $DIMENSIONS | sed 's/[0-9]\+x//g')
X=$(expr $X / 2)
Y=$(expr $Y / 2)
# Move the mouse cursor to the middle of the active window.
xdotool mousemove -w $(xdotool getactivewindow) $X $Y
