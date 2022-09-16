#!/bin/bash
delay=$1
counter=0
IDSET=''
wasoffc="true"
wasoffn="true"

while [ true ]
do

situc=$( xset -q | sed -n 's/^.*Caps Lock:\s*\(\S*\).*$/\1/p' )
situn=$( xset -q | sed -n 's/^.*Num Lock:\s*\(\S*\).*$/\1/p' )

if [ $situc == "on" ] && [ ${wasoffc} == "true" ];
then
    ./notifire --close=$IDSET
    IDSET=$(./notifire "Caps Lock" "ON" -t $delay -i /usr/share/icons/kbled-indicator/capson.png -p)
    wasoffc="false"
fi
if [ ${wasoffc} == "false" ] && [ $situc == "off" ];
then
    ./notifire --close=$IDSET
    IDSET=$(./notifire "Caps Lock" "OFF" -t $delay -i /usr/share/icons/kbled-indicator/capsoff.png -p)
    wasoffc="true"
fi

if [ $situn == "on" ] && [ ${wasoffn} == "true" ];
then
    ./notifire --close=$IDSET
    IDSET=$(./notifire "Num Lock" "ON"  -t $delay -i /usr/share/icons/kbled-indicator/numon.png -p)
    wasoffn="false"
fi
if [ $situn == "off" ] && [ ${wasoffn} == "false" ];
then
    ./notifire --close=$IDSET
    IDSET=$(./notifire "Num Lock" "OFF"  -t $delay -i /usr/share/icons/kbled-indicator/numoff.png -p)
    wasoffn="true"
fi
echo $IDSET
sleep 0.05
counter=$(($counter + 1))
if [ $counter == $((delay*20)) ];
then
	IDSET=''
fi
done
