#!/bin/bash

main() {
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_prints_occurrences_of_numbers
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > description.txt <<EOF
Write an awk program (one-liner is also ok) that prints two 
columns, in the left column the numbers 0 to 9, and in the right 
column, the amount of occurrences of the number in the left column 
from the input file testdata_4.txt

Put your awk program into a file called answer.awk in the
directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             awk -f answer.awk testdata_4.txt
EOF
}

generate_help_file() {
cat > help.txt <<EOF
Chapter 9.4 The for Statement (p75-p76)
Chapter 10 Arrays in awk (p81-p88)
EOF
}

check_that_answer_prints_the_amount_of_males_and_females() {
    FACIT_FILE=$(mktemp)
    cat > ${FACIT_FILE} <<EOF
13 20
EOF
    ACTUAL_FILE=$(mktemp)
    awk -f answer.awk testdata_2.txt > ${ACTUAL_FILE} 2> /dev/null
    diff ${FACIT_FILE} ${ACTUAL_FILE} &> /dev/null
    if [[ $? == 0 ]]
    then
	RES='Verified - you are done'
    else
	RES='No - you are not done'
    fi
    rm ${FACIT_FILE} ${ACTUAL_FILE}
    echo ${RES}
}

main $@