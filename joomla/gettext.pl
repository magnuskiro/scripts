#! /usr/bin/perl -w
use strict;

=whatIsThis
This is a script to read Joomla! language files and get the content from them.
Typically we have something like THIS_STATIC_LANGUAGE_REFERENCE="This is wha text is displayed in the program".
Where we get the content between " and ".

Then we can use the output files content maually in translate.google.com to translate it.

Then we use the insertdata.pl script to cange the text in the language file.

=cut

# open the output file for the compiled data.
open (OUT, '>>data.txt');

#print @ARGV ."\n";

# for all input arguments / files
foreach my $a (@ARGV) {
    # print the file separator to the output file.
    print OUT "-----new file:".$a."-----\n";

# read the innput data from the files.
open(INNPUT, $a);
while(<INNPUT>) {
    # get the content to translate
    my @text = split(/"/, $_);

    # write the content to the output file.
    print OUT $text[1]."\n";

#    print $text[1] ."\n";
}
close(INPUT);

}


close (OUT);

exit();
