#!/bin/bash
echo "---Infos---"
coreNumber=$(grep -c ^processor /proc/cpuinfo)
echo "Nombre de coeur CPU: "$coreNumber
echo "Temp 0: $(($(cat /sys/class/thermal/thermal_zone0/temp)/1000))"".""$(($(cat /sys/class/thermal/thermal_zone0/temp)%1000))°C"
lscpu | grep MHz

echo "---Début---"
startTime=$(date +%s)
for f in 1 2 3 4 5 6 7 8 9 10
do
	#vcgencmd measure_temp
	sysbench --test=cpu --cpu-max-prime=15000 --num-threads=$coreNumber run >/devnull 2>&1
	echo "Temp $f: $(($(cat /sys/class/thermal/thermal_zone0/temp)/1000))"".""$(($(cat /sys/class/thermal/thermal_zone0/temp)%1000))°C"
done
endTime=$(date +%s)
echo "---Fin---"

exectionTime=$(($endTime-$startTime))
echo "Terminée en $(($exectionTime/60))m$(($exectionTime%60))s."

unset -v endTime
unset -v exectionTime