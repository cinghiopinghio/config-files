#!/usr/bin/env python3

from i3ipc.aio import Connection
import asyncio


async def moveinside():
    sway = await Connection().connect()
    tree = await sway.get_tree()

    focused = tree.find_focused()
    workspace = focused.workspace()

    # print(workspace.rect.x)
    # print(workspace.rect.y)

    if focused.rect.y < workspace.rect.y:
        await focused.command(
            'move down {}'.format(workspace.rect.y - focused.rect.y)
        )
    if focused.rect.x < workspace.rect.x:
        await focused.command(
            'move right {}'.format(workspace.rect.x - focused.rect.x)
        )
    elif focused.rect.x + focused.rect.width > workspace.rect.x + workspace.rect.width:
        await focused.command(
            'move left {}'.format(
                focused.rect.x + focused.rect.width - workspace.rect.x - workspace.rect.width
            )
        )

asyncio.run(moveinside())
