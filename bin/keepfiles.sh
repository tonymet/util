#!/bin/bash
# preserve modified/unknown files from sandbox into a tar archive
# e.g.
#  $ keepfiles ../goodfiles.tar
#  $ cd ..
#  rm -rf sandbox
#  svn co project ./sandbox
#  tar -xf goodfiles.tar -C ./sandbox
VERSION=1.2
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
if [[ $OPT_DRYRUN -eq 1 ]]; then
	echo "DRY RUN"
	echo "KEEPING FILES:"
	svn status |egrep '^M|^ M|^\?' | awk '{print $2}'
	exit 0
fi
svn status |egrep '^M|^ M|^\?' | awk '{print $2}' |xargs tar -cf $1
