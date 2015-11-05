#!/usr/bin/perl
use strict;
use warnings;
use Cwd;

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
#    print $file."\n";
    if ($file =~ m/(.+)\.zip/){
        system("unzip '$file' -d '$1'");
#        print "unzip '$file' -d '$1' && "."\n";
    }
    elsif($file =~ m/(.+)\.rar/){
        system("mkdir '$1' && unrar e '$1.rar' && mv *.jpg '$1' && mv *.png '$1'");
#        print "mkdir $1 && unrar e '$file' && mv *.jpg $1 && mv *.png $1 && "."\n";
    }

}

exit();
