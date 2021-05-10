#!/bin/bash

sourceFile1=$1
sourceFile2=$2

notepad=$3

while read cline
do
        while read dline
        do
                if [[ $cline == $dline ]]
                then
                        echo $cline
                fi
        done < $sourceFile1
done < $sourceFile2
