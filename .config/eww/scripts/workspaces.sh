#!/bin/bash
hyprctl workspaces -j | jq -r '.[] | "\(.id) \(.windows)"'   
