#!/bin/bash

sourceFile1=$1
sourceFile2=$1

notepad=$2

while read line; do
# reading each line
if [ $line == $line ]
	then echo $line >> notepad.txt
fi
done < $sourceFile1
