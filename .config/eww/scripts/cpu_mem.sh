#!/bin/bash

# Get CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
if [ -z "$cpu_usage" ]; then
    cpu_usage=$(top -bn1 | grep "%Cpu" | awk '{print $2}')
fi

# Get memory usage percentage
memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

# Format to one decimal place
cpu_usage=$(printf "%.1f" "$cpu_usage")
memory_usage=$(printf "%.1f" "$memory_usage")

# Output valid JSON - using "memory" key (not "disk")
echo "{\"cpu\":$cpu_usage,\"memory\":$memory_usage}"
