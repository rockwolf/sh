#!/bin/bash
           
JAVA_HOME=/usr/lib/jvm/java-6-openjdk/
JAVA_FONTS=/usr/share/fonts/truetype
ANT_HOME=/usr/share/ant
                       
PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$PATH
                                       
export PATH JAVA_HOME JAVA_FONTS ANT_HOME
export CLASSPATH=.
