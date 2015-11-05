#!/usr/bin/perl

# ##
# TODO:
# - make the script recurseive with -r paramater. Traversin all subfolders for files of the given parameters.
#
# ##

use strict;
use warnings;
use Cwd;

# if we get no file extension crash
die("No file extension given!") unless $ARGV[0];

sub countFolder {
    # get the directory to count lines of code.
    my $dir = shift @_;
    # get the file extensions we want to count lines in.
    my @extensions = @_;

    #print "-- ".$dir." ".$extensions[0]." ".@extensions."\n";

    my $count = 0;

    # init the directiory variable.
    my $mydir;
    # Open the given folder for reading.
    opendir ($mydir, $dir) or die $!;

    # find all files in the folder.
    while (my $file = readdir($mydir)) {
        # for all the file extensions
        for my $extension (@extensions){
            # skip . and .. files.
            if ( $file =~ m/^\.+/ ){ next };
            # if directory: do recursion
            if ( -d $file ) {
                #print "---\n";
                # add the line count of a folder to the total.
                $count += countFolder($dir.$file."/", $extension);
            }
            # if wanted file extension
            if ( $file =~ m/\.$extension$/ ){
                # if we get line count from wc
                if (`wc -l $dir$file` =~ m/(^\d*)/ ){
                    #print $1." ".$file."\n";
                    # add the number to the total count.
                    $count += $1;
                } else {
                    $count += 0;
                }
            }
        }
    }
    # close the directory.
    closedir($mydir);

    # return the code lines count.
    return $count;
}

# input the current working directory and array of file extensions
print "Lines of '@ARGV' Code: ".countFolder(getcwd."/", @ARGV) . "\n";

