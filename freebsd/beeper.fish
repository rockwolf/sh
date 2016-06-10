#!/usr/local/bin/fish

################################################################################
# Author: Andy Nagels
# Date: 2016-06-10
#
# beeper.fish:
# Script that beeps. You use it for working out.
################################################################################

set -x SOUND_START "$HOME/aud/wav/20th_century_fox.wav"
set -x SOUND_INTENSE "$HOME/aud/wav/huuuh.wav"
set -x SOUND_BREAK "$HOME/aud/wav/fart.wav"
set -x SOUND_STOP "$HOME/aud/wav/hallelujah.wav"
set -x fCmdPlay "play -q"

function fCmdPlay
    play -q $argv
end

# TODO: test for no arguments.
# TODO: write some damn functions man!
switch $argv[1]
case "-h"
    echo "beeper.fish [-h|tabata]"
    echo "Note: Needs to be run as root."
case "tabata"
    echo ">>> Using the Tabata protocol."
    echo ">>> Starting in 11 seconds..."
    fCmdPlay $SOUND_START
    echo ">>> INTENSE [*       ]"
    fCmdPlay $SOUND_INTENSE
    sleep 20
    echo ">>> PAUSE"
    fCmdPlay $SOUND_BREAK
    sleep 10
    echo ">>> INTENSE [**      ]"
    fCmdPlay $SOUND_INTENSE
    sleep 20
    echo ">>> PAUSE"
    fCmdPlay $SOUND_BREAK
    sleep 10
    echo ">>> INTENSE [***     ]"
    fCmdPlay $SOUND_INTENSE
    sleep 20
    echo ">>> PAUSE"
    fCmdPlay $SOUND_BREAK
    sleep 10
    echo ">>> INTENSE [****    ]"
    fCmdPlay $SOUND_INTENSE
    sleep 20
    echo ">>> PAUSE"
    fCmdPlay $SOUND_BREAK
    sleep 10
    echo ">>> INTENSE [*****   ]"
    fCmdPlay $SOUND_INTENSE
    sleep 20
    echo ">>> PAUSE"
    fCmdPlay $SOUND_BREAK
    sleep 10
    echo ">>> INTENSE [******  ]"
    fCmdPlay $SOUND_INTENSE
    sleep 20
    echo ">>> PAUSE"
    fCmdPlay $SOUND_BREAK
    sleep 10
    echo ">>> INTENSE [******* ]"
    fCmdPlay $SOUND_INTENSE
    sleep 20
    echo ">>> PAUSE"
    fCmdPlay $SOUND_BREAK
    sleep 10
    echo ">>> INTENSE [********]"
    fCmdPlay $SOUND_INTENSE
    sleep 20
    echo ">>> Done."
    fCmdPlay $SOUND_STOP
    true
case '*'
    echo Unknown option $argv[1].
    false
end
