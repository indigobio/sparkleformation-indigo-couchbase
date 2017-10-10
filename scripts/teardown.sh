#!/bin/bash -e

# Tear down the stack
stack=$(aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE DELETE_FAILED \
  --query 'StackSummaries[].StackId' --output table | grep ${environment}-couchbase-${AWS_DEFAULT_REGION} \
  | awk '{print $2}')

cmd="aws cloudformation delete-stack --stack-name $stack"
run_if_yes "$cmd"

