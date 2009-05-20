#!/usr/bin/perl 
use Data::Dumper;
if($ARGV[0] eq ''){
	print "pattern argument required\n";
	exit(255);
}
else{
	$pattern = $ARGV[0];
}
while(<STDIN>){

	print "$1\n" if /$pattern/;
}
