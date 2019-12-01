#!/bin/bash

fuelSum=0
while read mass
do
	fuelNeeded=$((($mass/3)-2))
	fuelSum=$(($fuelSum+$fuelNeeded))
done < input.txt

echo $fuelSum
