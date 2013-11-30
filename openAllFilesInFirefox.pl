#!/usr/bin/perl
use strict;
use warnings;
use Cwd;

# get the input folder. 
my $directory = getcwd."/";
for my $part (@ARGV){
	# skip directories/files that start with one ore more . 
	if ( $part =~ m/^\.+/ ){ next }; 
	$directory = $directory.$part; 
}

print $directory;

# Open the given folder for reading.
opendir (DIR, $directory) or die $!;

my $base = "file://$directory/";
#print $base; 
my @files; 

# find all files in the folder. 
while (my $file = readdir(DIR)) {
	# skip files that start with one or multiple .
	if ( $file =~ m/^\.+/ ){ next }; 
	push(@files, $file);
}
closedir(DIR);

# Sort all files in the folder. 
@files = sort (@files);

my $params = "";
# for all files 
foreach my $item (@files){
#	print $base.$item."\n";
	# concatenate one long open firefox string, so that all files are opened in
	# one firefox instance.
	$params = $params." '".$base.$item."'";
}

# execute the open all files command. 
exec "firefox $params"; 

 
