#!/bin/bash

ANSWER_FILE=answer_11.awk
SCENARIO_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

main() {
    . ${SCENARIO_DIR}/functions.bash
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_prints_image_from_dot_matrix_description
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > ${DESCRIPTION_FILE} <<EOF
Write an awk program (one-liner is also ok) that produces ascii 
images based on the dot matrix description in testdata_6.txt.
A dot matrix description is a sequence semicolon-delimited 
coordinates [y x](;) which starts with a description of the image
height and width. Thus 3 3;1 3;2 1;2 3;3 2;3 3
would describe the following image (t=0 for the glider).
  @
@ @
 @@
The initial pair (3 3) describes the height and width of the image.
The images are to be built of @'s.

Put your awk program into a file called ${ANSWER_FILE} in the
directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             awk -f ${ANSWER_FILE} testdata_6.txt
EOF
}

generate_help_file() {
cat > ${HELP_FILE} <<EOF
Chapter 9.4 The for Statement (p75-p76)
Chapter 10.8 Multi-dimensional Arrays (p86-p87)
Chapter 12 User-defined Functions (p95-p99)
EOF
}


check_that_answer_prints_image_from_dot_matrix_description() {
    FACIT_FILE=$(mktemp /tmp/AWKPRACTICE_XXXXXXXX)
    cat > ${FACIT_FILE} <<EOF
@@@@@  @@  @@  @  @@
@   @  @    @  @ @
@@@@@  @ @@ @  @@
@   @  @ @@ @  @ @
@   @   @  @   @  @@
EOF
    check_answer ${FACIT_FILE} ${SCENARIO_DIR}/testdata_6.txt
    # ACTUAL_FILE=$(mktemp /tmp/AWKPRACTICE_XXXXXXXX)
    # awk -f ${ANSWER_FILE} testdata_6.txt > ${ACTUAL_FILE} 2> /dev/null
    # diff -b ${FACIT_FILE} ${ACTUAL_FILE} &> /dev/null
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
