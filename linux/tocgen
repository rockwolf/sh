#!/usr/bin/env python
#tocgen: writes out a toc-file for cdrdao
#author Michael Johnson johns776@pilot.msu.edu
#0.9 Initial release. 3/2001
#0.9a Changes for Python1.5.2 in String2Data; minor code cleanup.
#0.9b Allow track lengths as command arguments; minor style changes;
#     updated help. 4/2001

import getopt, string 
from sys import argv, stderr, exit, stdin
from os import path, system, listdir, rename
from re import search 
#of these imports, only string is used in Timemark and none in Track,
#string only being necessary in Timemark for use in Python1.5.2

class TimeMark:
    """Store and manipulate cdrdao toc time-strings, e.g. "3:32:4". """
    
    __fps=75     #frames per second
    __datum = 0  #total frames
    __min = 0
    __sec = 0
    __frames = 0
    
    # Data attributes are assigned through this function and nowhere else!
    def Set(self, VAL):
        if type(VAL) == type(0):
            if (VAL < 0):
                raise ValueError, 'TimeMark value cannot be negative integer'
        elif type(VAL) == type(''):
	    VAL = TimeMark.String2Data(self, VAL)
	elif type(VAL) == type(TimeMark()):
	    VAL = VAL.__datum
        else:
            raise TypeError, 'VAL passed to Set must be non-negative integer,\
                              string, or TimeMark'
        self.__datum = VAL
        total_sec, self.__frames = divmod(self.__datum, 75)
        self.__min, self.__sec = divmod(total_sec, 60)

    def String2Data(self, STRING):
        if type(STRING) != type(''):
            raise TypeError, 'String2Data received non-string value '
        a = string.split(STRING,':')
        if len(a) != 3:
            raise ValueError, 'malformed TimeMark, should be like 0:0:0,' +\
                              ' not ' + STRING
        if len(a[0]) == 0:  min = 0
        else: min = int(a[0])*60*TimeMark.__fps
        if len(a[1]) == 0:  sec = 0
        else: sec = int(a[1])*TimeMark.__fps
        if len(a[2]) == 0:  frm = 0
        else: frm = int(a[2])
        return min + sec + frm

    def __init__(self, INITVAL=0):
        self.Set(INITVAL)
    
    #represented as string "min:sec:frames"    
    def __repr__(self):
        return str(str(self.__min) + ':' +
                   str(self.__sec) + ':' + str(self.__frames))
     
    def __cmp__(self, OTHER):
        OTHER = TimeMark(OTHER)
        if self.__datum < OTHER.__datum: return -1
        elif self.__datum == OTHER.__datum: return 0
        elif self.__datum > OTHER.__datum: return 1
        
    def __sub__(self, OTHER):
        try:
            return TimeMark(self.__datum - OTHER.__datum)
        except AttributeError:
            # Allow second argument to be string "m:s:f"
            return TimeMark(self.__datum - TimeMark.String2Data(self, OTHER))
        
    def __add__(self, OTHER):
        try:
            return TimeMark(self.__datum + OTHER.__datum)
        except AttributeError:
            # Allow second argument to be string "m:s:f"
            return TimeMark(self.__datum + TimeMark.String2Data(self, OTHER))
        
    def __mul__(self, OTHER): # where OTHER is a real number
	return TimeMark(int(self.__datum * OTHER))
    
    __rmul__ = __mul__


class Track:
    """Store and format track lines for cdrdao toc file."""
    def __init__(self, START='0:0:0', LEN='',
                 WAVFILE='new.wav', PREGAP=0):
        self.start = START
        self.length = LEN
        self.wavfile = WAVFILE
        self.pregap = PREGAP
        
    def __repr__(self):
        return str( [self.start, self.length, self.wavfile, self.pregap] )
    
    def __str__(self):
        if self.pregap != 0:
            return str('TRACK AUDIO\n'+ 'PREGAP ' + str(self.pregap) +'\n' + 
                       'FILE' + ' "'+ self.wavfile + '" ' +
                       str(self.start) +' '+ str(self.length) + '\n')
        else:
            return str('TRACK AUDIO\n' + 
                       'FILE' + ' "'+ self.wavfile + '" ' +
                       str(self.start) +' '+ str(self.length) + '\n')

# begin main program

def Usage():
    stderr.write('cdrdao toc file generator \n' +
    'Usage:   ' + 'tocgen followed by one or more options:\n' +
'     -t toc file \n \
    -w wav file \n \
    -i interval \n \
    -s starting point in wavfile ( e.g. \'0:4:0\')\n \
    -e ending point in wavfile  \n \
    -p pregap \n \
    -a  (appends tracks to an existing toc file) \n\n \
    -l treat command line arguments as track lengths \n\n \
    track_one_start  track_two_start ... last_track_stop, or \'-\' for \
stdin\n    \nOr call with a directory name. \n \
\n    -H display examples of use \n ' )

