#!/bin/bash
# display checksums for file
if [ -f "$1" ]; then
	basename $1 | sed -e "s/\(.*\)/\1 \\\/"
	md5 $1 | sed -e "s/^MD5.*=/md5/" | sed -e "s/\(.*\)/\1 \\\/"
	openssl sha1 $1 | sed -e "s/^SHA1.*=/sha1/" | sed -e "s/\(.*\)/\1 \\\/"
	openssl rmd160 $1 | sed -e "s/^R.*=/rmd160/"
fi
