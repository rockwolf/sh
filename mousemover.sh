#This is a small python script that triggers a keyboard event
#to keep the screen from blanking when watching movies on the web.
#Ctr+C to quit.

INTERVAL=300 #interval in seconds

while true;
do
    #xsendkeys Shift_L
    swarp 1460 20
    sleep $INTERVAL
    swarp 1490 50
    sleep $INTERVAL
done;
