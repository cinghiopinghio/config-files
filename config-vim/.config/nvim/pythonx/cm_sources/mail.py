#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from cm import register_source, Base

register_source(name='email',
                abbreviation='@',
                sort=0,
                scopes=['gitcommit', 'markdown', 'mail'],
                word_pattern=r'\w+',
                cm_refresh_length=2,
                priority=8)

import subprocess
import os


class Source(Base):
    def cm_refresh(self, info, ctx):
        cmd = os.path.expanduser('~/.local/bin/nottoomuch-addresses.sh')
        # cmd = 'notmuch-addrlookup'

        command = [cmd, ctx['base']]
        addrs = subprocess.check_output(command).decode().splitlines()
        addrs = [a.replace('\t', '').replace('\'', '').replace('\"', '')
                 for a in addrs]

        self.complete(info, ctx, ctx['startcol'], addrs)
