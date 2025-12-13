#!/bin/bash
level=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

# Set icon
if [ "$status" = "Charging" ]; then
  icon=""
else
  case $level in
    9[0-9]|100) icon="" ;;
    [6-8][0-9]) icon="" ;;
    [4-5][0-9]) icon="" ;;
    [3-9][0-9]) icon="" ;;
    *) icon="" ;;
  esac
fi

# status
class="$status"
[ "$level" -le 30 ] && class="critical"

echo "{\"icon\":\"$icon\", \"level\":\"$level\", \"class\":\"$class\"}"   
