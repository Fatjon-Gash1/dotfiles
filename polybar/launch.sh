#!/bin/sh

killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 0.2; done

for m in $(polybar --list-monitors | cut -d: -f1); do
    MONITOR=$m polybar main >>"/tmp/polybar-$m.log" 2>&1 &
done
