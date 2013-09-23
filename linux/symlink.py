#!/usr/bin/env python
# coding: utf-8
# Author: Andy Nagels
# Date: 2013-01-31
# This script will symlink my non-sensitive 
# config files with their version-controlled copies.
#
# Note: This is a fork of this script:
# https://github.com/ahri/dotfiles/blob/873126449463fe857091d01e3a2a428fbff0c841/write-links.py

import os
import re
from shutil import rmtree

FILE = '/usr/local/rc/README'
THIS_FILE = os.path.abspath(FILE)
BASE = os.path.dirname(os.path.abspath(FILE)) + os.sep
HOME = os.environ['HOME'] + os.sep
esc_base = re.escape(BASE)

IGNORE = re.compile(r'|'.join([re.escape(THIS_FILE),
                               esc_base + r'\.git$',
                               esc_base + r'\.gitmodules$',
                               esc_base + r'\.gitignore$',
                               esc_base + r'README',
                               esc_base + r'.*\.swp']))

def create_link(source, target, force=False):
    """ Creates the symlink. """
    if force:
        remove_link(source, target)
    try:
        os.symlink(source, target)
    except Exception as ex:
        print('Error in create_link for', target, ex + '.')

def remove_link(source, target):
    """ Removes the symlink. """
    try:
        if os.path.islink(target):
            #TODO: uncomment after testing
            #os.remove(target)
            print('dummy if', source, target)
        else:
            #TODO: uncomment after testing
            #rmtree(target, True)
            print('dummy else', source, target)
    except Exception as ex:
        print('Error in remove_link for', target, ex + '.')

def linkify(subpath):
    """ Main logic/loop. """
    based = BASE + subpath
    homed = HOME + subpath
    if IGNORE.match(based) is not None:
        print('Ignoring...')
        return
    print('OPERATING ON:', subpath)
    if not os.path.isdir(based):
        create_link(based, homed, True)
        return
    if not os.path.isdir(homed) or os.path.islink(homed):
        create_link(based, homed, True)
        return
    #TODO: $HOME/.config/appdir/file.rc -> only link appdir?
    if os.path.isdir(homed):
        create_link(based, homed, True)
    #for item in os.listdir(based):
    #    # recurse
    #    linkify(subpath + os.sep + item)

if __name__ == '__main__':
    print('test: BASE=', BASE)
    for item in os.listdir(BASE):
        #TODO: added ifs for testing:
        # remove them after testing
        print('main->' + item)
        if (item == '.test1') or (item == '.config') or (item == 'test2') or (item == 'testfile.rc'):
            linkify(item)
