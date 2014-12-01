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
INTERACTIVE = False
FAKEHOME = True

def main(inifile='install.ini',folder='.'):
    """main

    :inifile: config file path.

    """

    conf = co.ConfigObj('install.ini')
    if VERB:
        print (title("Configuration"))
        for k,v in conf.items():
            print ('{0:>15s} -> {1:<15s}'.format(k,str(v)))

    paths = get_paths(conf,folder)
    if VERB:
        print (title('Installs'))
    for p in paths:
        if VERB:
            print ("---- {0[1]:15s}".format(p))
        install(p[0],p[1])
            
    for hook,command in conf['hooks'].items():
        if VERB:
            print (title('Executing post-hooks'))
            print (hook,'...',command)

def install(local_path, real_path, yesall=True):
    """create a link from real_path to local_path:

    :local_path: path
    :real_path: path

    """
    
    if not os.path.exists(local_path):
        print (local_path,': no such file')
        exit(11)

    if os.path.exists(real_path):
        if os.path.islink(real_path) and\
           local_path == os.path.realpath(real_path):

            print (local_path, 'is already installed on ', real_path)

        else:
            print ('installing  -  starting diff command')
            os.system('meld ' + real_path + ' ' + local_path)
    else:
        print('new')
        installit = False
        if INTERACTIVE:
            inter = input('Install {0:s}? [y/N]'.format(local_path)).lower()
            if inter == 'y':
                installit = True
        elif yesall:
            installit = True

        if installit:
            print ('OK')

            # check if folder tree exists otherwise create it
            dirname = os.path.dirname(real_path)
            print (dirname)
            if not os.path.exists(dirname):
                os.makedirs(dirname)

            # link it
            print(local_path, real_path)
            os.system('ln -s ' + local_path + ' ' + real_path)


def title(titlestring):
    return '\n{0:-^75s}\n'.format(titlestring)

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
    for loc_path in os.listdir(folder):
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
    if FAKEHOME:
        home = ('/tmp/home')
    else:
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
