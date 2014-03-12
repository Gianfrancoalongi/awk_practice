#!/bin/bash

ANSWER_FILE=answer_10.awk
SCENARIO_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

main() {
    . ${SCENARIO_DIR}/functions.bash
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_prints_rectangles_from_input
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > description.txt <<EOF
Write an awk program (one-liner is also ok) that prints rectangles
with width, height and using the letter as defined by the
definitions in the testdata_5.txt file.
Every line is a rectangle definition, width height and which 
character to use when printing the rectangle. 
Thus 10 5 . means a 10 character wide, 5 character high rectangle
made from . (dot). It would look like this

		 ..........
		 ..........
		 ..........
		 ..........
		 ..........

Put your awk program into a file called ${ANSWER_FILE} in the
directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             awk -f ${ANSWER_FILE} testdata_5.txt
EOF
}

generate_help_file() {
cat > help.txt <<EOF
Chapter 8.4 String Concatenation (p61)
Chapter 9.4 The for Statement (p75-p76)
Chapter 12 User-defined Functions (p95-p99)
EOF
}


check_that_answer_prints_rectangles_from_input() {
    FACIT_FILE=$(mktemp /tmp/AWKPRACTICE_XXXXXXXX)
    cat > ${FACIT_FILE} <<EOF
@@@@@@@@@@
@@@@@@@@@@
@@@@@@@@@@
####
####
!
####
####
@@@@@@@@@@
@@@@@@@@@@
@@@@@@@@@@
EOF
    check_answer ${FACIT_FILE} ${SCENARIO_DIR}/testdata_5.txt
    # ACTUAL_FILE=$(mktemp /tmp/AWKPRACTICE_XXXXXXXX)
    # awk -f ${ANSWER_FILE} testdata_5.txt > ${ACTUAL_FILE} 2> /dev/null
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
