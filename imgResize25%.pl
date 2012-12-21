#!/usr/bin/perl

use strict;
use warnings;

die("NO image directory given") unless $ARGV[0];

my $dir = $ARGV[0];

opendir(DIR, $dir) or die $!;

while (my $file = readdir(DIR)) {

	next if ($file eq "c.pl");
    # Use a regular expression to ignore files beginning with a period
    next if ($file =~ m/^\./);

	#print "$file\n";
	$file =~ m/(.*)\./;
	#print $1."\n"; 
	#print "convert -resize 25% ".$file." ".$1."-1.JPG"."\n";
	system("convert -resize 25% ".$file." ".$1."-1.JPG"); 

}

closedir(DIR);
exit 0;
