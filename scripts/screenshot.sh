#!/bin/bash

dir="$HOME/Images/screenshots/"
name="sc_$(date +%d.%m.%Y_%H%M%S).png"

option_1="Area"
option_2="Area and edit"
option_3="Fullscreen"
option_4="Fullscreen and edit"
option_5="Color picker"

options="$option_1\n$option_2\n$option_3\n$option_4\n$option_5"

choice=$(echo -e "$options" | rofi -dmenu -i -no-show-icons -l 5 -width 30 -p "Screenshot")

case $choice in
	$option_1)
		grim -g "$(slurp)" $dir$name
		;;
	$option_2)
		grim -g "$(slurp)" - | swappy -f - 
		;;
	$option_3)
		sleep 1
		grim $dir$name
		;;
	$option_4)
		sleep 1
		grim - | swappy -f - 
		;;
	$option_5)
		wl-color-picker clipboard
		;;
esac
