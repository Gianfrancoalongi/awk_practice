#!/bin/bash

ANSWER_FILE=answer_08.awk
SCENARIO_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

main() {
    . ${SCENARIO_DIR}/functions.bash
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_prints_the_amount_of_males_and_females
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > ${DESCRIPTION_FILE} <<EOF
Write an awk program (one-liner is also ok) that prints two 
numbers: total amount of males, and total amount of females, from
the file testdata_2.txt. Ensure the printed numbers are in the 
order of total amount of males, and then total amount of females.

Put your awk program into a file called ${ANSWER_FILE} in the
directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             awk -f ${ANSWER_FILE} testdata_2.txt
EOF
}

generate_help_file() {
cat > ${HELP_FILE} <<EOF
Chapter 3.1 How Input is Split into Records (p21-p22)
Chapter 5 Useful "One-liners" (p45)
Chapter 8.3 Arithmetic Operators (p60-p61)
Chapter 8.8 Increment Operators (p66-p67)
Chapter 8.11 Conditional Expressions (p69-p70)
Chapter 9.1 The if Statement (p73)
EOF
}

check_that_answer_prints_the_amount_of_males_and_females() {
    FACIT_FILE=$(mktemp /tmp/AWKPRACTICE_XXXXXXXX)
    cat > ${FACIT_FILE} <<EOF
13 6
EOF
    check_answer ${FACIT_FILE} ${SCENARIO_DIR}/testdata_2.txt
    # ACTUAL_FILE=$(mktemp /tmp/AWKPRACTICE_XXXXXXXX)
    # awk -f ${ANSWER_FILE} testdata_2.txt > ${ACTUAL_FILE} 2> /dev/null
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
