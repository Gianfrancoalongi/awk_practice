#!/bin/bash

ANSWER_FILE=answer_05.awk
SCENARIO_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

main() {
    . ${SCENARIO_DIR}/functions.bash
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_prints_gt3y_gt40_lt21500
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > ${DESCRIPTION_FILE} <<EOF
Write an awk program (one-liner is also ok) that prints all
entries such that the person has been employed for more 
than 3 year, is older than 40 and earns less than 21500 from
the testdata_1.txt file.

Put your awk program into a file called ${ANSWER_FILE} in the 
directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             awk -f ${ANSWER_FILE} testdata_1.txt
EOF
}

generate_help_file() {
cat > ${HELP_FILE} <<EOF
Chapter 6.3 Comparison Expressions as Patterns (p51-p51)
Chapter 6.4 Boolean Operators and Patterns (p51-p52)
Chapter 6.5 Expressions as Patterns (p52-p52)
EOF
}

check_that_answer_prints_gt3y_gt40_lt21500() {
    FACIT_FILE=$(mktemp /tmp/AWKPRACTICE_XXXXXXXX)
    cat > ${FACIT_FILE} <<EOF
7211   emily      21399   1253          1       f      49
7576   john       21445   1498          3       m      44
7327   frank      21077   1336          6       m      42
EOF
    check_answer ${FACIT_FILE} ${SCENARIO_DIR}/testdata_1.txt
    # ACTUAL_FILE=$(mktemp /tmp/AWKPRACTICE_XXXXXXXX)
    # awk -f ${ANSWER_FILE} testdata_1.txt > ${ACTUAL_FILE} 2> /dev/null
    # diff -b -q ${FACIT_FILE} ${ACTUAL_FILE} &> /dev/null
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
