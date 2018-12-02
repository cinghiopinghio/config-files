#!/usr/bin/env python
# -*- coding: utf-8 -*-


import subprocess


rofi_cdm = ['rofi', '-dmenu', '-i']


class Rofi(object):
    """Docstring for Rofi. """

    def __init__(self, str_list,
                 args=None,
                 markup=True,
                 custom_kb=None,
                 prompt='Menu:',
                 sep=None,
                 mesg=None):
        """TODO: to be defined1.

        :cmd: TODO
        :args: TODO
        :prompt: TODO
        :mesg: TODO

        """
        self._list = str_list
        self._prompt = ['-p', prompt]
        self._args = [] if args is None else list(args)
        self._ckb = []
        if custom_kb is not None:
            for n, ckb in enumerate(custom_kb):
                self._ckb.extend(['-kb-custom-' + str(n + 1), ckb])

        self._mesg = [] if mesg is None else ['-mesg', mesg]
        if markup:
            self._args.append('-markup-rows')

        if sep is None:
            self._sep = '\n'
        else:
            self._sep = sep
            self._args.extend(['-sep', sep, '-eh', '2', '-lines', '10'])

    def run(self):
        print(rofi_cdm + self._rofi_args())
        prc = subprocess.Popen(rofi_cdm + self._rofi_args(),
                               stdin=subprocess.PIPE,
                               stdout=subprocess.PIPE,
                               )

        out = prc.communicate(input=self._sep.join(self._list).encode())[0]
        prc.terminate()
        return out.decode().strip(), prc.returncode

    def _rofi_args(self):
        return self._prompt +\
            self._mesg +\
            self._ckb +\
            self._args
