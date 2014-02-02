#!/bin/bash

main() {
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_prints_second_column
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > description.txt <<EOF
Write an awk program (one-liner is also ok) that prints the
second column from the testdata_1.txt file.

Put your awk program into a file called answer.awk in the 
directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             awk -f answer.awk testdata_1.txt
EOF
}

generate_help_file() {
cat > help.txt <<EOF
Chapter 2 Getting Started with awk (p13-p20)
EOF
}

check_that_answer_prints_second_column() {
    FACIT_FILE=$(mktemp)
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
    ACTUAL_FILE=$(mktemp)
    awk -f answer.awk testdata_1.txt > ${ACTUAL_FILE} 2> /dev/null
    diff -q ${FACIT_FILE} ${ACTUAL_FILE}  &> /dev/null
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