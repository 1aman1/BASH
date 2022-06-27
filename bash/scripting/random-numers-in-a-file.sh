#!/bin/bash

# it can be anything
LIMIT=` date  "+%Y" `

i=0
while [ $i -lt 10 ]
do
        RANDOM_NUMER=$(( $RANDOM % $LIMIT + 1 ))
        i=$(($i+1))
        #echo "$i, $RANDOM_NUMER"
        echo "$i, $RANDOM_NUMER" >> inputFile
done
