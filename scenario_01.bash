#!/bin/bash

main() {
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_prints_second_column ${2}
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

Put your awk program into a file called answer.awk. 
Your answer will be executed the following way by the system.

             awk -f answer.awk testdata_1.txt
EOF
}

generate_help_file() {
cat > help.txt <<EOF
Chapter 2 Getting Started with awk (p13-p20)
EOF
}