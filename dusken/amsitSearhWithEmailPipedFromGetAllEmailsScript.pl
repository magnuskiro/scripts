#!/usr/bin/perl

# dependencies:
	# getAllEmailsFromFile.pl - in ~/repost/scripts

# for all emails in the input file 
# 	open https://lists.samfundet.no/amsit/mediastud/search.cgi?q='query' in firefox 

# Usage:
# perl amsitSearhWithEmailPipedFromGetAllEmailsScript.pl fileWithEmailsInIt
# arg1= input file. 

# get filename from the first input argument
my $arg = shift @ARGV;

# get all email from the output of the other script. 
my @mails = `perl getAllEmailsFromFile.pl $arg`;

my $base = "https://lists.samfundet.no/amsit/mediastud/search.cgi?q=";

my $params = "";
# for all found emails 
foreach my $mail (@mails){
    if ( $mail =~ m/^count:/ ){ next }; 
	print $base.$mail."\n";
    # concatenate one long open firefox string, so that all files are opened in
    # one firefox instance.
    $params = $params." '".$base.$mail."'";
}

# execute the open all files command. 
exec "firefox $params";

