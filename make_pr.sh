#!/bin/bash

usage() {
  echo "Usage: make_pr.sh -b {master branch} -h {feature branch}"
  echo "Default for -b is master_newui"
  echo "Default for -h is the current git branch"
  exit 1
}


while getopts ":b:h:H" opt; do
  case $opt in
    b)
      master=${OPTARG}
    ;;
    h)
      feature=${OPTARG}
    ;;
    H)
      usage
    ;;
    \?)
      echo "invalid argument"
      usage
    ;;
  esac
done

if [ -b ${master} ]; then
  master="master_newui"
fi

if [ -h ${feature} ]; then
  feature=$(git symbolic-ref --short -q HEAD)
fi

echo Making PR for ${feature} branch against ${master} branch
read -p "Press Enter to continue, Ctrl-C to quit"

TEMPLATE="https://gist.githubusercontent.com/hcopperm/e2eba762b43132852ecc/raw/6c984daab450c55268a698aa82bc8f70436f95aa/gistfile1.txt"
FILENAME=`mktemp ${feature}XXX`
curl $TEMPLATE > $FILENAME
sed -i.bak "s/{TICKET}/${feature}/" $FILENAME
vi --nofork $FILENAME
hub pull-request -h onelogin:${feature} -b onelogin:${master} --file $FILENAME
rm $FILENAME
rm "$FILENAME.bak"
