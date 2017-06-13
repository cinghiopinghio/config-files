from .base import Base
import subprocess
import os


class Source(Base):

    """Fetches email from notmuch_address."""

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'email'
        self.filetypes = ['mail', 'markdown']
        self.min_pattern_length = 3
        self.matchers = ['matcher_full_fuzzy']
        self.mark = '[@]'
        self.is_async = True

    def gather_candidates(self, context):
        """Gather candidates from github API
        """

        cmd = os.path.expanduser('~/.local/bin/nottoomuch-addresses.sh')
        # cmd = 'notmuch-addrlookup'

        command = [cmd, context['complete_str']]
        addrs = subprocess.check_output(command).decode().splitlines()
        addrs = [a.replace('\t', '').replace('\'', '').replace('\"', '')
                 for a in addrs]

        return [{'word': a,
                 'abbr': a}
                for a in addrs]
