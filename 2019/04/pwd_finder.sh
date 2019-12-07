#!/bin/bash

min=235741
max=706948


#It is a six-digit number.
#The value is within the range given in your puzzle input.
#Two adjacent digits are the same (like 22 in 122345).
#Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).
#Other than the range rule, the following are true:
#
#111111 meets these criteria (double 11, never decreases).
#223450 does not meet these criteria (decreasing pair of digits 50).
#123789 does not meet these criteria (no double).
#112233 meets these criteria because the digits never decrease and all repeated digits are exactly two digits long.
#123444 no longer meets the criteria (the repeated 44 is part of a larger group of 444).
#111122 meets the criteria (even though 1 is repeated more than twice, it still contains a double 22).

possible_passwords=0

for (( n="$min"; n<="$max"; n++ ))
do 
	current_digit=${n:0:1}
	has_double=0
	in_double=0
	is_decreasing=0
	for (( i = 1; i < ${#n}; ++i )); do
		previous_digit=$current_digit
		current_digit=${n:$i:1}
		if [[ "$current_digit" -lt $previous_digit ]]; then
			is_decreasing=1
			break;
		fi
		if [[ "$current_digit" -eq "$previous_digit" ]]; then
				has_double=1
		fi
	done
	if [[ "$has_double" -eq 1  && "$is_decreasing" -eq 0 ]]; then
		possible_passwords=$(($possible_passwords+1))
	fi
done
echo $possible_passwords
