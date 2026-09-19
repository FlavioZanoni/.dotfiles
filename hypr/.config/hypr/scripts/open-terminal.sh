#!/bin/sh
# Open Kitty in the last directory visited by any fish shell.
dir=$(cat ~/.cache/kitty/last_cwd 2>/dev/null)
[ -d "$dir" ] || dir=$HOME
exec kitty --directory "$dir"
