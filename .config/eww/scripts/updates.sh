#!/bin/bash
pacman_u=$(pacman -Qu | wc -l)     # pacman updates
yay_u=$(yay -Qu | wc -l)           # yay updates --> slow
count=$((pacman_u+yay_u))

echo "{\"count\":\"$count\",\"pacman_u\":\"$pacman_u\",\"yay_u\":\"$yay_u\"}"
