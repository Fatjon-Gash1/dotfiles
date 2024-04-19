#!/bin/bash

currentSink=$(pamixer --get-default-sink)

if [[ $currentSink == *"52"* ]]; then
	pactl set-default-sink 66
elif [[ $currentSink == *"66"* ]]; then
	pactl set-default-sink 52
else
	echo "current sink is: ${currentSink}"
fi