def Help():
    stderr.write("""
To write a toc file 'new.toc' containing all wav files in a directory enter:
\n     tocgen path-to-directory (or just 'tocgen' for present directory)\n
To write a toc file 'new.toc' containing specified wav files:
\n     tocgen here_a.wav there_a.wav ... (or tocgen . ../d/track0[1-4]*.wav)\n
To write a toc file 'some.toc' that breaks 'live.wav' into five minute tracks,
starting 2 seconds into the wav file and ending 45 minutes, 32 seconds, and
41 frames into the wav file enter:
\n     tocgen -t some.toc -w live.wav -i 5:: -s :2: -e 45:32:41 \n
To append 3 minute tracks to the end of an existing toc file enter:
\n     tocgen -a -t some.toc -w live.wav -i 3:: -s 47:23:05 -e 65:23:09\n
To write a toc file for 'live.wav' with tracks split at specified points
with 1.5 second pregaps:
\n     tocgen -p :1:37 -w live.wav (start of first track, e.g. 0:2:3) 4:23:23 10:43:54 ... (end of last track)\n
To write toc file from a wav with known track lengths, starting the first track 3 and 1/3 seconds into 'album.wav':
tocgen -s 0:3:25 -w album.wav 3:40: 5:24: 4:7: ... 
(don't forget to account for gaps between tunes)\n\n""" )
    
#defaults and control variables
_interval = TimeMark('::'); _tocfile="new.toc";
_offset=TimeMark(); _length=TimeMark('80:0:0'); _wavfile="new.wav";
_read_stdin=0; _pregap=TimeMark(0); _append=0; _args_are_length=0

if argv[-1] == '-':
        _read_stdin = 1
        
opts, args = getopt.getopt(argv[1:], "i:t:w:hs:e:Hap:l")
for o, a in opts:
    if o == '-i':
        _interval.Set(a)
    elif o == '-t':
        _tocfile = a
    elif o == '-a':
        _append = 1
    elif o == '-h':
        Usage()
        exit(0)
    elif o == '-H':
        Help()
        exit(0)
    elif o == '-s':
        _offset.Set(a)
    elif o == '-e':
        _length.Set(a)
    elif o == '-w':
        _wavfile = a
    elif o == '-p':
        _pregap.Set(a)
    elif o == '-l':
        _args_are_length=1
        
def MakeTimeList(ARGS):
    if _read_stdin:
        a = stdin.read()
        stdin.close()
        ARGS = a.split()
    time_list= []
    if _args_are_length:
        time_list.append(_offset)
        for  a in range(len(ARGS)):
            time_list.append( time_list[a] + TimeMark(ARGS[a]) )
    else:
        for a in ARGS:
            time_list.append(TimeMark(a))
    return time_list

# The next 3 function each create a list of Track instances.

def RegularIntervals():
    position = _offset
    track_list = []
    while position <= (_length - 1.5*_interval):
        track_list.append(Track(position, _interval , _wavfile, _pregap))
        position = position + _interval
    track_list.append(Track(position, _length - position, _wavfile, _pregap))
    return track_list

def CustomIntervals(TIMELIST):
    track_list=[]
    for start in TIMELIST:
        if TIMELIST.index(start) < (len(TIMELIST)) - 1:
            tlength = TIMELIST[ TIMELIST.index(start) + 1 ] - start
            track_list.append(Track(start, tlength , _wavfile, _pregap))
    return track_list
        
def WholeFiles(ARGS):
    track_list=[]
    for i in ARGS:
        if path.isdir(i):
            file_list = listdir(i)
            file_list.sort()   
            for a in file_list:
                if search('.*\.wav$', a):
                    track_list.append(Track(0,'', i + '/'+a, _pregap))
        elif  path.isfile(i) and search('.*\.wav$', i):
            track_list.append(Track(0,'', i, _pregap))
    return track_list


def WriteTrackList(TRACK_LIST):
    try:
        TRACK_LIST[0]
    except IndexError:
        return 
    if not _append:
        if path.exists(_tocfile):
            rename(_tocfile, _tocfile + '.bak')
            stderr.write('\nMoved existing file "'+ _tocfile +
                         '" to "' + _tocfile + '.bak"\n')
        f=open(_tocfile, 'w+')
        f.write('CD_DA\n')
    else: 
        f=open(_tocfile, 'a')
    n=1
    for i in TRACK_LIST:
        f.write('// Track '+ str(n) + '\n' + str(i) + '\n')
        n = n+1
    f.close()

#MAIN FUNCTION

if  _interval != 0:   
    WriteTrackList(RegularIntervals())
elif  len(args) == 0:
    WriteTrackList(WholeFiles('.'))
elif path.isdir(args[0]) or path.isfile(args[0]):
    WriteTrackList(WholeFiles(args))
else:
    time_list = MakeTimeList(args)
    WriteTrackList(CustomIntervals(time_list))

exit(0)

