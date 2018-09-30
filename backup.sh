#!/bin/bash
echo "************************************************************************"
echo "*"
echo "*           backup.sh"
echo "*"
echo "*            Ver 1.0"
echo "*"
echo "*"  2018/01/03 Created Takeshi Shibata
echo "*"  2018/01/03 Updated Takeshi Shibata
echo "*"
echo "************************************************************************"

#NOTICE: If Exec This Script, Must be root.

#Define of Backup Dir.
BKUPDIR1=/etc
BKUPDIR2=/var
BKUPDIR3=/home

#Define of Backup Storage
BKUPSTORAGE=/mnt/backup/
BKUPFILE1=${BKUPSTORAGE}backup-`date +%Y%m%d`.backup_1.tar.gz
BKUPFILE2=${BKUPSTORAGE}backup-`date +%Y%m%d`.backup_2.tar.gz
BKUPFILE3=${BKUPSTORAGE}backup-`date +%Y%m%d`.backup_3.tar.gz

#Define of Log files.
BKUPRESULTLOG=${BKUPSTORAGE}log/backup-result.log
BKUPLISTLOG1=${BKUPSTORAGE}log/backup-`date +%Y%m%d`_list_1.log
BKUPLISTLOG2=${BKUPSTORAGE}log/backup-`date +%Y%m%d`_list_2.log
BKUPLISTLOG3=${BKUPSTORAGE}log/backup-`date +%Y%m%d`_list_3.log

#Define of Flag File - If not exist this file, Exec Full Backup.
BKUPFLAGFILE=${BKUPSTORAGE}Backup_Result.FLG

#Logging of Backup Start
echo `date +%Y`"/"`date +%m`"/"`date +%d` `date +%H`":"`date +%M` "INFO" "Start of Data Backup" | tee -a ${BKUPRESULTLOG}

#Exec Data Backup
if [ -f ${BKUPFLAGFILE} ]; then
    ### Start of Exec Diff Backup ###
        echo "Exec Diff Backup"
    ### End of Exec Diff Backup ###

else
    ### Start of Exec Full Backup ###

      # Get Backup File List Number #1 (About /etc).
        echo `date +%Y`"/"`date +%m`"/"`date +%d` `date +%H`":"`date +%M` "INFO" "Exec ls -lRa ${BKUPDIR1} > ${BKUPLISTLOG1} 2>&1" | tee -a ${BKUPRESULTLOG}
        ls -lRa ${BKUPDIR1} > ${BKUPLISTLOG1} 2>&1
      # Get Data Backup Number #1.  
        echo `date +%Y`"/"`date +%m`"/"`date +%d` `date +%H`":"`date +%M` "INFO" "Exec tar cvzf ${BKUPFILE1} ${BKUPDIR1}" | tee -a ${BKUPRESULTLOG}
        tar cvzf ${BKUPFILE1} ${BKUPDIR1} > /dev/null 2>&1

        if [ $? -eq 0 ]; then
            echo `date +%Y`"/"`date +%m`"/"`date +%d` `date +%H`":"`date +%M` "INFO" "Backup #1 End. Exit Status=0" | tee -a ${BKUPRESULTLOG}
        else
            echo `date +%Y`"/"`date +%m`"/"`date +%d` `date +%H`":"`date +%M` "ERROR" "Backup #1 Error Detected." | tee -a ${BKUPRESULTLOG}
        fi

      # Get Backup File List Number #2 (About /var/log).
        echo `date +%Y`"/"`date +%m`"/"`date +%d` `date +%H`":"`date +%M` "INFO" "ls -lRa ${BKUPDIR2} > ${BKUPLISTLOG2} 2>&1" | tee -a ${BKUPRESULTLOG}
        ls -lRa ${BKUPDIR2} > ${BKUPLISTLOG2} 2>&1
      # Get Data Backup Number #2.  
        echo `date +%Y`"/"`date +%m`"/"`date +%d` `date +%H`":"`date +%M` "INFO" "Exec tar cvzf ${BKUPFILE2} ${BKUPDIR2}" | tee -a ${BKUPRESULTLOG}
        #tar cvzf ${BKUPFILE2} ${BKUPDIR2} > /dev/null 2>&1

        if [ $? -eq 0 ]; then
            echo `date +%Y`"/"`date +%m`"/"`date +%d` `date +%H`":"`date +%M` "INFO" "Backup #2 End. Exit Status=0" | tee -a ${BKUPRESULTLOG}
        else
            echo `date +%Y`"/"`date +%m`"/"`date +%d` `date +%H`":"`date +%M` "ERROR" "Backup #2 Error Detected." | tee -a ${BKUPRESULTLOG}
        fi

      # Get Backup File List Number #3 (About /home).
        echo `date +%Y`"/"`date +%m`"/"`date +%d` `date +%H`":"`date +%M` "INFO" "ls -lRa ${BKUPDIR3} > ${BKUPLISTLOG3} 2>&1" | tee -a ${BKUPRESULTLOG}
        ls -lRa ${BKUPDIR3} > ${BKUPLISTLOG3} 2>&1
      # Get Data Backup Number #3.  
        echo `date +%Y`"/"`date +%m`"/"`date +%d` `date +%H`":"`date +%M` "INFO" "Exec tar cvzf ${BKUPFILE3} ${BKUPDIR3}" | tee -a ${BKUPRESULTLOG}
        #tar cvzf ${BKUPFILE3} ${BKUPDIR3} > /dev/null 2>&1

        if [ $? -eq 0 ]; then
            echo `date +%Y`"/"`date +%m`"/"`date +%d` `date +%H`":"`date +%M` "INFO" "Backup #3 End. Exit Status=0" | tee -a ${BKUPRESULTLOG}
        else
            echo `date +%Y`"/"`date +%m`"/"`date +%d` `date +%H`":"`date +%M` "ERROR" "Backup #3 Error Detected." | tee -a ${BKUPRESULTLOG}
        fi

    ### End of Exec Full Backup ###
fi

echo `date +%Y%m%d` > ${BKUPFLAGFILE}
echo `date +%Y`"/"`date +%m`"/"`date +%d` `date +%H`":"`date +%M` "INFO" "End of Data Backup" | tee -a ${BKUPRESULTLOG}

exit
