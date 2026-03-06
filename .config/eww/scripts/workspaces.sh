#!/bin/bash

# Get current workspace from hyprctl (without jq)
current_workspace=$(hyprctl activeworkspace | grep "ID" | awk '{print $3}')

# Get all workspaces (without jq)
workspaces=$(hyprctl workspaces | grep "ID" | awk '{print $3}' | sort -n | tr '\n' ' ')

# Format as JSON manually
workspaces_clean=$(echo $workspaces | xargs | tr ' ' ',')
echo "{\"current\": $current_workspace, \"workspaces\": [$workspaces_clean]}"
