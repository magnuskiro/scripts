#!/usr/bin/perl
use strict;
use warnings;
use Cwd;

# list all files in folder
# get the input folder.
my $directory = getcwd."/";
for my $part (@ARGV){
    # skip directories that start with one ore more .
    if ( $part =~ m/^\.+/ ){ next };
    $directory = $directory.$part;
}

# Open the given folder for reading.
opendir (DIR, $directory) or die $!;
my @files;

# find all files in the folder.
while (my $file = readdir(DIR)) {
    # skip files that start with one or multiple .
    if ( $file =~ m/^\.+/ ){ next };
    push(@files, $file);
}
closedir(DIR);

# sort all files in the folder
@files = sort (@files);

for my $file (@files){
    print $file."\n";
    my $name = $file;
    $name =~ s/ - /-/;
    $name =~ s/ /./g;
    if ($name =~ m/(.+)-(\d{3})(.+)/){
        $name = $1.".S01E".$2.$3;
        #print $name."\n";
    }
    elsif ($name =~ m/(.+)-(\d{2})(.+)/){
        $name = $1.".S01E0".$2.$3;
        #print $name."\n";
    }
    system("mv '$file' '$name'");
}

exit();
