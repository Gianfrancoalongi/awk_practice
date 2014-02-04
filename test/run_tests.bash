#!/bin/bash

DONE="Verified - you are done"
NOT_DONE="No - you are not done"

main() {
   for((x=1;x<=9;x++))
   do
       if [[ ${x} -lt 10 ]]
       then
	   NUM=0${x}
       else
	   NUM=${x}
       fi
       pushd ../ &> /dev/null
       bash scenario_${NUM}.bash &> /dev/null
       test_that_verification_fails_for_scenario ${NUM}
       solution_for_scenario_${NUM}
       test_that_verification_passes_for_scenario ${NUM}
       rm answer.awk &> /dev/null
       rm {description,help}.txt
       popd &> /dev/null
   done
}

solution_for_scenario_01() {
    echo '{print $2}' > answer.awk
}

solution_for_scenario_02() {
    echo '$6 == "m"' > answer.awk
}

solution_for_scenario_03() {
    echo 'BEGIN {FS=","} ; $6 == "m"' > answer.awk
}

solution_for_scenario_04() {
    echo 'BEGIN {RS=":";FS=","} ; $7 > 42' > answer.awk
}

solution_for_scenario_05() {
    echo '($4/356) > 3 && ($7 > 40) && ($3 < 21500)' > answer.awk
}

solution_for_scenario_06() {
    echo '$5 == 4 {printf "%-10s %-10i\n",$2,$4}' > answer.awk
}

solution_for_scenario_07() {
    echo 'NR > 1 && $3 > max { max = $3 }; END {print max}' > answer.awk
}

solution_for_scenario_08() {
    echo 'BEGIN{FS=","};NR > 1 {($6 == "m")?++m:++f};END{print m, f}' > answer.awk
}

solution_for_scenario_09() {
    cat > answer.awk <<EOF
{ for(n=1;n<=NF;n++) arr[$n]++ }
END { for (i=0;i<length(arr);i++) print i, arr[i] }
EOF
}

test_that_verification_fails_for_scenario() {
    if [[ $(bash scenario_${1}.bash --verify) == ${NOT_DONE} ]]
    then
    	echo "T${1}_neg passed"
    else
    	echo "T${1}_neg failed"
    fi
}

test_that_verification_passes_for_scenario() {
    if [[ $(bash scenario_${1}.bash --verify) == ${DONE} ]]
    then
	echo "T${1}_pos passed"
    else
	echo "T${1}_pos failed"
    fi
}

main
