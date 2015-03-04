#!/bin/sh
#
# Author: Andy Nagels
# Date: 2015-03-04
# 
# bu-nintai.sh:
# Creates a backup of the prd dir

DIR=/home/rockwolf/nintai
PREFIX=/mnt/data01/bak/nintai
USAGE="Usage: bu-nintai"
OK="backup [OK]"
DIR1=/home/rockwolf/nintai/prd
NAME1=prd
DIR2=/home/rockwolf/nintai/tst
NAME2=tst

fBackupDaily()
{
    OLDDIR=$PREFIX/daily/old
    NEWDIR=$PREFIX/daily/new
    
    fClearBackup $OLDDIR $NEWDIR
    echo $NAME1" - daily "$OK
    echo $NAME2" - daily "$OK
    
    ### make backup
    tar czf $NEWDIR/$NAME1`date +%Y-%m-%d`.tar.gz $DIR1
    tar czf $NEWDIR/$NAME2`date +%Y-%m-%d`.tar.gz $DIR2
}

fBackupWeekly()
{
    OLDDIR=$PREFIX/weekly/old
    NEWDIR=$PREFIX/weekly/new
    
    fClearBackup $OLDDIR $NEWDIR
    echo $NAME1" - weekly "$OK
    echo $NAME2" - weekly "$OK
    
    ### make backup
    tar czf $NEWDIR/$NAME1`date +%Y-%m-%d`.tar.gz $DIR1
    tar czf $NEWDIR/$NAME2`date +%Y-%m-%d`.tar.gz $DIR2
}

fBackupMonthly()
{
    OLDDIR=$PREFIX/monthly/old
    NEWDIR=$PREFIX/monthly/new
    
    fClearBackup $OLDDIR $NEWDIR
    echo $NAME1" - monthly "$OK
    echo $NAME2" - monthly "$OK
    
    ### make backup
    tar czf $NEWDIR/$NAME1`date +%Y-%m-%d`.tar.gz $DIR1
    tar czf $NEWDIR/$NAME2`date +%Y-%m-%d`.tar.gz $DIR2
}

fClearBackup()
{
    ### remove previous bak-ups
    rm $OLDDIR/*.tar.gz

    ### move current backup from new to old
    mv $NEWDIR/*.tar.gz $OLDDIR
}

fUsage()
{
    echo $USAGE
    exit 1
}

case $# in
0)
    fBackupDaily
    DOW=`date +%u`
    DOM=`date +%d`
    if [ "$DOW" = "1" ];
    then
        fBackupWeekly
    fi
    if [ "$DOM" = "01" ];
    then
        fBackupMonthly
    fi
    ;;
*)
    fUsage
    ;;
esac
