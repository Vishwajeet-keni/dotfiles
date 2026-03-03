#!/bin/bash

# Get CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
if [ -z "$cpu_usage" ]; then
    cpu_usage=$(top -bn1 | grep "%Cpu" | awk '{print $2}')
fi

# Get disk usage for root (/)
disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

# Format CPU to one decimal place
cpu_usage=$(printf "%.1f" "$cpu_usage")

# Output in JSON format
echo "{\"cpu\": $cpu_usage, \"disk\": $disk_usage}"
