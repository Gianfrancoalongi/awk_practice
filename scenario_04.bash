#!/bin/bash

ANSWER_FILE=answer_04.awk
SCENARIO_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

main() {
    . ${SCENARIO_DIR}/functions.bash
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_prints_only_males
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > ${DESCRIPTION_FILE} <<EOF
Write an awk program (one-liner is also ok) that prints all
employee entries, such that the employee is older than 42, 
from the testdata_3.txt file.

Put your awk program into a file called ${ANSWER_FILE} in the 
directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             awk -f ${ANSWER_FILE} testdata_3.txt
EOF
}

generate_help_file() {
cat > ${HELP_FILE} <<EOF
Chapter 3.1 How Input is Split into Records (p21-p22)
Chapter 3.2 Examining Fields (p22-p23)
Chapter 3.5 Specifying how Fields are Separated (p25-p29)
EOF
}

check_that_answer_prints_only_males() {
    FACIT_FILE=$(mktemp /tmp/AWKPRACTICE_XXXXXXXX)
    cat > ${FACIT_FILE} <<EOF
7211,emily,21399,1253,1,f,49
7208,eron,21546,1330,4,m,48
7123,lisie,21158,645,5,f,43
7576,john,21445,1498,3,m,44
7493,sarah,21770,673,3,f,48
7775,sandro,21701,1349,4,m,43
7852,andre,21826,1172,6,m,48
7190,patrick,21577,898,5,m,44
EOF
    check_answer ${FACIT_FILE} ${SCENARIO_DIR}/testdata_3.txt
    # ACTUAL_FILE=$(mktemp /tmp/AWKPRACTICE_XXXXXXXX)
    # awk -f ${ANSWER_FILE} testdata_3.txt > ${ACTUAL_FILE} 2> /dev/null
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
