#!/bin/bash
set -e -o pipefail

DEFAULT=("vpc-for-aws-batch" "batch-from-step-functions")

while getopts "aps:" optKey; do
  case "$optKey" in
    a)
        is_apply=true
        ;;
    p)
        is_apply=false
        ;;
    s)
        stacks=${OPTARG}
        ;;
    \?)
        ;;
  esac
done

if [ -z "${stacks}" ]; then
    stacks=(${DEFAULT[*]})
elif [ ${stacks: -1:1} = "/" ]; then
    stacks=${stacks/%?/}
fi

for stack in "${stacks[@]}"
do
    pushd `dirname $0`/${stack} >/dev/null

    if "${is_apply}"; then
        message="Apply:"
        option="--no-confirm-changeset"
    else
        message="Plan:"
        option="--no-execute-changeset"
    fi

    echo -------------------------------------
    echo ${message} ${stack}
    echo -------------------------------------
    sam build -t template.yaml
    sam deploy -t template.yaml --no-fail-on-empty-changeset ${option}

    popd >/dev/null
done
