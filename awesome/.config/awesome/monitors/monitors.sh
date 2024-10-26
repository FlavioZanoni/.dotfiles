#!/bin/zsh

SCRIPT_DIR="$(dirname "$0")"
DOCKED_OPEN_SCRIPT="$SCRIPT_DIR/docked-open.sh"
DEFAULT_SCRIPT="$SCRIPT_DIR/default.sh"
DOCKED_SCRIPT="$SCRIPT_DIR/docked.sh"

# Check the lid state
LID_STATE=$(cat /proc/acpi/button/lid/LID0/state | awk '{print $2}')

# Check if external monitors are connected
MONITOR_COUNT=$(xrandr | grep -w "connected" | wc -l)

if [[ "$LID_STATE" == "open" && "$MONITOR_COUNT" -gt 1 ]]; then
    $DOCKED_OPEN_SCRIPT
elif [[ "$LID_STATE" == "open" && "$MONITOR_COUNT" -eq 1 ]]; then
    $DEFAULT_SCRIPT
elif [[ "$LID_STATE" == "closed" && "$MONITOR_COUNT" -gt 1 ]]; then
    $DOCKED_SCRIPT
else
    echo "No valid condition met."
fi
