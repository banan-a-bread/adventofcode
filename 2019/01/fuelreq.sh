#!/bin/bash

function fuelForFuel () {
	local mass=$1
	local fuelNeeded=$((($mass/3)-2))
	if [[ "$fuelNeeded" -ge 0 ]]
	then
		fuelSum=$(($fuelSum+$fuelNeeded))
		fuelForFuel $fuelNeeded
	fi
}

fuelSum=0
while read mass
do
	fuelNeeded=$((($mass/3)-2))
	fuelForFuel $fuelNeeded
	fuelSum=$(($fuelSum+$fuelNeeded))
done < input.txt

echo $fuelSum

