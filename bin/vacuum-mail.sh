#!/bin/bash
SQLITE=/usr/bin/sqlite3
db="$HOME/Library/Mail/Envelope Index"
if test ! -f "$db"  ;then
	echo "$db doesn't exist"
	exit 255;
fi
if ps -A -U tonym|grep -c 'Mail\.app' >/dev/null; then
	echo "Mail.app is running.  Exit first before running $0";
	exit 255
fi
echo 'getting tables'
tables=`$SQLITE  "$db" .tables`
echo "Preparing to vacuum $tables"
for t in $tables;do
	echo "Vacuuming $t..."
	$SQLITE "$db" "vacuum $t"
	echo "Done"
done
