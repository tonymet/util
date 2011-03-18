#!/bin/bash
# backup homedir using rsync
RSYNC_OPTS="-zrltgoDP --modify-window=60"
RSYNC_CONF="$HOME/rsync.conf"
VERSION=1.2
if [[ $1 == "-n" ]]; then
	OPT_DRYRUN=1
fi
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
DEST_DIR="$DEST_DRIVE/backup/`hostname`/$HOME/"
if [[ ! -d "$DEST_DIR" ]]; then
	echo "making $DEST_DIR"
	if ! mkdir -p "$DEST_DIR"; then
		echo "ERROR making homedir"
		exit 1
	fi
fi
echo "Backing up $HOME to $DEST_DIR"
$RSYNC_COMMAND $HOME/  $DEST_DIR
