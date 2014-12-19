#!/bin/sh
#
# Author: rockwolf
# Date: 2014-08-22
# 
# Creates a backup of the doc and arc dir
#

DIR=/home/rockwolf/
PREFIX=/mnt/data01/bak/personal
USAGE="Usage: bu-personal"
OK="backup [OK]"
DIR1=/home/rockwolf/arc
NAME1=arc
DIR2=/home/rockwolf/doc
NAME2=doc

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
