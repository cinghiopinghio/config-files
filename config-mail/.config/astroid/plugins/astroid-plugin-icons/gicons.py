import gi

from hashlib import md5
from email import header
import colorsys

import io
from os.path import exists, dirname
from base64 import b64encode
from PIL import Image, ImageDraw, ImageFont

gi.require_version('Astroid', '0.2')
gi.require_version('Gtk', '3.0')
gi.require_version('GMime', '3.0')

from gi.repository import GObject
from gi.repository import Gtk
from gi.repository import Astroid

PLG_NAME = 'gicons'


def log(*strings):
    print('{}: {}'.format(PLG_NAME,
                          ' '.join(map(str, strings))))


def newicon(email, alt=None):
    if alt is None:
        message = str(email)[0].upper()
    else:
        message = str(alt)[0].upper()

    SZ = 64
    m = md5(email.lower().encode('ascii', 'replace')).hexdigest()[-6:]
    hue = int(m, 16) / 0xffffff * 1.0

    rgb = colorsys.hsv_to_rgb(hue, 0.4, 0.7)
    rgb = tuple(map(lambda x: int(x*255), rgb))

    im = Image.new('RGB', (SZ, SZ), color=rgb)
    draw = ImageDraw.Draw(im)
    font = ImageFont.truetype('./Hack-Regular.ttf',
                              int(SZ*0.8))
    w, h = font.getsize(message)
    # dirty hack to get the font centered
    draw.text(((SZ-w)/2, 4), message, fill='#ffffff', font=font)
    buf = io.BytesIO()
    im.save(buf, format='PNG')

    return b64encode(buf.getvalue()).decode()


class GiconsPlugin (GObject.Object, Astroid.ThreadViewActivatable):
    object = GObject.property(type=GObject.Object)
    thread_view = GObject.property(type=Gtk.Box)

    def do_activate(self):
        self.config_dir = dirname(__file__)
        log('activated:', __file__)

    def do_deactivate(self):
        log('deactivated')

    def _load_preinstalled(self, name):
        filename = '{}/avatar_{}.png'.format(self.config_dir, name)
        if exists(filename):
            print('avatar: filename=', filename)
            with open(filename, 'rb') as f:
                data = f.read()
            return b64encode(data).decode()

    def do_get_avatar_uri(self, email, type_, size, message):
        # get the sender
        sender = message.get_header('From').strip(' "\'<>')
        if sender[0] == '=':  # if the header entry is encoded in utf8
            sender = ''.join([t[0].decode(t[1] or 'UTF8')
                              for t in header.decode_header(sender)])
        # check if its a gh user
        github_user = message.get_header('X-GitHub-Sender')
        log(sender, email, type_, size)

        # check if the email comes from root, noreply...
        data = self._load_preinstalled(email.split('@')[0])

        # otherwise make a new icon
        if not data:
            if github_user:
                data = newicon(github_user, sender)
            else:
                data = newicon(email, sender)
        mime_type = 'image/png'

        # return an uri
        url = 'data:{};base64,{}'.format(mime_type, data)
        return url

    def do_get_allowed_uris(self):
        log('do_get_allowed_uris:')
        return []  # our uris are always allowed


log('plugin loaded')
