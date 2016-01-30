#!/usr/local/bin/python
# -*- coding: utf-8 -*-

"""
radio.py 0.3

A script that makes it easy to listen to online radio via mplayer

"""


###########################################################################
 #   Copyright (C) 2007 by Guy Rutenberg                                   #
 #   guyrutenberg@gmail.com                                                #
 #                                                                         #
 #   This program is free software; you can redistribute it and/or modify  #
 #   it under the terms of the GNU General Public License as published by  #
 #   the Free Software Foundation; either version 2 of the License, or     #
 #   (at your option) any later version.                                   #
 #                                                                         #
 #   This program is distributed in the hope that it will be useful,       #
 #   but WITHOUT ANY WARRANTY; without even the implied warranty of        #
 #   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
 #   GNU General Public License for more details.                          #
 #                                                                         #
 #   You should have received a copy of the GNU General Public License     #
 #   along with this program; if not, write to the                         #
 #   Free Software Foundation, Inc.,                                       #
 #   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             #
############################################################################

import sys
import os
import subprocess
import time
from optparse import OptionParser

radiostations = {#name:(address,homepage),
        'furia' :('http://87.117.217.103:19462', 'Furia Metal Brasil'),
		'radio2' :('http://mp3.streampower.be/ra2ant-mid.mp3', 'radio 2 - antwerpen'),
        'brasil' :('http://189.1.162.125:8450', 'Rádio Brasil 2000'),
        'rio' :('http://99.198.112.59:80', 'Paul in Rio'),
        'brasil99' :('http://189.8.108.38:8000', 'Rádio Transamérica 99.7FM'),
        'nihon' :('http://radio.kahoku.net:8000/listen.pls',
            'kohaku'),
        'anime' :('http://momori.animenfo.com:8000/listen.pls', 'AnimeNFO'),
        'catalunya'
        :('http://www.catradio.cat/directes/catradio_http.m3u',
            'catalunya radio'),
        'catmusica'
        :('http://www.catmusica.cat/directes/catmusica_http.m3u',
            'catmusica'),
        'sveriges-p4'
        :('http://sverigesradio.se/topsy/direkt/1607-hi-mp3.pls',
            'sveriges-p4'),
        'euskara'
        :('http://groove.wavestreamer.com:7429/listen.m3u',
            'euskara'),
		'grandes':('mms://200.42.92.40/grandesdelrock','Grandes Del Rock - http://www.la100.com.ar'),
		'metal':('mms://200.42.92.40/heavymetal','Heavy Metal - http://www.la100.com.ar'),
        'wwuz':('http://www.classicrock969.com/WWUZstreaming/play.ram','classick rock 96.9 WWUZ'),
	'ib3radio':('mms://194.179.36.187/IB3Radio','IB3 Ràdio - http://www.ib3radio.tv'),
    'comradio':('http://213.27.152.121:8000/comradio','COM Ràdio - http://www.comradio.com'),
    'catradio':('mms://www.catradio.cat/reproductor/catradio','Catalunya Ràdio - http://www.catradio.cat'),
    'catinfo':('mms://catinfo.directe-wm.emissio.catradio.cat/reflector:37254?origin=extern','Catalunya Ràdio Informació - http://www.catradio.cat'),
    'catmusica':('mms://catmusica.directe-wm.emissio.catradio.cat/reflector:36524?origin=extern','Catalunya Mùsica - http://www.catradio.cat'),
    'icatfm':('mms://icatfm.directe-wm.emissio.catradio.cat/reflector:35490?origin=extern','iCATfm - http://www.catradio.cat'),
    'icatjazz':('mms://catinfo.directe-wm.emissio.catradio.cat/reflector:37254?origin=extern','iCATjazz - http://www.catradio.cat'),
    'catclassica':('mms://catclassica.directe-wm.emissio.catradio.cat/reflector:22521?origin=extern','CatClàssica - http://www.catradio.cat'),
    'mediterradio':('mms://catmediterradio.directe-wm.emissio.catradio.cat/reflector:59057','mediterRadio - http://www.catradio.cat'),
    'xahrazad':('mms://xahrazad.directe-wm.emissio.catradio.cat/reflector:52815','Xahrazad - http://www.catradio.cat'),
    }

def parseArguments():
    parser = OptionParser(usage="%prog [options] station", 
                        version="%prog 0.3")
    parser.add_option("-s", "--sleep", dest="sleep", type="int", default=0,
                    help="go to sleep after MIN minutes", metavar="MIN")
    parser.add_option("-w", "--wake-up", dest="wake", type="int", default=0,
                    help="wake up and start playing after MIN minutes", metavar="MIN")
    parser.add_option("-l", "--list", dest="list", action="store_true", default=False,
                    help="show a list of known radio stations and their homepage")
    parser.add_option("-c", "--cache", dest="cache", type="int", default=512,
                    help="set the size of the cache in KBytes [default: %default]", metavar="SIZE")
    
    return parser.parse_args()

def main(options, args):
    if options.list:
        showStations()
        return 0
    
    if len(args)<1:
        print("You need to supply a station name")
        showStations()
        return 1
    
    try:
        radiostations[args[0]]
    except KeyError:
        print("Didn't recognized this station name:",args[0])
        showStations()
        return 1
    
    if options.wake > 0:
        print("Radio will wake up in", options.wake, "minutes")
        time.sleep(60*options.wake)
    
    if options.cache > 32: #mplayer requires cache>=32
        cache = str(options.cache)
    else: cache = str(32)
    
    #check if we need the '-playlist' argument for mplayer
    #Rockwolf 2012-01-02 changed to always include it!
    playlist=''
    if radiostations[args[0]][0][-4:] in ('.asx','.ram', '.pls', '.m3u'):
        playlist='-playlist'
    
    execargs=['mplayer', '-softvol', '-cache', cache, playlist, radiostations[args[0]][0] ]
    #execargs=['mplayer', radiostations[args[0]][0] ]
    if options.sleep > 0:
        print("Radio will go to sleep in", options.sleep, "minutes")
        pid = subprocess.Popen(execargs).pid
        time.sleep(60*options.sleep)
        os.kill(pid, 15) # 15 = SIGTERM
    else: #in case we don't sleep then start the player without forking
        os.execvp(execargs[0],execargs)

def showStations():
    keys = radiostations.keys()
    #keys.sort()
    
    maxlen = 0 # find the longest station name
    for key in keys:
        if len(key) > maxlen: maxlen = len(key) 
    for key in keys:
        print(key.ljust(maxlen+1), radiostations[key][1])

if __name__== '__main__':
    (options, args) = parseArguments()
    sys.exit(main(options, args))

