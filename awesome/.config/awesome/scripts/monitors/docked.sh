#!/bin/zsh
xrandr --output HDMI-1-0 --mode 1920x1080 --rate 60 --pos 0x0 --rotate left \
       --output DP-1-0 --mode 3440x1440 --rate 100 --pos 1080x0 --primary \
       --output eDP-2 --off
