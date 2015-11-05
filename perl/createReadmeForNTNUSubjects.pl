#!/usr/bin/perl
use strict;
use warnings;
use Cwd;

use LWP::Simple qw(get);
use JSON        qw(from_json);
use Text::Unidecode; # make sure to install with 'sudo cpanm Text::Unidecode'


# get directories in folder
sub getDirsInDirectory{
    # get the name of the directory as first input argument.
    my $directory = $_[0];

    # Open the given folder for reading.
    opendir (DIR, $directory) or die $!;

    # directories array
    my @dirs;

    # find all files in the folder.
    while (my $file = readdir(DIR)) {
        # skip if the subject code does not match the regex pattern ('io1000'/'tdt4100')
        if ( not $file =~ m/.{2,3}\d{4}/ ){ next };
        push(@dirs, $file);
    }
    closedir(DIR);

    # sort all files in the folder
    @dirs = sort (@dirs);

    # debug - printout.
#    for my $dir (@dirs){
#        print $dir."\n";
#    }
#    exit();

    # return sorted directories.
    return @dirs;
}

# query the api for the subject information, given the subject code.
sub getSubjectHashFromAPI{
    # the subject code.
    my $subject = $_[0];
    #my $subject = "iø1000";

    # api location for the subject database.
    my $apiURL = "http://ime.ntnu.no/api/course/en/";
    my $subjectHash = from_json(get($apiURL.$subject));
    #print $subjectHash."\n";

    # checking if the subject exists,.
    if ( not defined $subjectHash->{'course'} ){
        # substitute o with ø in the subject code.
        $subject =~ s/o/ø/g;
        print "INFO -- subject not found in api, retrying with '".$subject."'\n";
        #print $subject."\n";
        # testing with o substituted with ø
        $subjectHash = from_json(get($apiURL.$subject));
        if ( not defined $subjectHash->{'course'} ){
            print "INFO -- subject still not found: skipping subject\n";
        };
    };

    # print content of hash.
#   while((my $key, my $value)=each%{$subjectHash}){
#       print "$key => $value\n";
#       while((my $key1, my $value1)=each%{$value}){
#           print "$key1 => $value1\n";
#       }
#   }

    return $subjectHash;
}

# get readme line for Parent readme
sub getParentReadmeLine{
# the subject hash
    my $subjectHash = $_[0];
    my $code = unidecode($subjectHash->{'course'}->{'code'});
    # if the subject is not found in the api use the folder name as code.
    if ( not defined $code ){
        $code = $_[1];
    }

    my $name = $subjectHash->{'course'}->{'name'};

    return "* ".$code." - ".$name."\n";
}

# create readme content as string from the hash containing the subject info.
sub getReadmeHeadingFromHash{
    # the subject hash
    my $subjectHash = $_[0];
    my $code = unidecode($subjectHash->{'course'}->{'code'});
    # if the subject is not found in the api use the folder name as code.
    if ( not defined $code ){
        $code = $_[1];
    }

    my $name = $subjectHash->{'course'}->{'name'};

    # Academic Content
    my $contentName = $subjectHash->{'course'}->{'infoType'}[2]->{'name'};
    my $contentText = $subjectHash->{'course'}->{'infoType'}[2]->{'text'};

    # Learning outcome
    my $learningName = $subjectHash->{'course'}->{'infoType'}[5]->{'name'};
    my $learningText = $subjectHash->{'course'}->{'infoType'}[5]->{'text'};

    return     $code." - ".$name."\n".
            "======\n".
            "Semester: ()<-- insert here:[v15/v11/h09/]\n".
            "\n".
            "# ".$contentName."\n".
            $contentText."\n".
            "\n".
            "# ".$learningName."\n".
            $learningText."\n";

}

# create and populate the readme file, given the subject code.
sub createReadme{
    # the subject code.
    my $subject = $_[0];
    print "INFO -- Creating readme for '$subject'\n";

    # get the subject hash from api.
    my $subjectHash = getSubjectHashFromAPI($subject);

    # create Readme
    my $filename = getcwd."/".$subject."/README.md";
    #my $filename = getcwd."/temp.md"; # debug line - TODO
    open (FILE, ">> $filename") || die "problem opening $filename\n";

    # write content to the new Readme.md file
    print FILE getReadmeHeadingFromHash($subjectHash, $subject);

    # close the opened file.
    close(FILE);
    return;
}

sub createReadmeFilesForSubjectsWithout{
    # get directories in folder
    my @dirs = getDirsInDirectory(getcwd."/");

    # for all found folders
    for my $dir (@dirs){
        # if the readme file does not exist.
        if ( not -e  $dir."/README.md" ){
            print "INFO -- Readme not found in '".$dir."'\n";
            createReadme($dir);
            #system('cat '.$dir.'/README.md');
            #exit(); # exit after first iteration.
        }
    }
}

sub updateParentReadme{
    # get directories in folder
    my @dirs = getDirsInDirectory(getcwd."/");

    my $filename = getcwd."/README.md";

    # for all found folders
    for my $subject (@dirs){
        # if the readme file does not exist.
        my $subjectHash = getSubjectHashFromAPI($subject);
        open (FILE, ">> $filename") || die "problem opening $filename\n";

        #print getParentReadmeLine($subjectHash, $subject);
        print FILE getParentReadmeLine($subjectHash, $subject);

        close(FILE);
    }
}

#createReadmeFilesForSubjectsWithout();
updateParentReadme();
exit();
