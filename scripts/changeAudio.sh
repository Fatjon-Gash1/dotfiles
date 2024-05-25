#!/bin/bash

currentSink=$(pamixer --get-default-sink)

if [[ $currentSink == *"52"* || $currentSink == *"55"* ]]; then
	pactl set-default-sink 66 || pactl set-default-sink 71
elif [[ $currentSink == *"66"* || $currentSink == *"71"* ]]; then
	pactl set-default-sink 52 || pactl set-default-sink 55
else
	echo "current sink is: ${currentSink}"
fi
