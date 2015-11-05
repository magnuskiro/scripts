#!/usr/bin/perl
use strict;
use warnings;

# build query string from input args.
my $query = "";
for my $part (@ARGV){
    $query = $query.$part." ";
}

# stackoverflow.com site search
# [Perl] is a stack overflow tag, searching in posts tagged with perl.
my $stackbase = "http://stackoverflow.com/search?q=[Perl] ";

# perlmonks.org site search
my $pmbase = "http://perlmonks.org/?node=";

## query prepare
my $stackquery = $stackbase.$query;

$query =~ s/\s/\+/g;
my $pmquery = $pmbase.$query;

# execute the open all files command.
#print "firefox '$pmquery' '$stackquery'";
exec "firefox '$pmquery' '$stackquery'";

