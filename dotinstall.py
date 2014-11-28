#!/usr/bin/env python3
# encoding: utf-8

import sys,os
import configobj as co

NOINSTALL = [\
             'README.md',\
             '_noinstall',\
             '_fixed',\
             'Makefile',\
             'install.ini',\
             'dotinstall.py'\
            ]

def main(inifile='install.ini'):
    """main

    :inifile: config file path.

    """

    conf = co.ConfigObj('install.ini')
    follow = { c.split('/')[0]:c for c in conf['fixed'] }
    print (follow)
    print (conf)


    for f in os.listdir('.'):
        if f[0] == '.' or f in NOINSTALL or f in conf['noinstall']:
            pass
        elif f in follow.keys():
            path = follow[f]
            if path in conf['rename'].keys():
                newname = conf['rename'][path]
                linkit(f,fixedpath=path,rename=newname)
            else:
                linkit(f,fixedpath=path)
        else:
            linkit(f)


    for hook,command in conf['hooks'].items():
        print (hook,command)
            

def linkit(localfile, fixedpath=None, rename=None):
    """TODO: Docstring for linkit.

    :localfile: TODO
    :fixedpath: TODO
    :returns: TODO

    """

    if fixedpath==None:
        if rename is None:
            homefile = '~/.'+ localfile
        else:
            homefile = '~/.'+ rename
        #print (localfile, homefile)
    else:
        files = os.listdir(fixedpath)
        for f in files:
            if rename is None:
                linkit(fixedpath+'/'+f,None)
            else:
                linkit(fixedpath+'/'+f,None,rename+'/'+f)


if __name__ == '__main__':
    if len(sys.argv) == 1:
        main()
    elif len(sys.argv) == 2:
        main(sys.argv[1])
    else:
        print ('Usage: dotinstall.py [ini-file]')
