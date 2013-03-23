#!/usr/bin/perl

use strict;
use warnings;

die("NO image directory given") unless $ARGV[0];

# get the directory from input. 
my $dir = $ARGV[0];

# open the directorey for reading
opendir(DIR, $dir) or die $!;

# while reading new file in the directory
while (my $file = readdir(DIR)) {

	# skipp file
	next if ($file eq "c.pl");
    
	# Use a regular expression to ignore files beginning with a period (.fielname)
	# skip file
    next if ($file =~ m/^\./);

	#print "$file\n";
	
	# get filename 
	$file =~ m/(.*)\./;

	#print $1."\n"; 
	#print "convert -resize 25% ".$file." ".$1."-1.JPG"."\n";

	# creates a resized replica. 
	# execute resize for one image at a time. 
	system("convert -resize 25% ".$file." ".$1."-1.JPG"); 

}

# close the reading directory. 
closedir(DIR);
exit 0;
