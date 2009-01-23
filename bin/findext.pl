#!/usr/bin/perl
# find files with the given args as an extension
my @cmd_args;
foreach (@ARGV){
	push @cmd_args, "-iname \*.$_";
}
$cmd = "find . " . join (' -or ', @cmd_args);
system $cmd;