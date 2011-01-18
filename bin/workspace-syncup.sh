#!/bin/bash
RSYNC_OPTS="-zrltgoCD"
if [[ $1 == "-n" ]];then
	RSYNC_OPTS="$RSYNC_OPTS"nP
	echo "DRY RUN ENABLED"
fi
RSYNC_COMMAND="rsync $RSYNC_OPTS --delete --include core"
# recognize a rsync.conf in the current directory
if [[ -f rsync.conf ]]; then
	RSYNC_COMMAND="rsync $RSYNC_OPTS --exclude-from=rsync.conf --delete --include core"
	echo "excluding files using rsync.conf"
fi
REMOTE_HOST=$zdev1
echo "syncing files to $REMOTE_HOST"
WORKSPACE=\~/workspace
PROJECT=`basename $(pwd)`

$RSYNC_COMMAND ./ $USER@$REMOTE_HOST:"$WORKSPACE/$PROJECT"
