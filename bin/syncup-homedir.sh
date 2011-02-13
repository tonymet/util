#!/bin/bash
# backup homedir using rsync
RSYNC_OPTS="-zrltgoDP --modify-window=60"
RSYNC_CONF="$HOME/rsync-thumb.conf"
# default to delete
OPT_DELETE=1
VERSION=1.3
usage(){
	echo "$0 version $VERSION"
	echo "$0 [options]"
	echo "options:"
	echo "    -k do not delete"
	echo "    -n dry run"
	echo "    -d reverse sync (down)"
	exit 1
}

while getopts "dnkh" OPTION
do
case $OPTION in
	n) OPT_DRYRUN=1;;
	d) OPT_SYNCDOWN=1;;
	k) OPT_DELETE=0;;
	h) usage;
esac
done

if [[ $OPT_DRYRUN -eq 1 ]];then
	RSYNC_OPTS="$RSYNC_OPTS -n"
	echo "DRY RUN ENABLED"
fi
if [[ $OPT_DELETE -eq 1 ]];then
	RSYNC_OPTS="$RSYNC_OPTS --delete"
else
	echo "KEEP MISSING FILES ENABLED"
fi
RSYNC_COMMAND="rsync --exclude-from=$RSYNC_CONF $RSYNC_OPTS --include core"
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
if [[ $OPT_SYNCDOWN -eq 1 ]]; then
	echo "SYNCDOWN ENABLED"
	echo "syncing from $DEST_DIR to $HOME/"
	# rsync from drive to this computer
	$RSYNC_COMMAND $DEST_DIR/ $HOME
	exit $?
fi
$RSYNC_COMMAND $HOME/  $DEST_DIR
