#!/bin/bash
if [[ -d $1 && -d $2 ]]; then
	dest="$2/$1.tgz"
	echo "Archiving $1 to $dest"
	tar -czf "$dest" $1
else
	echo "Dir $1 or $2 does not exist";
fi
