#!/bin/bash

source /scripts/constants
source /scripts/utils.sh

exdir=$(executing_dir)

cd "$exdir"

docker build --network=build -t searchathing/nas "$exdir"
if [ "$?" != "0" ]; then echo "build failed"; exit 1; fi
