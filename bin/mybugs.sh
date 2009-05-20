#!/bin/bash
# fetch my bugs via my devbox
sl='ssh -t laughterniece-vm1.santamonica.corp.yahoo.com'
$sl  /home/y/bin/ybug search "\"Tickets I own\"" -Tbbrief
