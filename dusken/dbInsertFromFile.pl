#! /usr/bin/perl -w
use strict;
use DBI;

my %object;
my $sth;
#my $contact_sth = $dbh->prepare("INSERT INTO domains VALUES(?,?,?,?,?,?)");


my $dbh;
my $host = 'underdusken.no';
my $db = 'barweb_dev';
my $user = 'barweb_dev';
my $pass = 'barweb_dev';

#	DBI:dbType:dbName:hostToConnectTo
my $connect = 'DBI:mysql:'.$db.':host='.$host;


$dbh = DBI->connect($connect, $user, $pass) || die "Could not connect to database: $DBI::errstr";
$dbh->{'mysql_enable_utf8'} = 1;

my $sql = "
INSERT INTO `person` (
`ID` ,
`CARDID` ,
`ACTIVE` ,
`EXTERNALID` ,
`EMAIL` ,
`MONEY` ,
`USERNAME` ,
`NAME` ,
`TIMECREATED` ,
`GJENG_ID` ,
`version`
)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
"; 

my $query = $dbh->prepare($sql);

#foreach my $values (@people){
#	print $values; 
#	$query->execute(@{$values}); 
#}

open(USERS, "<barusers.txt");
while(<USERS>) {
	my @values = split(/\|/, $_); 
	pop @values;	
	#print @values."\n"; 
	#foreach my $v (@values){
	#	print $v."\|";
	#}
	#print "\n";
	
	$query->execute(@values);
}
close(USERS);

	
