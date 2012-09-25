#!/bin/bash
VERSION=1.3
function usage(){
	echo "$0 [-n -h] SANDBOX ARCHIVE_DIR "
	echo "OPTIONS"
	echo "   -h help message"
	echo "   -n -- dry run"
	echo "   -v -- display version"
	echo "   -m -- use rsync-media.conf"
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
		m) OPT_MEDIA=1;;
	esac
done
# some clumsy dereferencing to get the trailing arguments
source=`eval "expr \"\\$$OPTIND\""`
destind=$((OPTIND + 1))
destdir=`eval "expr \"\\$$destind\""`
if [[ -d $source && -d $destdir ]]; then
	dest="$destdir/`basename $source`.tgz"
	echo "Archiving $source to $dest"
	if [[ $OPT_DRYRUN -eq 1 ]];then
		echo tar -czf "$dest" $source
	else
		tar -czf "$dest" $source
		if [[ $? -eq 0 ]]; then
			echo "removing $source"
			rm -rf $source;
		fi
	fi
else
	echo "Dir $source or $destdir does not exist";
fi
