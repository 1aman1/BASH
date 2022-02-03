#!/bin/bash
Year=`date "+%Y"`
Month=`date "+%B"`
DATESUFFIX=`date +%m%d%y`
DESTNFILE=/destn/logFolder/Mongo-$DATESUFFIX

mongodump -u backup_user -p "backupUSER" -o $DESTNFILE

if [ ! -e $DESTNFILE ]
    then echo -e "BACKUP NOT DONE - EXITING!!"
        exit
    else
        echo "------------------------------------------Completed STEP 1/4 - dump taken---------------------------------------------"
fi

cd /destn/logFolder
zip -r Mongo-$DATESUFFIX.zip Mongo-$DATESUFFIX
echo "--------------------------------------------- Completed STEP 2/4 - compressed dump file---------------------------------------------"

cp /destn/logFolder/Mongo-$DATESUFFIX.zip /DB_BACKUPS/Mongo/$Year/$Month/$DATESUFFIX/
echo "--------------------------------------------- Completed STEP 3/4 - Backedup---------------------------------------------"

rm -rf /destn/logFolder/Mongo-$DATESUFFIX.zip
rm -rf /destn/logFolder/Mongo-$DATESUFFIX
echo "--------------------------------------------- Completed STEP 4/4 - Deleted local file---------------------------------------------"

echo -e "\e[1;31m ---------Backup finished for $DATESUFFIX ----!!  \e[0m"
