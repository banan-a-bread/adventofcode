#!/bin/bash

min=235741
max=706948
possible_passwords=0

for (( n="$min"; n<="$max"; n++ ))
do 
	current_digit=${n:0:1}
	has_double=0
	in_double=0
	is_double=0
	is_decreasing=0
	for (( i = 1; i < ${#n}; ++i )); do
		previous_digit=$current_digit
		current_digit=${n:$i:1}
		if [[ "$current_digit" -lt $previous_digit ]]; then
			is_decreasing=1
			break;
		fi
		if [[ "$current_digit" -eq "$previous_digit" && "$has_double" -eq 0 ]]; then
			if [[ "$in_double" -eq 0 ]]; then
				is_double=1
				in_double=1
			else
				is_double=0
			fi
		else
			in_double=0
			if [[ "$is_double" -eq 1 ]]; then
				has_double=1
			fi
		fi
	done
	# this is a hack if the last two digits are the same, thus producing a valid double
	has_double=$is_double
	if [[ "$has_double" -eq 1  && "$is_decreasing" -eq 0 ]]; then
		possible_passwords=$(($possible_passwords+1))
	fi
done
echo $possible_passwords
