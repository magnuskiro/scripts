#!/usr/bin/perl
    use strict;
    use warnings;

    my $directory = '/home/kiro/Downloads/new/a/';

    opendir (DIR, $directory) or die $!;

my $base = "file:///home/kiro/Downloads/new/a/";
my @files; 

    while (my $file = readdir(DIR)) {
		push(@files, $file);

    }
    closedir(DIR);
	@files = sort (@files);
#	print @files;

	my $params;
	foreach my $item (@files){
#        print "$base$item\n";
		$params = "$params $base$item";
	}

		exec "firefox $params"; 

 
