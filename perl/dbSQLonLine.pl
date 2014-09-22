#! /usr/bin/perl -w
use strict;
use DBI;

my %object;
my $sth;
#my $contact_sth = $dbh->prepare("INSERT INTO domains VALUES(?,?,?,?,?,?)");


#	get query from input.  
my $sql = "";
foreach my $a (@ARGV){
	$sql = $sql.$a;
	#print $a."\n"; 
}
print "query: '".$sql."'\n";

die unless defined $sql;

my $dbh;
my $host = 'underdusken.no';
my $db = 'barweb_dev';
my $user = 'barweb_dev';
my $pass = 'barweb_dev';

# 	create connection object.  
#	DBI:dbType:dbName:hostToConnectTo
my $connect = 'DBI:mysql:'.$db.':host='.$host;

#	connect to db. 
$dbh = DBI->connect($connect, $user, $pass) || die "Could not connect to database: $DBI::errstr";

# 	set UTF8
#$dbh->{'mysql_enable_utf8'} = 1;

# 	prepare sql query. 
my $search_sth  = $dbh->prepare($sql); 
# 	execte sql query. 
$search_sth->execute();

my $a = "
SELECT firstname, surname FROM person INNER JOIN vakt ON person.ID = vakt.ATTENDAND_ID OR person.ID = vakt.SECONDATTENDAND_ID WHERE vakt.TIME > '2013-01-01 00:00:59' ORDER BY person.firstname
";

my $count = 0;
# 	fetching all the result rows from the executed query. 
while ( my  @row = $search_sth->fetchrow_array ) {
	# 	for all fields in the sql record. 
	foreach my $s (@row){
		if(defined $s){		
			print $s;
		}else {
			print " ";
		}
		print "\t"; 
	}
	print "\n";
	$count ++;  
}
print "count = ".$count."\n"; 
