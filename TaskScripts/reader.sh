#!/bin/bash

## Requirements : 2 files for comparison, and an output register file


# attach variables to the two files that need to be compared
sourceFile1=$1
sourceFile2=$2

# give a filename to dump output, for Dev phase drop the '> $notepad'
notepad=$3

# nested while loop below
while read cline
do
        while read dline
        do
                if [[ $cline == $dline ]]
                then
                        echo $cline > $notepad
                fi
        done < $sourceFile1
done < $sourceFile2

# refine the output for use
sort $notepad | uniq -u >&1 |  tee $notepad


