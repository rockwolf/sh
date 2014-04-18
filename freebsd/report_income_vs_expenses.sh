#!/bin/sh

# Compare income vs expenses

Usage()
{
    echo "Usage:"
    echo "    $0 <ledger db file> [<year>|<start date> <end date> [total]]"
    echo "    Notes:"
    echo "    ------"
    echo "    * Start- and enddate should be in YYYY/MM/DD format."
    echo "    * Specifying total with a period, will display the total,"
    echo "      otherwise, the total per month in that period is shown."

}

case $# in
1)
    # Plot all data until now.
    #-y "%Y"
    #ledger -f $1 --real -s -B -d "T&l<=1" bal --yearly --period-sort -Equity -^assets expenses income
    ledger -f $1 --real -s -d "T&l<=1" bal -Equity -^assets expenses income
    ;;
2) 
    # Plot all data for the given year.
    ledger -f $1 --real -s -p $2 -d "T&l<=1" bal --period-sort --yearly -Equity -^assets expenses income
    ;;
3)
    # Plot all data for the given period.
    ledger -f $1 --real -s -d "T&l<=1" --begin $2 --end $3 bal --period-sort --monthly -Equity -^assets expenses income
    ;;
4)
    if [ "$4" = "total" ];
    then
        # Plot all data for the given period
        ## as the total
        ledger -f $1 --real -s -d "T&l<=1" -b $2 -e $3 bal -Equity -^assets expenses income
    else
        Usage
    fi
    ;;
*)
    Usage()
    exit 1
    ;;
esac
