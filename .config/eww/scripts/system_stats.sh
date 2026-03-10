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

# Gets cpu temp
temp_lvl=$(sensors coretemp-isa-0000 | grep "Package id 0" | awk '{print $4}' | tr -d '+°C')
``
temp_icon=$(echo "$temp_lvl" | awk '{
  t = $1 + 0
  if (t < 40)      print ""
  else if (t < 50) print ""
  else if (t < 60) print ""
  else if (t < 70) print ""
  else             print ""
}')

temp_state=$(echo "$temp_lvl" | awk '{
  t = $1 + 0
  if (t < 40)      print "temp-cool"
  else if (t < 50) print "temp-normal"
  else if (t < 60) print "temp-warm"
  else if (t < 70) print "temp-hot"
  else             print "temp-crit"
}')


# Output valid JSON - using "memory" key (not "disk")
echo "{\"cpu\":\"$cpu_usage\",\"memory\":\"$memory_usage\",\"temp_lvl\":\"$temp_lvl\",\"temp_icon\":\"$temp_icon\",\"temp_state\":\"$temp_state\"}"
