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

VERB = True

def main(inifile='install.ini'):
    """main

    :inifile: config file path.

    """

    conf = co.ConfigObj('install.ini')
    if VERB:
        print (title("Configuration:"))
        for k,v in conf.items():
            print ('{0:>15s} -> {1:<15s}'.format(k,str(v)))

    paths = get_paths(conf)
    if VERB:
        print (title('Installs:'))
        for p in paths:
            print ("{0[0]:_<45s} {0[1]:15s}".format(p))
            if os.path.exists(p[1]):
                if os.path.islink(p[1]):
                    print ('already installed')
                else:
                    print ('installing')
            else:
                print('new')

    for hook,command in conf['hooks'].items():
        if VERB:
            print (title('Executing post-hooks:'))
            print (hook,'...',command)
            

def title(titlestring):
    return '\n{0:-<75s}\n'.format(titlestring)

def get_paths(conf,folder='.'):
    """Get paths where to put links.

    :conf: configuration object
    :returns: list of 2-tuples (local file,path of link)

    """

    fix = {}
    for f in conf['fixed']:
        basef = f.split('/')[0]
        if basef in fix.keys():
            fix[basef].append(f)
        else:
            fix[basef] = [f]

    paths = []
    for loc_path in os.listdir('.'):
        if loc_path[0] == '.' or loc_path in NOINSTALL\
           or loc_path in conf['noinstall']:
            pass
        elif loc_path in fix.keys():
            path = fix[loc_path]
            p = get_path (loc_path, fixedpath=path, rename=conf['rename'],\
                         folder=folder)
            paths.extend(p)
        else:
            p = get_path(loc_path, folder=folder)
            paths.append(p)
    return paths

def get_path(localfile, fixedpath=None, rename=None, folder='.'):
    """TODO: Docstring for linkit.

    :localfile: TODO
    :fixedpath: TODO
    :returns: TODO

    """


    base = os.path.abspath(folder)
    home = os.path.expanduser('~')
    
    if fixedpath==None:
        if rename is None:
            homefile = home+'/.'+ localfile
        else:
            homefile = home+'/.'+ rename
        return (base+'/'+localfile, homefile)
    else:
        files = []
        for fp in fixedpath:
            _files = [ fp+'/'+fl for fl in os.listdir(fp) ]
            for _fp in fixedpath:
                if _fp in files:
                    files.remove(_fp)
            files.extend(_files)
        
        for rn in rename.keys():
            # rename where needed
            files = [ (f,f.replace(rn,rename[rn])) for f in files ]
            # add basenames folders
            files = [ (base+'/'+f,home+'/.'+rn) for f,rn in files ]

    return files


if __name__ == '__main__':
    if len(sys.argv) == 1:
        main()
    elif len(sys.argv) == 2:
        main(sys.argv[1])
    else:
        print ('Usage: dotinstall.py [ini-file]')
