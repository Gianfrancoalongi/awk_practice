#!/bin/bash

SCENARIO_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
DESCRIPTION_FILE=${SCENARIO_DIR}/description.txt
HELP_FILE=${SCENARIO_DIR}/help.txt

cat <<EOF
=================================================================
EOF
cat ${DESCRIPTION_FILE}
cat <<EOF
=================================================================
Reading in 'The Awk Manual'     http://tinyurl.com/the-awk-manual

EOF
cat ${HELP_FILE}
cat <<EOF
=================================================================
Run this script as
       bash $1 --verify
when you think you are done
=================================================================
You can always read 
    description.txt To know what you need to do
    help.txt        To get Pointers on what to read
=================================================================
EOF
