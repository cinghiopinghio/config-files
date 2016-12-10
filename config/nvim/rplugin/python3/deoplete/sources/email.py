from .base import Base
import subprocess


class Source(Base):

    """Fetches email from notmuch_address."""

    def __init__(self, vim):
        Base.__init__(self, vim)

        self.name = 'email'
        self.mark = '[NM]'
        self.filetypes = []
        # self.input_pattern = '#\w+'

    def gather_candidates(self, context):
        """Gather candidates from github API
        """

        command = ['notmuch-addrlookup', context['complete_str']]
        addrs = subprocess.check_output(command).decode().splitlines()
        return [{'word': a} for a in addrs]
