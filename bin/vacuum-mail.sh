#!/bin/bash
SQLITE=/usr/bin/sqlite3
db="$HOME/Library/Mail/Envelope Index"
echo -n "Index size before vacuum: " 
VERSION=1.1
OPT_DRYRUN=0
usage(){
	echo "$0 version $VERSION"
	echo "$0 [options]"
	echo "options:"
	echo "    -f FILENAME the filename to vacuum.  The default is $db"
	echo "    -h Display help"
	echo "    -v Display version"
	echo "    -n dryrun"
	exit 1
}

while getopts "nf:" OPTION
do
	case $OPTION in
		f) OPT_FILENAME="$OPTARG";;
		h)
			usage;
			exit 1;;
		v)
			echo "$0 VERSION $VERSION";
			exit 0;;
		n)
			OPT_DRYRUN=1;;
	esac
done
if [[ $OPT_FILENAME ]]; then
	db="$OPT_FILENAME"
fi
echo "Version $VERSION"
du -sh "$db"
if test ! -f "$db"  ;then
	echo "$db doesn't exist"
	exit 255;
fi
if ps -A -U $USER|grep -c 'Mail\.app' >/dev/null; then
	echo "Mail.app is running.  Exit first before running $0";
	exit 255
fi
echo 'getting tables'
tables=`$SQLITE  "$db" .tables`
echo "Preparing to vacuum $tables"
for t in $tables;do
	echo "Vacuuming $t..."
	if [[ $OPT_DRYRUN -eq 0 ]]; then
		$SQLITE "$db" "vacuum $t"
	else
		echo $SQLITE "$db" "vacuum $t"
	fi
	echo "Done"
done
echo -n "Index size after vacuum: " 
du -sh "$db"
