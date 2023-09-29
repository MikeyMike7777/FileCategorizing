#!/bin/bash
# file: genRandom.sh
# author: Michael Mathews
# course: CSI 3336
# due date: 2/13/23

# date modified: 2/13/23
#       - file created

num=$1
low=$2
upper=$3
counter=1

if [[ "$#" == 0 ]]
then
    num=10
    low=0
    upper=9999
fi

if [[ "$#" != 3 && "$#" != 0 ]]
then
    echo "usage: ./genRandom.sh (int)numOfRandom (int)UpperBound (int)LowerBound"
else
    while [[ $counter -le $num ]]
    do
        echo $((( $RANDOM % ($upper - 1)) + $low))
        let counter+=1
    done
fi
