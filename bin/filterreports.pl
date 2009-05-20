#!/usr/bin/perl 
$append = '@yahoo-inc.com' if($ARGV[0] eq '-e');
while(<STDIN>){
	print "$1$append\n" if /yahooid=(\w+)/ or /user_id=(\w+)/ 
}
