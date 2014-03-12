#!/bin/bash

ANSWER_FILE=answer_07.awk
SCENARIO_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

main() {
    . ${SCENARIO_DIR}/functions.bash
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_prints_only_the_highest_salary
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > ${DESCRIPTION_FILE} <<EOF
Write an awk program (one-liner is also ok) that prints only the
highest salary from the testdata_1.txt file.

Put your awk program into a file called ${ANSWER_FILE} in the
directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             awk -f ${ANSWER_FILE} testdata_1.txt
EOF
}

generate_help_file() {
cat > ${HELP_FILE} <<EOF
Chapter 5 Useful "One-liners" (p45)
Chapter 6.7 BEGIN and END Special Patterns (p53-p54)
Chapter 13.2 Built-in Variables that Convey Information (p102-p103)
             specifically NR
EOF
}

check_that_answer_prints_only_the_highest_salary() {
    FACIT_FILE=$(mktemp /tmp/AWKPRACTICE_XXXXXXXX)
    cat > ${FACIT_FILE} <<EOF
21860
EOF
    check_answer ${FACIT_FILE} ${SCENARIO_DIR}/testdata_1.txt
    # ACTUAL_FILE=$(mktemp /tmp/AWKPRACTICE_XXXXXXXX)
    # awk -f ${ANSWER_FILE} testdata_1.txt > ${ACTUAL_FILE} 2> /dev/null
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
