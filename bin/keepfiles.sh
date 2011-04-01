#!/bin/bash
VERSION=1.0
function usage(){
	echo USAGE:
	echo "    $0 [-n] archive_filename"
	echo "    OPTIONS"
	echo "       -n -- dry run"
}

while getopts  "nhv" flag
do
	case $flag in
		h)
			usage;
			exit 1;;
		n)
			OPT_DRYRUN=1;;
		v)
			echo $0 VERSION $VERSION;
			exit 0;;
	esac
done

if [[ -z $1 ]]; then
	echo "ERROR: archive_file is required"
	usage
	exit 1
fi

svn status |egrep '^M|^ M|^\?' | awk '{print $2}' |xargs tar -cf $1
