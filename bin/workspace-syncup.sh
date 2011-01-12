#!/bin/bash
RSYNC_COMMAND="rsync -zrltgoCD  --delete --include core"
REMOTE_HOST="laughterniece-vm1.santamonica.corp.yahoo.com"
WORKSPACE=\~/workspace
PROJECT=`basename $(pwd)`

$RSYNC_COMMAND ./ $USER@$REMOTE_HOST:"$WORKSPACE/$PROJECT"
