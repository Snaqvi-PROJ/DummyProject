#!/usr/bin/perl
use warnings;
use strict;
use DBI;

our $configFile="/home/Drive2/rpm-gen/conf/gen.config";
our $dbName = `cat $configFile|grep dbName|cut -d '=' -f2`;
our $dbUser = `cat $configFile|grep dbUser|cut -d '=' -f2`;
our $dbPass = `cat $configFile|grep dbPass|cut -d '=' -f2`;
chomp $dbName;
chomp $dbUser;
chomp $dbPass;
my @listOfArgs = @ARGV;
my $func = "$listOfArgs[0]";
my $baseDirectory = "$listOfArgs[1]";
my $projectName = "$listOfArgs[2]";
my $applicationName = "$listOfArgs[3]";
my $rfcNum = "$listOfArgs[4]";
my $packageType = "$listOfArgs[5]";
my $packageName = "$listOfArgs[6]";
my $logFile = "$listOfArgs[7]";
if ( $func eq "checkPackageInDb" ) {
  my $dbh = DBI->connect("DBI:mysql:$dbName", "$dbUser", "$dbPass") or die "Couldn't open database: $DBI::errstr; stopped";
  my $myQuery = "SELECT count(*) FROM Application.Package WHERE BaseDirectory=\'$baseDirectory\' AND Project=\'$projectName\' AND Application=\'$applicationName\' AND Rfc=\'$rfcNum\' AND Type=\'$packageType\' AND Name=\'$packageName\'";
  my $sth = $dbh->prepare($myQuery);
  $sth->execute() or die $DBI::errstr;
  my $row = $sth->fetchrow_array();
  if ( $row == 1 ) {
    my $insertLog = "[WARNING]: Package already exist in DB, exiting...";
    `echo $insertLog>>$logFile`;
    exit 1
  }
}elsif ( $func eq "insertPackageInDb" ) {
  my $insertLog = "[INFO]: Inserting Data in DB";
  `echo $insertLog>>$logFile`;
}
