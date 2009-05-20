#!/bin/bash
HOST="laughterniece-vm1.santamonica.corp"
SSH="ssh -t $HOST"
REMOTE_DIR=tmp/twiki
LOCAL_DIR=~/Temp/twiki
YTWIKI="/home/y/bin/ytwiki"
case $1 in
'edit')
	$SSH cd tmp/twiki\; $YTWIKI $1 $2
	rsync -az $HOST:$REMOTE_DIR/ $LOCAL_DIR/
	;;
'save')
	rsync -az $LOCAL_DIR/ $HOST:$REMOTE_DIR
	$SSH cd tmp/twiki\; $YTWIKI $1 $2
	;;
*)
	$SSH cd tmp/twiki\; $YTWIKI $1 $2
	;;
esac
