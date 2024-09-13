#!/bin/bash

# Get the list of connected displays
connected_displays=$(hyprctl monitors -j | jq -r '.[] | .name')

# Check if the laptop monitor is connected
if echo "$connected_displays" | grep -q "eDP-1"; then
  laptop_monitor="eDP-1"
elif echo "$connected_displays" | grep -q "eDP-2"; then
  laptop_monitor="eDP-2"
else
  laptop_monitor="eDP-0"
fi

# Disable the laptop monitor if external monitors are connected
if [ -n "$laptop_monitor" ] && echo "$connected_displays" | grep -q "DP-1" && echo "$connected_displays" | grep -q "HDMI-A-1"; then
  hyprctl keyword monitor "$laptop_monitor,disable"
else
  hyprctl keyword monitor "$laptop_monitor,1920x1080@120,3440x0,1"
  # bind this monitor to workspace 1
  hyrctl keyword workspace "workspace=1,monitor:$laptop_monitor,default:true"
  #disable other monitors
  hyprctl keyword monitor "DP-1,disable"
  hyprctl keyword monitor "HDMI-A-1,disable"
fi

# reset monitor
hyprctl keyword monitor "DP-1,3440x1440@100,1x0,1"
hyprctl keyword monitor "DP-1,3440x1440@100,0x0,1"
hyprctl keyword monitor "HDMI-A-1,1920x1080@60,0x0,1,transform,1"
hyprctl keyword monitor "HDMI-A-1,1920x1080@60,-1080x0,1,transform,1"

# rebind workspace
hyrctl keyword workspace "workspace=1,monitor:DP-1,default:true"
hyrctl keyword workspace "workspace=2,monitor:HDMI-A-1"
# Bind lid switch
hyprctl keyword bindl ",switch:on:Lid Switch,exec,hyprctl keyword monitor "$laptop_monitor",disable"
hyprctl keyword bindl ",switch:off:Lid Switch,exec,hyprctl keyword monitor "$laptop_monitor",1920x1080@120,3440x0,1"
