#!/bin/bash

init() {
	total=$(( $1 + 0 ))
	per_count=0
	prog_count=0
	each_chunk=$(($total /100))
	percent_counter=0
	size_each_prog=1
	printf "\033[s"
	window_width=$(tput cols)
	progress_bar_width=$window_width
	#echo $window_width
	each_chunk_prog=$(( $(( $total )) / 50  ))
}

update() {
	per_count=$(($per_count+1))
	prog_count=$(($prog_count+1))
	if [ $per_count -eq $each_chunk ] && [ $percent_counter -lt 100 ]; then
		per_count=0
		
		#bar="$bar#"
		percent_counter=$(($percent_counter+1))

	fi

	if [ $prog_count -eq $(( $each_chunk_prog + 0 )) ]; then
		bar="$bar="
		prog_count=0
	fi

	printf "$bar $percent_counter%% \033[u"

}

printf "Progress:\n"
count=0
# max should always be greater  or equal to 100
max=800
init max
while [ $count -lt $max ]; do
	sleep .01
	count=$((count+1))
	update 
done
printf "\n"
