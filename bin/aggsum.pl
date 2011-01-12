#!/usr/bin/perl
# aggsum.pl
#  aggregate sum of numbers from stdin
my $sum = 0;
while(<>){
	$sum += $_;
}
print $sum;
