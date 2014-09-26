#!/bin/bash
TEMPLATE="https://gist.githubusercontent.com/hcopperm/e2eba762b43132852ecc/raw/38523eb60a84764dd955f51c9ae5d599458d594b/gistfile1.txt"
FILENAME=`mktemp pr_templateXXX`
curl $TEMPLATE > $FILENAME
vi --nofork $FILENAME
if [ $# == 2 ]
then hub pull-request -h onelogin:$1 -b onelogin:$2 --file $FILENAME
else hub pull-request -h onelogin:$1 -b onelogin:master_newui --file $FILENAME
fi
rm $FILENAME
