#!/usr/bin/env python3
# encoding: utf-8

import sys,os,shutil
import configobj as co
import time
from colorama import Fore
import argparse

NOINSTALL = [\
             'README.md',\
             '_noinstall',\
             '_fixed',\
             'Makefile',\
             'install.ini',\
             'backup',\
             'dotinstall.py'\
            ]

VERB = True
INTERACTIVE = True
FAKEHOME = False

class DotFile():
    """Each dotfile"""

    def __init__(self, local, home='~', config='.'):
        """init

        :local: TODO
        :path: TODO

        """
        self.home = os.path.expanduser(home)
        self.config = os.path.abspath(os.path.expanduser(config))

        self.local = local
        self.path = '.' + local

    def get_path(self):
        """returns path where to link
        :returns: path

        """
        return self.home + '/' + self.path

    def get_local(self):
        """returns file path
        :returns: path

        """
        return self.config + '/' + self.local

    def renamePath(self, rename):
        """rename self._path according to rename

        :rename: dict
        :returns: None

        """

        for old, new in rename.iteritems():
            if old in self.local:
                self.path = self.path.replace(old, new)

    def __eq__(self, other):
        """__eq__

        :other: Other class
        :returns: Self == Other

        """
        return self.local == other.local

    def __ne__(self, other):
        return not self.__eq__(other)



    def __str__(self):
        """__str__
        :returns: TODO

        """
        return self._locale
        
def main(args):
    """main

    :args: command line args.

    """


    conf = co.ConfigObj(args.configfile)
    log("Configuration",'T')
    for k,v in conf.items():
        log('{0:>15s} -> {1:<15s}'.format(k,str(v)))

    paths = add_paths(conf,args.dir)
    log('Installs','T')
    install(paths, dry=args.dry)
            
    for hook,command in conf['hooks'].items():
        log ('Executing post-hooks','T') 
        log (hook+' ... '+command)
        os.system(command)

def install(dotfiles, dry=False, yesall=False):
    """create a link from real_path to local_path:

    :local_path: path
    :real_path: path

    """

    for df in dotfiles:
        local = df.get_local()
        path = df.get_path()
        if not os.path.exists(local):
            log (df.local+': no such file','E')
            exit(11)

        log (df.local,level='sT')
        if pathexists(path):
            if os.path.islink(path) and\
               local == os.path.realpath(path):

                log('Already installed!',indent=1)

            elif not os.path.exists(os.path.realpath(path)):

                log('Path '+path+' is a broken link.',level='W',\
                       force=True)
                choice = input('Remove it? [Y/n]').lower()
                if choice != 'n' and not dry:
                    os.unlink(path)
                    link(local, path)

            else:
                log('Already prensent in filesystem:',level='W',indent=1,\
                    force=True)
                log('1. Overwrite',indent=2,force=True)
                log('2. Get diff with diff-tool',indent=2,force=True)
                log('3. Backup and install',indent=2,force=True)
                log('4. Skip this',indent=2,force=True)

                choice = input('Choice: [1234]')
                if choice == '1' and not dry: 
                    #overwrite
                    removepath(path)
                    link(local, path)
                elif choice == '2' and not dry:
                    os.system('meld ' + path + ' ' + local)
                    removepath(path)
                    link(local, path)
                elif choice == '3' and not dry:
                    dirname,basename = os.path.split(local)
                    bup = '{:s}/backup/{:s}-{:s}'.format(dirname,\
                                                             basename,\
                                            time.strftime('-%Y-%m-%d_%H-%M-%S')
                                                            )
                    #os.rename(real_path, bup_dir) #<- do not work
                    #os.system( 'mv '+real_path+' '+bup_dir)
                    shutil.move(path, bup)
                    link(local, path)
                elif choice == '4' and not dry:
                    pass
                else:
                    pass
        else:
            log('Installing new instance...', indent=1)
            installit = False
            if INTERACTIVE:
                inter = input('Install {0:s}? [y/N]'.format(df.local)).lower()
                if inter == 'y':
                    installit = True
            elif yesall:
                installit = True

            if installit and not dry:
                link(local, path)

def log(string, level='N', enable=True, indent=0, force=False):
    """print colored output

    :string: string to print
    :level: W N E
    :enable: if colors are enabled

    """
    ind=''
    for i in range(indent): ind += '    '
    if force or VERB:
        if enable:
            if level == 'N':
                out = string
            elif level == 'W':
                out = Fore.YELLOW + 'Warning: ' + string + Fore.RESET
            elif level == 'E':
                out = Fore.RED + 'Error: ' + string + Fore.RESET
            elif level == 'T':
                out = Fore.GREEN + '\n{0:-^75s}\n'.format(string) +\
                      Fore.RESET
            elif level == 'sT':
                out = Fore.GREEN + '\n{0:-^35s}\n'.format(string) +\
                      Fore.RESET

            print(ind+out)
        else:
            print(ind+string)

def pathexists(path):
    """local definition that consider broken links

    :path: TODO
    :returns: TODO

    """
    return os.path.islink(path) or os.path.isfile(path) or os.path.isdir(path)

def removepath(path):
    """remove path

    :path: path

    """
    if os.path.isdir(path):
        #os.removedirs(path)
        shutil.rmtree(path)
    else:
        os.remove(path)
    
def link(local_path, real_path):
    """Actually link it

    :local_path: path
    :real_path: path

    """
    # check if folder tree exists otherwise create it
    dirname = os.path.dirname(real_path)
    if not os.path.exists(dirname):
        os.makedirs(dirname,exist_ok=True)

    # link it
    os.symlink(local_path, real_path)
    
def add_paths(conf,folder='.'):
    """Get paths where to put links.

    :conf: configuration object
    :returns: list of 2-tuples (local file,path of link)

    """

    skipfolds = set([])
    for f in conf['fixed']:
        fold = f.split('/')
        for n in range(len(fold)):
            p = '/'.join(fold[:n+1])
            skipfolds.add(p)

    localpaths = []
    for l in os.listdir(folder):
        if l not in skipfolds and l not in NOINSTALL\
           and l not in conf['noinstall'] and l[0] != '.':
            localpaths.append(l)
    for f in conf['fixed']:
        for l in os.listdir(folder+'/'+f):
            fname = f + '/' + l
            if fname not in skipfolds:
                localpaths.append(fname)

    paths = []
    for l in localpaths:
        dotfile = DotFile(l,config=folder)
        dotfile.renamePath(conf['rename'])
        paths.append(dotfile)
    return paths

if __name__ == '__main__':

    parser = argparse.ArgumentParser(prog='dotinstall',\
                                     description='Install dotfiles')
    parser.add_argument('-c','--color', action='store_true',
                       help='Colored output')
    parser.add_argument('-i','--interactive', action='store_true',
                       help='Ask before installing')
    parser.add_argument('-v','--verbose', action='store_true',
                       help='Verbose')
    parser.add_argument('-a','--all', action='store_true',
                       help='same as -civ')
    parser.add_argument('-n','--dry', action='store_true',
                       help='Perform a dry install (simulation)')
    parser.add_argument('-t','--test', action='store_true',
                       help='Perform tests')
    parser.add_argument('-f','--configfile', \
                        default = 'install.ini',\
                        help = 'Configuration file')
    parser.add_argument('-d','--dir', \
                        default = '.',\
                        help = 'Source file directory')

    args = parser.parse_args()
    if args.all:
        VERB = True
        INTERACTIVE = True
        COLORED = True
    else:
        VERB = args.verbose
        INTERACTIVE = args.interactive
        COLORED = args.color

    main(args)
