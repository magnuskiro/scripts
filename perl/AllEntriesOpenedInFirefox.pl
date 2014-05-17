#!/usr/bin/perl
use strict;
use warnings;

my $arg = shift @ARGV;

my $base = "https://underdusken.no/intern/medarbeidere/";
# Open the given folder for reading.

open(FILE, $arg) or die $!;

my $params = "";

while (<FILE>) {
	print $base.$_."\n";
	#$params = $params." '".$base.$_."'";
}
closedir(DIR);

#exec "firefox $params";

