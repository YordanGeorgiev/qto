#!/bin/bash
# file:src/bash/scripts/docker-entry-point.sh 
if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi

# eof file:src/bash/scripts/docker-entry-point.sh 
