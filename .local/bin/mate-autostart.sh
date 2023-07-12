#!/bin/bash

# Why? XDG Desktop Entry can be restricted for using in one specific desktop
# environment by setting key OnlyShowIn, e.g. OnlyShowIn=MATE. However this key
# is not settable from MATE's GUI. Here is a workaround to let autostart entries
# run in MATE only by wrapping their commands in mate-autostart.sh, e.g.
# mate-autostart.sh fusion-icon (you won't welcome Compiz in Gnome!).

if [ $# -gt 0 ] && [ "$XDG_SESSION_DESKTOP" = "mate" ] ; then $@ & fi

