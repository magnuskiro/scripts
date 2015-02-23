#! /usr/bin/perl -w
use strict;
use utf8;
use DBI;
binmode(STDOUT, ":utf8");

# usage:
# perl script.pl sql statement;

#	get query from input.  
my $sql = "";
foreach my $a (@ARGV){
	$sql = $sql.$a." ";
	#print $a."\n"; 
}
$sql = $sql.";";
print "query: '".$sql."'\n";

die unless defined $sql;

print "INFO -- setting connection info\n";
my $dbh;
my $host = 'pegasus.underdusken.no';
my $db = 'udintern';
my $user = '';
my $pass = '';

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

my $filename = "internNyheter.txt";
open (FILE, ">> $filename") || die "problem opening $filename\n";
print FILE "<html><body>\n"; 

my $count = 0;
# 	fetching all the result rows from the executed query. 
while ( my @row = $search_sth->fetchrow_array ) {
#	foreach my $s (@row){
#		if(defined $s){		
#			print $s;
#		}else {
#			print " ";
#		}
#		print "\t"; 
#	}
#	print "\n";
#	print "!!---------------------------!!\n";
	#exit; 
	print FILE "<div class='internNyhet'>\n";
	print FILE "\t<p class='title'>".$row[1]."</p>\n";
	print FILE "\t<p class='time'>".$row[0]."</p>\n";
	print FILE "\t<p class='nyhet'>".$row[2]."</p>\n";
	print FILE "</div>\n";
	print FILE "<br />!!---------------------------!!<br />\n";
	$count ++;  
	#exit;
}
print FILE "</body></html>\n"; 
close(FILE);
print "count = ".$count."\n"; 
