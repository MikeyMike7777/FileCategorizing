#!/bin/bash
#
# file: activity.sh
# author: Michael Mathews
# course: CSI 3336
# due date: 2/13/23

# date modified: 2/13/23
#       - file created

if [[ $# -ne 1 ]]
then
    echo "usage: activity <directory>
fi

echo $@

files=`find $@ -type f -mtime -1`
count=0
total=0
for file in $files
do
    size=`ls -l $file | awk '{print $5}'`
    total=$(( $total + $size ))
    (( count++ ))
done

echo "active: $count ($total bytes)"

files=`find $@ -type f -mtime +1 -mtime -3`
count=0
total=0
for file in $files
do
    size=`ls -l $file | awk '{print $5}'`
    total=$(( $total + $size ))
    (( count++ ))
done

echo "recent: $count ($total bytes)"

files=`find $@ -type f -mtime +3`
count=0
total=0
for file in $files
do
    size=`ls -l $file | awk '{print $5}'`
    total=$(( $total + $size ))
    (( count++ ))
done

echo "idle: $count ($total bytes)"
