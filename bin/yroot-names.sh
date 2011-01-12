#!/bin/bash
# list only the names of all yroots.  Useful for looping over yroots in yinst
yroot --list|awk '{print $1}'
