#!/bin/bash

cat <<EOF
=================================================================
EOF
cat description.txt
cat <<EOF
=================================================================
Reading in 'The Awk Manual'     http://tinyurl.com/the-awk-manual

EOF
cat help.txt
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
