#!/bin/bash

declare -a opcodes
while read -d ',' opcode
do
	opcodes+=("$opcode")
done < input.txt

function intcode () {
	local i=0
	for code in "${opcodes[@]}"
	do
		if [[ $(( $i % 4)) -eq 0  ]]; then
			n1=${opcodes[$(($i+1))]}
			n2=${opcodes[$(($i+2))]}
			case "$code" in
				"99")
					echo "${opcodes[0]}"
					;;
				"1")
					sum=$((${opcodes[$(($n1))]}+${opcodes[$(($n2))]}))
					pos=${opcodes[$(($i+3))]}
					opcodes[$pos]=$sum
					;;
				"2")
					mult=$((${opcodes[$(($n1))]}*${opcodes[$(($n2))]}))
					pos=${opcodes[$(($i+3))]}
					opcodes[$pos]=$mult
					;;
			esac
		fi
		i=$(($i+1))
	done
}

opcodesClone=$opcodes

for i in {0..99}
do
	for j in {0..99}
	do
		opcodes[1]=$i
		opcodes[2]=$j
		result=$(intcode)
		if [[ "$result" -eq 19690720 ]]; then
			echo "$i$j"
		fi
		opcodes=$opcodesClone
	done
done
