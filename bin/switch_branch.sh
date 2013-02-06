#!/bin/bash
root="$HOME/Documents/workspace/zla/"
if [[ ! -d $root ]];then
	echo "$root not found"
	exit 2
fi
branches=($(ls "$root/branches"))
i=1
for b in ${branches[*]}; do
		echo "$i) $b"
		i=$((i + 1))
done;
echo -n "pick one: "
read selection
branch_no=$((selection - 1 ));
echo "your selection: $selection"
if ! echo -n $branch_no | egrep '^[0-9]+$' > /dev/null; then
		echo "ERROR: selection must be a number"
		exit 1;
fi
if [[ $branch_no -lt 0 || $branch_no -gt ${#branches[@]} ]]; then
		echo "ERROR: choose a number between 1 and $((${#branches[@]} )) "
		exit 1
fi
branch_basename="${branches[$branch_no]}"

if [[ -h 'development' ]];then
	if ! rm -f "$root/development"; then
		echo "ERROR removing current development symlink";
		exit 2;
	fi
fi
if ! ln -s "$root/branches/$branch_basename" "$root/development"; then
	echo "ERROR linking $root/branches/$branch_basename" to "$root/development"
	exit 2;
fi
echo -n "current branch set to: "
readlink "$root/development"
