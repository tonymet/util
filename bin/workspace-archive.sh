#!/bin/bash
if [[ -d $1 && -d $2 ]]; then
	dest="$2/`basename $1`.tgz"
	echo "Archiving $1 to $dest"
	tar -czf "$dest" $1
	if [[ $? -eq 0 ]]; then
		echo "removing $1"
		rm -rf $1;
	fi
else
	echo "Dir $1 or $2 does not exist";
fi
