#!/bin/bash
SQLITE=/usr/bin/sqlite3
db="$HOME/Library/Mail/Envelope Index"
VERSION=1.2
OPT_DRYRUN=0
OPT_SKYPE=0
function check_running_app(){
	if ps -A -U $USER|grep -c "$1" >/dev/null; then
		echo "$1 is running.  Exit first before running $0";
		exit 255
	fi
}
usage(){
	echo "$0 version $VERSION"
	echo "$0 [options]"
	echo "options:"
	echo "    -f FILENAME the filename to vacuum.  The default is $db"
	echo "    -s Do Skype instead of Mail"
	echo "    -h Display help"
	echo "    -v Display version"
	echo "    -n dryrun"
	exit 1
}

while getopts "snf:" OPTION
do
	case $OPTION in
		f) OPT_FILENAME="$OPTARG";;
		h)
			usage;
			exit 1;;
		s) OPT_SKYPE=1;;
		v) echo "$0 VERSION $VERSION";
			exit 0;;
		n)
			OPT_DRYRUN=1;;
	esac
done
if [[ $OPT_FILENAME ]]; then
	db="$OPT_FILENAME"
fi
if [[ $OPT_SKYPE -eq 1 ]]; then
	db=`find ~/Library/Application\ Support/Skype/ -iname main.db`
fi
#echo "$db"
#exit
echo "Version $VERSION"
if [[ $OPT_SKYPE -eq 1 ]]; then
	check_running_app "Skype\.app"
else
	# test Mail.app by default
	check_running_app "Mail\.app"
fi
# set IFS to \n to allow spaces
IFS=$'\n'
for dbfile in $db; do
	echo -n "Index size before vacuum: "
	du -sh "$dbfile"
	if test ! -f "$dbfile"  ;then
		echo "$dbfile doesn't exist"
		exit 255;
	fi
	echo 'getting tables'
	tables=`$SQLITE  "$dbfile" .tables`
	echo "Preparing to vacuum $tables"
	# default IFS
	unset IFS
	for t in $tables;do
		echo "Vacuuming $t..."
		if [[ $OPT_DRYRUN -eq 0 ]]; then
			$SQLITE "$dbfile" "vacuum $t"
		else
			echo $SQLITE "$dbfile" "vacuum $t"
		fi
		echo "Done"
	done
	echo -n "Index size after vacuum: "
	du -sh "$dbfile"
	# quirky IFS for loop
	IFS=$'\n'
done
