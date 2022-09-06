#!/bin/bash
delay=$1
wasoffc="true"
wasoffn="true"
counter=0
IDSET=''
while [ true ]
do
situc=$( xset -q | sed -n 's/^.*Caps Lock:\s*\(\S*\).*$/\1/p' )
situn=$( xset -q | sed -n 's/^.*Num Lock:\s*\(\S*\).*$/\1/p' )
if [ $situc == "on" ] && [ ${wasoffc} == "true" ];
then
    ./notify-send.sh --close=$IDSET
    IDSET=$(./notify-send.sh "Caps Lock" "ON" -t $delay -i /usr/share/icons/kbled-indicator/capson.png --print-id)
    wasoffc="false"
fi
if [ ${wasoffc} == "false" ] && [ $situc == "off" ];
then
    ./notify-send.sh --close=$IDSET
    IDSET=$(./notify-send.sh "Caps Lock" "OFF" -t $delay -i /usr/share/icons/kbled-indicator/capsoff.png --print-id)
    wasoffc="true"
fi

if [ $situn == "on" ] && [ ${wasoffn} == "true" ];
then
    ./notify-send.sh --close=$IDSET
    IDSET=$(./notify-send.sh "Num Lock" "ON"  -t $delay -i /usr/share/icons/kbled-indicator/numon.png --print-id)
    wasoffn="false"
fi
if [ $situn == "off" ] && [ ${wasoffn} == "false" ];
then
    ./notify-send.sh --close=$IDSET
    IDSET=$(./notify-send.sh "Num Lock" "OFF"  -t $delay -i /usr/share/icons/kbled-indicator/numoff.png --print-id)
    wasoffn="true"
fi
sleep 0.05
counter=$(($counter + 1))
if [ $counter == $((delay*20)) ];
then
	IDSET=''
fi
done
