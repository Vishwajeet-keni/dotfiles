#!/bin/bash
if [ "$1" = "on" ]; then
  nmcli radio wifi on
elif [ "$1" = "off" ]; then
  nmcli radio wifi off
fi

ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d':' -f2)
icon=$( [ -n "$ssid" ] && echo "" || echo "󰖪" )

echo "{\"icon\":\"$icon\", \"ssid\":\"$ssid\"}"      
