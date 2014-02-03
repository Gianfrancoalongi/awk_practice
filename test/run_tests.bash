#!/bin/bash

DONE="Verified - you are done"
NOT_DONE="No - you are not done"

main() {
   for((x=1;x<=4;x++))
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
