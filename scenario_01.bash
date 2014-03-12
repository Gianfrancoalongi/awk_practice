#!/bin/bash

ANSWER_FILE=answer_01.awk
SCENARIO_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

main() {
    . ${SCENARIO_DIR}/functions.bash
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_prints_second_column
	else
	    generate_description_file
	    generate_help_file
	    bash ${SCENARIO_DIR}/user_text.bash $0
	fi
}

generate_description_file() {
echo "Writing description to ${DESCRIPTION_FILE}"
cat > ${DESCRIPTION_FILE} <<EOF
Write an awk program (one-liner is also ok) that prints the
second column from the testdata_1.txt file.

Put your awk program into a file called ${ANSWER_FILE} in the 
directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             awk -f ${ANSWER_FILE} testdata_1.txt
EOF
}

generate_help_file() {
echo "Writing help to ${HELP_FILE}"
cat > ${HELP_FILE} <<EOF
Chapter 2 Getting Started with awk (p13-p20)
EOF
}

check_that_answer_prints_second_column() {
    FACIT_FILE=$(mktemp /tmp/AWKPRACTICE_FACIT_XXXXXXXX)
    cat > ${FACIT_FILE} <<EOF
Name.
manuel
jonny
becka
emilio
emily
marcus
rodriguez
eron
lisie
john
martina
frank
sarah
lars
sandro
andre
patrick
tony
angelica
EOF

    check_answer ${FACIT_FILE} ${SCENARIO_DIR}/testdata_1.txt
    # ACTUAL_FILE=$(mktemp /tmp/AWKPRACTICE_XXXXXXXX)
    # awk -f ${ANSWER_FILE} testdata_1.txt > ${ACTUAL_FILE} 2> /dev/null
    # diff -q ${FACIT_FILE} ${ACTUAL_FILE}  &> /dev/null
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
