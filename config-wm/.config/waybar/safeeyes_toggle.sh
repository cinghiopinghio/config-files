#!/usr/bin/env bash

case `safeeyes --status` in
    "Disabled until restart")
        safeeyes --enable &
        echo enabled
        ;;
    "Safe Eyes is not running")
        safeeyes --enable &
        echo enabled
        ;;
    *)
        safeeyes --disable &
        echo disabled
        ;;
esac
