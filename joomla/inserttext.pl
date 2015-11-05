#! /usr/bin/perl -w
use strict;

=whatIsThis
This is a script that replaces the content text of a Joomla! language file.

See gettext.pl to see how the original text is compiled.

This script takes a inndata.txt file that contains the translated data.
And replaces the content of the filenames given on the command line.

=cut


# get the four file arguments.
my @files =  @ARGV;
my $cf = -1; # current file

# initialise data array.
my @a = ();
my @b = ();
my @c = ();
my @d = ();
my @input = (@a,@b,@c,@d);
my $ct; # current text.

# read the inndata file.
open (INN, '<inndata.txt');
while(<INN>) {
    $ct = $_;

    # if there is a new file, increment the file counter to add content to the right array.
    if( $ct =~ m/---*/){
        $cf++;
        #print $ct. "match\n";
        #print $cf."\n";
    }

    # push read data to the array.
    push(@{$input[$cf]}, $_);
}
close (INN);


# for all files
$cf = 0; # reset the file counter.
foreach my $f (@files){
    my $ln = 1; # line number of the current file.

    # print $f ."\n";

    # open the output file for writing.
    open(OUT, ">".$f."-1");

    # read the original file
    open(INND, "<$f");
    while(<INND>) {
        # split the line to get the content part.
        my @text = split(/"/, $_);

        # skip line if it contains nothing.
        next if($text[0] =~ m/\n/);

        # swap content for translated content.
        $text[1] = ${$input[$cf]}[$ln];
        # remote newline at end of line to make the output file cleaner.
        $text[1] =~ s/\n//g;

        # write the new line to the output file.
        print OUT $text[0]."\"".$text[1]."\"\n";

        # increment the line counter.
        $ln++;
    }
    close(INND);

    close(OUT);

    # increment the file counter to keep track of which file we're working on.
    $cf++;
}

exit();
