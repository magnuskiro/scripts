#!/usr/bin/perl

# Usage:
#./getAllEmailsFromFile.pl fileWithEmailsInIt @notWantedEmail @notInterestedInThisOneEither
# arg1= input file. 
# @ARGV = regex expressions of email we don't want. 

# get file to search from the first input argument
my $arg = shift @ARGV;
my @mails;

# open current file
open(FILE, $arg) or die $!;

# for all lines in the file
OUTER_LOOP:
while (<FILE>) {
   	# if the line contains en email address
	if(m/([-A-Za-z0-9\.]+@[A-Za-z0-9\.]+\.[a-z]{2,4})/){
		# for all the regex expressions we want to exclude
    	foreach my $item (@ARGV){
            # if the email is unwanted skip to next.  
            if ($1 =~ m/$item/){
				# goes to the next step in the outer loop.
                next OUTER_LOOP;
            }
        }
		#print and count the email  
	    #print $1."\n";

		# push the found email to the array if the element don't already exist.
		push(@mails, $1) unless (grep {$_ eq $1} @mails);
	}
}

# close file. 
close(FILE);

foreach my $mail (@mails){
	print $mail."\n"; 
}
print "count: " . @mails ."\n";

