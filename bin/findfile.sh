#!/bin/bash
# find files by name.  Then pass remaining args to find
filename=$1
shift
find . -iname "$filename" "$@" 
