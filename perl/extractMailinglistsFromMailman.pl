#!/usr/bin/perl

# purpose: extract all lists with member emails as text files.
# one file for each list is created.

# list_members and list_lists are mailman commands.

# Usage:
# cat ~/temp | emailHack.pl
# list_lists | emailHack.pl

use strict;

# takes input from pipe.
while (<STDIN>) {
#    print "$. $_";
    # for all lines in the pipe input get the name of the mailing list.
    if(m/([A-Za-z]+) -/){
        print $1."\n";
        # list members for the given list and pipe the output into a file named
        # with the list name.
        system("list_members '$1' > $1.txt");
    }
}

