#
# bash helper functions
#

DESCRIPTION_FILE=$(pwd)/description.txt
HELP_FILE=$(pwd)/help.txt

check_answer() {

    EXPECTED_FILE=${1}
    TESTDATA_FILE=${2}

    ACTUAL_FILE=$(mktemp /tmp/AWKPRACTICE_ACTUAL_XXXXXXXX)
    awk -f ${ANSWER_FILE} ${TESTDATA_FILE} > ${ACTUAL_FILE} 2> /dev/null
    diff -b -q ${FACIT_FILE} ${ACTUAL_FILE}  &> /dev/null 

    if [[ $? == 0 ]]
    then
        RES='Verified - you are done'
    else
        RES='No - you are not done'
    fi
    rm ${FACIT_FILE} ${ACTUAL_FILE}
    echo ${RES} 

}
