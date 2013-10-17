#!/usr/bin/perl

# get file to search from the first input argument
my $arg = $ARGV[0];
my $arg2 = $ARGV[1];

# open current file
open(FILE, $arg) or die $!;

# for all lines in the file
while (<FILE>) {
	# TODO fix. 
	if ($arg2){
    	# if the line contains en email address
    	if(m/([-A-Za-z0-9\.]*@[A-Za-z0-9\.]*\.[a-z]{2,4})/){
    		# print the address
    		print $1, "\n";
    	} 
	}

}

# close file. 
close(FILE);

