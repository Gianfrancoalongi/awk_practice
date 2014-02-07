#!/bin/bash

main() {
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_generates_dot_matrix_description
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > description.txt <<EOF
Write an awk program (one-liner is also ok) that produces a dot 
matrix description of the ascii image in testdata_7.txt.
A dot matrix description is a semicolon-delimited sequence of 
coordinates [y x](;) which starts with a description of the image
height and width. Thus, given the following input ascii image,
  @
@ @
 @@
3 3;1 3;2 1;2 3;3 2;3 3 would be the output from the awk program.
The initial pair (3 3) describes the height and width of the image.

An ascii image is defined as an rectangular matrix consisting of @'s
and spaces.

Put your awk program into a file called answer.awk in the
directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             awk -f answer.awk testdata_7.txt
EOF
}

generate_help_file() {
cat > help.txt <<EOF
Chapter 3.5 Specifying how Fields are Separated (p25-p29)
Chapter 9.4 The for Statement (p75-p76)
EOF
}


check_that_answer_generates_dot_matrix_description() {
    FACIT_FILE=$(mktemp)
    cat > ${FACIT_FILE} <<EOF
5 20;1 1;1 2;1 3;1 4;1 5;1 8;1 9;1 12;1 13;1 16;1 19;1 20;2 1;2 5;2 8;2 13;2 16;2 18;3 1;3 2;3 3;3 4;3 5;3 8;3 10;3 11;3 13;3 16;3 17;4 1;4 5;4 8;4 10;4 11;4 13;4 16;4 18;5 1;5 5;5 9;5 12;5 16;5 19;5 20
EOF
    ACTUAL_FILE=$(mktemp)
    awk -f answer.awk testdata_7.txt > ${ACTUAL_FILE} 2> /dev/null
    diff -b ${FACIT_FILE} ${ACTUAL_FILE} &> /dev/null
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
