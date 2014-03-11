#!/bin/bash

main() {
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
cat > description.txt <<EOF
Write an awk program (one-liner is also ok) that prints all
entries which are males from the testdata_1.txt file.

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

check_that_answer_prints_only_males() {
    FACIT_FILE=$(mktemp)
    cat > ${FACIT_FILE} <<EOF
7369   manuel     21720   936           7       m      31
7499   jonny      21374   511           5       m      35
7566   emilio     21562   1032          5       m      36
7242   marcus     21564   1057          1       m      33
7184   rodriguez  21176   766           4       m      41
7208   eron       21546   1330          4       m      48
7576   john       21445   1498          3       m      44
7327   frank      21077   1336          6       m      42
7533   lars       21514   767           5       m      27
7775   sandro     21701   1349          4       m      43
7852   andre      21826   1172          6       m      48
7190   patrick    21577   898           5       m      44
7673   tony       21860   597           3       m      34
EOF
    ACTUAL_FILE=$(mktemp)
    awk -f answer.awk testdata_1.txt > ${ACTUAL_FILE} 2> /dev/null
    diff -b -q ${FACIT_FILE} ${ACTUAL_FILE} &> /dev/null
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