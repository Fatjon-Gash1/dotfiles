#!/bin/bash

# Select random walpaper
wal -q -i ~/Images/wallpapers/

# Load current pywal color scheme
source "$HOME/.cache/wal/colors.sh"

# Coply color file to waybar folder
cp ~/.cache/wal/colors-waybar.css ~/.config/waybar/

# Set the new wallpaper
swww img $wallpaper --transition-type none 
~/.config/waybar/launch_wb.sh
