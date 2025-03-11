#!/bin/sh

# Screensaver settings
xset s off
xset s noblank
xset -dpms

# Touchpad settings
xinput set-prop 9 "libinput Tapping Enabled" 1
xinput set-prop 9 309 1
xinput set-prop 9 333 30
libinput-gestures &

exec i3
