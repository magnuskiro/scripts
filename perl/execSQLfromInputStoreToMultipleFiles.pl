#! /usr/bin/perl -w
use strict;
use DBI;

# usage: 
# perl execSQLfromInputToFiles.pl host db user pass select * from table; 

print "INFO -- setting connection info\n";
my $dbh;
my $host = shift @ARGV;
my $db = shift @ARGV;
my $user = shift @ARGV;
my $pass = shift @ARGV;

#	get query from input.  
print "INFO -- creating sql\n";
my $sql = "";
foreach my $a (@ARGV){
	$sql = $sql.$a." ";
	#print $a."\n"; 
}
$sql = $sql.";";
print "query: '".$sql."'\n";

die unless defined $sql;

# 	create connection object.  
#	DBI:dbType:dbName:hostToConnectTo
my $connect = 'DBI:mysql:'.$db.':host='.$host;

#	connect to db. 
print "INFO -- connecting to DB\n";
$dbh = DBI->connect($connect, $user, $pass) || die "Could not connect to database: $DBI::errstr";

# 	set UTF8
$dbh->{'mysql_enable_utf8'} = 1;

# 	prepare sql query. 
print "INFO -- prepearing statement\n";
my $search_sth  = $dbh->prepare($sql); 
# 	execte sql query. 
$search_sth->execute();

print "INFO -- executing fetch\n";
my $count = 0;
# 	fetching all the result rows from the executed query. 
while ( my  @row = $search_sth->fetchrow_array ) {
	my $filename = @row[0]."-".@row[1];
	$filename=~s/\//-/g;
	print "INFO -- exporting '$filename'\n";
	open (FILE, ">> $filename.wiki") || die "problem opening $filename\n";
	
	my $record = ""; 
	# 	for all fields in the sql record. 
	foreach my $s (@row){
		if(defined $s){		
			$record = $record.$s;
			#print $s;
		}else {
			$record = $record." ";
			#print " ";
		}
		$record = $record."\t";
		#print "\t"; 
	}
	$record = $record."\n";
	print FILE $record;
	close(FILE);
	$count ++; 
	# exit here for testing, exits after the first row is fetched. 
	#exit;  
}
print "count = ".$count."\n"; 
