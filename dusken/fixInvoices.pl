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
#$dbh->{'mysql_enable_utf8'} = 1;

# get all invoices affected
my $sql = "
SELECT id 
FROM `invoice`
WHERE  `TIMECREATED` >  '2012-09-21 00:43:56'
AND `TIMECREATED` <  '2013-03-23 00:43:56'
";

my $search_sth  = $dbh->prepare($sql); 
$search_sth->execute();

#print "ID|COMMENT|PAID|EXTERNALID|TIMECREATED|GJENG_ID|hidden|version|ownerperson_id|externalsource|lastModified\n";

my @invoices;

# store all invoice ids. 
while ( my  @row = $search_sth->fetchrow_array ) {
	push(@invoices, $row[0]);
}

# print @invoices; 

my $count =0;

# for each invoice id
foreach my $id (@invoices){
	#get affected transactions
	$sql = "
	SELECT transactions_ID
	FROM invoice_transaksjon
	WHERE Invoice_ID = ".$id."
	";
#	print $sql."\n"; 
	my $search_sth  = $dbh->prepare($sql); 
	$search_sth->execute();
	my @transactions;
	while ( my  @row = $search_sth->fetchrow_array ) {
		push(@transactions, $row[0]);
	}

	#for each affected transaction
	foreach my $t (@transactions){
		$sql ="
		UPDATE `transaksjon` 
		SET `INVOICE_ID` = '".$id."' 
		WHERE `ID` = '".$t."';
		";
		#print $sql."\n";
		#register the invoice id.
		my $search_sth  = $dbh->prepare($sql);
	    $search_sth->execute();

		$count = $count +1; 
 
	}
}

print $count."\n"; 

exit(); 
