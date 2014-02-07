#!/bin/bash

main() {
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_prints_names_and_days_hired_of_all_on_floor_4
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > description.txt <<EOF
Write an awk program (one-liner is also ok) that prints names
and days hired for all employees on floor 4 from the file
testdata_1.txt. The output shall be in two columns, each column
10 characters wide, left justified, with square brackets around
each element, as follows

[lars      ][767       ]
[andre     ][1349      ]

Put your awk program into a file called answer.awk in the
directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             awk -f answer.awk testdata_1.txt
EOF
}

generate_help_file() {
cat > help.txt <<EOF
Chapter 4.1 The print Statement (p35-p35)
Chapter 4.2 Examples of print Statements (p35-p37)
Chapter 4.5 Using printf Statements for
            Fancier Printing (p38-p41)
EOF
}

check_that_answer_prints_names_and_days_hired_of_all_on_floor_4() {
    FACIT_FILE=$(mktemp)
    cat > ${FACIT_FILE} <<EOF
[becka     ][633       ]
[rodriguez ][766       ]
[eron      ][1330      ]
[sandro    ][1349      ]
[angelica  ][534       ]
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
