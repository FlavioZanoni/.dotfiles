#!/bin/sh
# Screen share picker for xdg-desktop-portal-hyprland (see xdph.conf).
# Chromium/Electron apps (Chrome, Meet, Discord) open several portal
# sessions per share, and each one would pop the picker. Show the rofi
# picker (share-menu.py) once and replay its selection for requests arriving
# shortly after.
cache=${XDG_RUNTIME_DIR:-/tmp}/share-picker.selection
ttl=30

# Serialize concurrent requests so the later ones wait for the first pick.
exec 9>"$cache.lock"
flock 9

if [ -s "$cache" ] && [ $(( $(date +%s) - $(stat -c %Y "$cache") )) -lt "$ttl" ]; then
    cat "$cache"
    exit 0
fi

if command -v rofi >/dev/null 2>&1; then
    out=$("$(dirname "$0")/share-menu.py" "$@")
else
    out=$(hyprland-share-picker "$@")
fi
status=$?
printf '%s\n' "$out"
case $out in
    *'[SELECTION]'*) printf '%s\n' "$out" | grep -F '[SELECTION]' > "$cache" ;;
    *) rm -f "$cache" ;;
esac
exit $status
