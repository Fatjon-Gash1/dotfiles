# End waybar processes
killall waybar
pkill waybar

sleep 0.2
# Load confings 
	waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css &

