#!/bin/bash

LANG1="us"
LANG2="us intl"
IS_INTL=$(setxkbmap -query | grep intl)
if [ "$IS_INTL" = "" ]; then
    setxkbmap $LANG2
else
    setxkbmap $LANG1
fi
