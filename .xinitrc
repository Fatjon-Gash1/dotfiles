#!/bin/sh

xset s off
xset s noblank
xset -dpms

xremap ~/dotfiles/xremap/config.yml

exec i3
