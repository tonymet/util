#!/bin/bash
RSYNC_OPTS="-zrltgoCD --delete"
VERSION="1.5"
function usage(){
	echo "$0 [-n -h -v]"
	echo "OPTIONS"
	echo "   -h help message"
	echo "   -t target host"
	echo "   -n -- dry run"
	echo "   -v -- display version"
	echo "   -s -- do not delete target files"
}

while getopts  "nshvt:" flag
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
		t)  OPT_REMOTE_HOST=$OPTARG;;
		s)  RSYNC_OPTS="-zrltgoCD";;
	esac
done
if [[ $OPT_DRYRUN -eq 1 ]];then
	RSYNC_OPTS="$RSYNC_OPTS"nP
	echo "DRY RUN ENABLED"
fi
RSYNC_COMMAND="rsync $RSYNC_OPTS"
# recognize a rsync.conf in the current directory
if [[ -f rsync.conf ]]; then
	RSYNC_COMMAND="rsync $RSYNC_OPTS --exclude-from=rsync.conf --delete --include core"
	echo "excluding files using rsync.conf"
fi
REMOTE_HOST=$zdev3
if [[ ! -z "$OPT_REMOTE_HOST" ]]; then
	REMOTE_HOST="$OPT_REMOTE_HOST"
fi
echo "syncing files to $REMOTE_HOST"
WORKSPACE=\~/workspace
PROJECT=`basename $(pwd)`

$RSYNC_COMMAND ./ $USER@$REMOTE_HOST:"$WORKSPACE/$PROJECT"
