#!/bin/bash

source /root/env.sh 

OUTPUT_FILE=hosts.json

mkdir -p $OUTPUT_DIR

cd $ANSIBLE_DIR
git checkout $GIT_BRANCH    
git pull origin $GIT_BRANCH  

echo Generating output: $OUTPUT_DIR/$OUTPUT_FILE

ansible-inventory -i $ANSIBLE_DIR/$INVENTORY_FILE --list | jq '[ .[] | select(has("hosts")) ] | [ .[].hosts ] | flatten | unique' | sponge $OUTPUT_DIR/$OUTPUT_FILE

#debug
#cat $OUTPUT_DIR/$OUTPUT_FILE

echo "Hosts request done"