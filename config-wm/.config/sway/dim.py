#!/usr/bin/python
#
# This script requires i3ipc-python package
# (install it from a system package manager or pip).
# It makes inactive windows transparent.
# Use `transparency_val` variable to control
# transparency strength in range of 0…1.
# Refer: https://github.com/swaywm/sway/blob/master/contrib/inactive-windows-transparency.py


import i3ipc

ALPHA = "0.7"

IPC = i3ipc.Connection()
PREV_FOCUSED = None
PREV_WORKSPACE = IPC.get_tree().find_focused().workspace().num

for window in IPC.get_tree():
    if window.focused:
        PREV_FOCUSED = window
    else:
        window.command("opacity " + ALPHA)


def on_window_focus(ipc, event):
    """On window focus, dim other windows."""
    global PREV_FOCUSED
    global PREV_WORKSPACE

    focused = event.container
    workspace = ipc.get_tree().find_focused().workspace().num

    if (focused.id != PREV_FOCUSED.id and not focused.floating):
        # https://github.com/swaywm/sway/issues/2859
        focused.command("opacity 1")
        if workspace == PREV_WORKSPACE:
            PREV_FOCUSED.command("opacity " + ALPHA)
        PREV_FOCUSED = focused
        PREV_WORKSPACE = workspace


IPC.on("window::focus", on_window_focus)
IPC.main()
