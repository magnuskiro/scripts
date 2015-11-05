#! /usr/bin/perl -w
use strict;
use DBI;

my %object;
my $sth;
#my $contact_sth = $dbh->prepare("INSERT INTO domains VALUES(?,?,?,?,?,?)");


my $dbh;
my $host = 'underdusken.no';
my $db = "barweb_dev";
my $user = 'barweb_dev';
my $pass = 'barweb_dev';

#    DBI:dbType:dbName:hostToConnectTo
my $connect = 'DBI:mysql:'.$db.':host='.$host;


$dbh = DBI->connect($connect, $user, $pass) || die "Could not connect to database: $DBI::errstr";
#$dbh->{'mysql_enable_utf8'} = 1;


my $sql1 = "
SELECT  `ID` ,  `MONEY` ,  `USERNAME` ,  `TIMECREATED` ,  `FIRSTNAME` ,  `SURNAME` ,  `lastModified`
FROM  `person`
WHERE  `FIRSTNAME` IS NULL
ORDER BY  `person`.`TIMECREATED` DESC
";


my $sql2 = "
SELECT
`ID` ,
`CARDID` ,
`ACTIVE` ,
`EXTERNALID` ,
`emailaddress` ,
`MONEY` ,
`USERNAME` ,
`FIRSTNAME` ,
`SURNAME`,
`TIMECREATED` ,
`GJENG_ID` ,
`version`
FROM `person`
WHERE  `TIMECREATED` >  '2012-09-01 11:43:56'
";

my $sql = "
SELECT
`FIRSTNAME` ,
`SURNAME`,
`MONEY`
FROM `person`
WHERE `ACTIVE` = '1' AND `GJENG_ID` = '2'
ORDER BY `FIRSTNAME` ASC
";

my $search_sth  = $dbh->prepare($sql);
$search_sth->execute();

#print "id\t\tsaldo\t\tuser\t\tTcreate\t\t\tFname\tSname\tLmod\n";
print "ID:CARDID:ACTIVE:EXTERNALID:EMAIL:MONEY:USERNAME:NAME:TIMECREATED:GJENG_ID:version\n";

my $count = 0;
# while rows in result
while ( my  @row = $search_sth->fetchrow_array ) {
    # for all fields in this row
    foreach my $s (@row){
        # if the field exists
        if(defined $s){
            print $s;
        # if the field does not exist.
        }else {
            print "-";
        }
        print " ";
    }
    print "\n";
    # count to keep track of the number of the results.
    $count ++;
}
print "count = ".$count."\n";
