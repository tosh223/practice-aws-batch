#!/bin/bash

current_dir=$(cd $(dirname $0);pwd)
stack_name=`echo "$current_dir" | sed -e 's/.*\/\([^\/]*\)$/\1/'`

# aws cloudformation validate-template --template-body file://template.yml

aws cloudformation deploy \
  --stack-name $stack_name \
  --template-file template.yml \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides EnableNATGateway=true
