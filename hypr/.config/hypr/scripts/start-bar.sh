#!/bin/sh
# Safe to invoke on login or manually after installing Waybar.
command -v waybar >/dev/null 2>&1 || exit 0
pgrep -x waybar >/dev/null && exit 0
exec waybar
