#!/bin/bash

usage() {
  echo "Usage: make_pr.sh [-b {master branch}] [-h {feature branch}] [-D] [-H]"
  echo ""
  echo "Default for -b is master_newui"
  echo "Default for -h is the current git branch"
  echo "Default for -dr is no dry-run"
  echo "Default editor with options is ${MY_EDITOR_WITH_OPTIONS}"
  echo ""
  echo "Bracketed options are optional"
  echo
  echo "-D is a 'dry run' that skips the github upload and leaves the files in the current directory"
  echo "-H prints this usage information"
  echo ""
  exit 1
}

MY_EDITOR_WITH_OPTIONS=${EDITOR}
[ -z "$MY_EDITOR_WITH_OPTIONS" ] && MY_EDITOR_WITH_OPTIONS='/usr/bin/vim --nofork'

while getopts ":b:h:HD" opt; do
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
	D)
	  dryrun=true
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

TEMPLATE="https://gist.githubusercontent.com/hcopperm/f194bcb820c8b73359cc/raw/db25461872b254d0873e1a70c8f91ac85d8cd9f7/pull-request-template.md"
FILENAME=`mktemp ${feature}XXX`
curl $TEMPLATE > "$FILENAME"
sed -i.bak "s/{TICKET}/${feature}/" "$FILENAME"
${MY_EDITOR_WITH_OPTIONS} "$FILENAME"

# [ -z ${dryrun} ] && hub pull-request -h onelogin:${feature} -b onelogin:${master} -F $FILENAME && rm "$FILENAME" "$FILENAME.bak"
[ -z ${dryrun} ] && echo pull-request -h onelogin:${feature} -b onelogin:${master} -F $FILENAME && rm "$FILENAME" "$FILENAME.bak"
