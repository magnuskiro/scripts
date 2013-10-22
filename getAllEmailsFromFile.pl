#!/usr/bin/perl

# Usage:
# arg1= input file. 
# @ARGV = the extensions that we don't want. 

# get file to search from the first input argument
my $arg = shift @ARGV;
my $count = 0;

# open current file
open(FILE, $arg) or die $!;

# for all lines in the file
while (<FILE>) {
   	# if the line contains en email address
	if(m/([-A-Za-z0-9\.]*@[A-Za-z0-9\.]*\.[a-z]{2,4})/){
		# todo
		# if the email address contains something don't use it. 
		# if ($1 ~= m/$arg2/){
		foreach my $item (@ARGV){
			# TODO fix so that we only prints once for all the items we don't
			# want. 
			if (not m/$item/){
    			# print the address
				$count += 1;
    			print $1, "\n";
			}
    	} 
	}
}

# close file. 
close(FILE);

print $count."\n";

