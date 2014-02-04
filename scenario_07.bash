#!/bin/bash

main() {
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
cat > description.txt <<EOF
Write an awk program (one-liner is also ok) that prints only the
highest salary from the testdata_1.txt file.

Put your awk program into a file called answer.awk in the
directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             awk -f answer.awk testdata_1.txt
EOF
}

generate_help_file() {
cat > help.txt <<EOF
Chapter 5 Useful "One-liners" (p45)
Chapter 6.7 BEGIN and END Special Patterns (p53-p54)
EOF
}

check_that_answer_prints_only_the_highest_salary() {
    FACIT_FILE=$(mktemp)
    cat > ${FACIT_FILE} <<EOF
21860
EOF
    ACTUAL_FILE=$(mktemp)
    awk -f answer.awk testdata_1.txt > ${ACTUAL_FILE} 2> /dev/null
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