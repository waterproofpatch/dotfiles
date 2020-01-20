BL=$(pmset -g batt | grep -o "\d\{1,3\}%")
echo $BL
