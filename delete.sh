#!/bin/bash
set -e -o pipefail

while getopts "s:" optKey; do
  case "$optKey" in
    s)
        stacks=${OPTARG}
        ;;
    \?)
        ;;
  esac
done

if [ -z "${stacks}" ]; then
    echo "Set -s [your stack name]"
    exit 0
elif [ ${stacks: -1:1} = "/" ]; then
    stacks=${stacks/%?/}
fi

for stack in "${stacks[@]}"
do
    echo -------------------------------------
    echo Delete stack: ${stack}
    echo -------------------------------------
    aws cloudformation delete-stack --stack-name ${stack}
    if [ $? = 0 ]; then
        echo "The request was sent successfully."
    fi
done
