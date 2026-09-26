#!/bin/sh
# Region screenshot to clipboard. While selecting, hyprpicker overlays a
# frozen frame of the screen, so video, menus and tooltips hold still and
# grim captures exactly what was shown. Falls back to a live selection when
# hyprpicker is not installed.
if command -v hyprpicker >/dev/null 2>&1; then
    hyprpicker -r -z &
    freeze=$!
    sleep 0.2
fi
area=$(slurp -b 000000a0) && grim -g "$area" - | wl-copy
[ -n "$freeze" ] && kill "$freeze" 2>/dev/null
