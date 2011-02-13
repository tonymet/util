#!/bin/bash
# backup homedir using rsync
RSYNC_OPTS="-zrltgoDP --modify-window=60"
RSYNC_CONF="$HOME/rsync-thumb.conf"
VERSION=1.1
while getopts "n" OPTION
do
case $OPTION in
	n) OPT_DRYRUN=1;;
esac
done

if [[ $OPT_DRYRUN -eq 1 ]];then
	RSYNC_OPTS="$RSYNC_OPTS -n"
	echo "DRY RUN ENABLED"
fi
RSYNC_COMMAND="rsync --exclude-from=$RSYNC_CONF $RSYNC_OPTS --delete --include core"
if [[ `uname -s` == 'Darwin' ]]; then
	DEST_DRIVE="/Volumes/THUMB"
elif [[ `uname -s` == 'Cygwin' ]]; then
	DEST_DRIVE="/cygdrive/e/"
fi
if [[ ! -d "$DEST_DRIVE" ]]; then
	echo "ERROR: $DEST_DRIVE is not a dir"
	exit 1;
fi
DEST_DIR="$DEST_DRIVE/current/"
if [[ ! -d "$DEST_DIR" ]]; then
	echo "ERROR: $DIST_DIR doesn't exist"
	exit 1
fi
echo "syncing up $HOME to $DEST_DIR"
$RSYNC_COMMAND $HOME/  $DEST_DIR
