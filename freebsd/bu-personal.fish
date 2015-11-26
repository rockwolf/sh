#!/usr/local/bin/fish

################################################################################
# Author: Andy Nagels
# Date: 2015-03-04
#
# bu-personal.fish:
# Creates a backup of the doc and arc dir.
################################################################################

set DIR /home/rockwolf/
set PREFIX /mnt/data01/bak/personal
set USAGE "Usage: bu-personal"
set OK "backup [OK]"
set DIR1 /home/rockwolf/arc
set NAME1 arc
set DIR2 /home/rockwolf/doc
set NAME2 doc

function fBackupDaily
    set OLDDIR $PREFIX/daily/old
    set NEWDIR $PREFIX/daily/new
    fClearBackup $OLDDIR $NEWDIR
    echo $NAME1" - daily "$OK
    echo $NAME2" - daily "$OK
    # make backup
    tar czf $NEWDIR/$NAME1(date +%Y-%m-%d).tar.gz $DIR1
    tar czf $NEWDIR/$NAME2(date +%Y-%m-%d).tar.gz $DIR2
end

function fBackupWeekly
    set OLDDIR $PREFIX/weekly/old
    set NEWDIR $PREFIX/weekly/new
    fClearBackup $OLDDIR $NEWDIR
    echo $NAME1" - weekly "$OK
    echo $NAME2" - weekly "$OK
    # make backup
    tar czf $NEWDIR/$NAME1(date +%Y-%m-%d).tar.gz $DIR1
    tar czf $NEWDIR/$NAME2(date +%Y-%m-%d).tar.gz $DIR2
end

function fBackupMonthly
    set OLDDIR $PREFIX/monthly/old
    set NEWDIR $PREFIX/monthly/new
    fClearBackup $OLDDIR $NEWDIR
    echo $NAME1" - monthly "$OK
    echo $NAME2" - monthly "$OK
    # make backup
    tar czf $NEWDIR/$NAME1(date +%Y-%m-%d).tar.gz $DIR1
    tar czf $NEWDIR/$NAME2(date +%Y-%m-%d).tar.gz $DIR2
end

function fClearBackup
    # remove previous backups
    rm $OLDDIR/*.tar.gz
    # move current backup from new to old
    mv $NEWDIR/*.tar.gz $OLDDIR
end

function fUsage
    echo $USAGE
    exit 1
end

set args (fish -c "for el in $args; echo \$el; end")
switch (count $args)
    case 0
        fBackupDaily
        set DOW (date +%u)
        set DOM (date +%d)
        if math "$DOW" == "1" > /dev/null
            fBackupWeekly
        end
        if math "$DOM" == "1" > /dev/null
          fBackupMonthly
        end
    case '*'
        fUsage
end
