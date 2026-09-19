#!/bin/sh
# Record the CWD of the focused Kitty terminal's shell, so new terminals
# (Super+Return) open where the last focused terminal was. Does nothing
# when focus is on a non-terminal, preserving the previous value.
info=$(hyprctl activewindow -j 2>/dev/null) || exit 0
class=$(printf '%s' "$info" | python3 -c 'import sys,json; print(json.load(sys.stdin).get("class") or "")')
[ "$class" = kitty ] || exit 0
pid=$(printf '%s' "$info" | python3 -c 'import sys,json; print(json.load(sys.stdin).get("pid") or "")')
[ -n "$pid" ] || exit 0

descendants() {
    for c in $(pgrep -P "$1" 2>/dev/null); do
        printf '%s\n' "$c"
        descendants "$c"
    done
}

# A fresh window may not have spawned its shell yet; retry briefly.
tries=0
cands=""
while [ -z "$cands" ] && [ "$tries" -lt 6 ]; do
    cands=$(descendants "$pid")
    [ -n "$cands" ] || { sleep 0.2; tries=$((tries + 1)); }
done

cwd=""
fallback=""
for p in $cands; do
    d=$(readlink "/proc/$p/cwd" 2>/dev/null) || continue
    [ -d "$d" ] || continue
    fallback=$d
    if tr '\0' ' ' <"/proc/$p/comm" 2>/dev/null | grep -Eq '(^| )(sh|bash|zsh|fish)$'; then
        cwd=$d
        break
    fi
done
[ -z "$cwd" ] && cwd=$fallback
[ -n "$cwd" ] || exit 0
mkdir -p ~/.cache/kitty
printf '%s' "$cwd" >~/.cache/kitty/last_cwd
