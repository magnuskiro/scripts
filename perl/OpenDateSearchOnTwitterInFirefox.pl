#!/usr/bin/perl
use strict;
use warnings;

# generate date file.

my $file = "daterange";
my @urls;

### open current file
# read file with dates
open(FILE, $file) or die $!;

# for all files in the line
while (<FILE>) {
    #print $_;
    push(@urls, $_)
}

# close file.
close(FILE);

my $base = "https://twitter.com/search?q=from%3ANorskoljeoggass OR from%3Aoljedir OR from%3Aoeddep OR from%3Atordlien OR from%3Aregjeringen OR from%3Asprellnar OR from%3ATordlien OR from%3AIndustriEnergi OR from%3AIndustriEnergiU OR from%3A_NITO_ OR from%3ANorskIndustri OR from%3ATekniskMuseum OR from%3AUniResearch OR from%3Alinetrezz OR from%3AGeirseljeseth OR from%3AREINERTSENAS OR from%3Aknebben OR from%3Akobbaen OR from%3AGroBraekken until%3A";

my $params = "";
# for all files
foreach my $item (@urls){
#    print $base.$item."\n";
    # concatenate one long open firefox string, so that all files are opened in
    # one firefox instance.
    $params = $params." '".$base.$item."'";
}

# execute the open all files command.
exec "firefox $params";

