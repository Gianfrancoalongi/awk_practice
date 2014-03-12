#!/bin/bash

ANSWER_FILE=answer_09.awk
SCENARIO_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

main() {
    . ${SCENARIO_DIR}/functions.bash
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
cat > ${DESCRIPTION_FILE} <<EOF
Write an awk program (one-liner is also ok) that prints two 
columns, in the left column the numbers 0 to 9, and in the right 
column, the amount of occurrences of the number in the left column 
from the input file testdata_4.txt

Put your awk program into a file called ${ANSWER_FILE} in the
directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             awk -f ${ANSWER_FILE} testdata_4.txt
EOF
}

generate_help_file() {
cat > ${HELP_FILE} <<EOF
Chapter 9.4 The for Statement (p75-p76)
Chapter 10 Arrays in awk (p81-p88)
EOF
}

check_that_answer_prints_occurrences_of_numbers() {
    FACIT_FILE=$(mktemp /tmp/AWKPRACTICE_XXXXXXXX)
    cat > ${FACIT_FILE} <<EOF
0 242
1 249
2 260
3 245
4 256
5 229
6 260
7 236
8 275
9 266
EOF
    check_answer ${FACIT_FILE} ${SCENARIO_DIR}/testdata_4.txt
    # ACTUAL_FILE=$(mktemp /tmp/AWKPRACTICE_XXXXXXXX)
    # awk -f ${ANSWER_FILE} testdata_4.txt > ${ACTUAL_FILE} 2> /dev/null
    # diff ${FACIT_FILE} ${ACTUAL_FILE} &> /dev/null
    # if [[ $? == 0 ]]
    # then
    #     RES='Verified - you are done'
    # else
    #     RES='No - you are not done'
    # fi
    # rm ${FACIT_FILE} ${ACTUAL_FILE}
    # echo ${RES}
}

main $@
