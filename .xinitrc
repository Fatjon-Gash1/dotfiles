#!/bin/sh

export XCURSOR_SIZE=24

xrandr --output HDMI-0 --primary --auto --output DVI-D-0 --auto --left-of HDMI-0

xset s 900 900
xset dpms 900 900 900

exec i3
