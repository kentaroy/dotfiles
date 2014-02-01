#!/bin/bash
export QT_IM_MODULE='uim'
export GTK_IM_MODULE='uim'
export XMODIFIERS="@im=uim" 

# No beep sound.
xset -b

# Load XResources if exists.
if [ -f $HOME/.Xresources ] ; then
    xrdb -merge $HOME/.Xresources
fi

# WMii window manager.
wmii &

exec mlterm
