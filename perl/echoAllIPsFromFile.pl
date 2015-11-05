#!/usr/bin/perl

# get file to search from the first input argument
my $arg = $ARGV[0];

# open current file
open(FILE, $arg) or die $!;

# for all files in the line
while (<FILE>) {
    # if the line contains an ipv4  address
    if(m/\b(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\b/){
        # print that ipv4 address
        print $1, "\n";
    }

}

# close file.
close(FILE);

