#!/bin/sh

if [[ ! -d store ]]; then
	echo "store created"; mkdir store
fi

LOOPTOKEN=1
while [[  "$LOOPTOKEN" = "1"  ]] ; do #continue

	read -p "-> give me a name (case-sensitive) : " NAME

	if test -f store/$NAME.txt ; then # file is already there
		echo "->THIS RECORD IS PRE-EXISTING"
		echo "->Data in $NAME.txt : ";
		cat store/$NAME.txt
	else
		read -p "->Creating $NAME, input your data, then press ENTER - " DATA
		echo $DATA > store/$NAME.txt
	fi

	printf "\n-->do it again! 1 for yes"
	read LOOPTOKEN

done
