#!/usr/bin/perl -s
use warnings;
use strict;
use DBI;

sub commandUsage{
  print "______________\n";
  print "Command Usage:\n";
    print "./create_package.pl <PROJ> <APPL> <RFC> <PKG>\n\n";
}

my $baseDirectory = shift;
my $applicationName = shift;
my $rfcNumber = shift;
my $packageName = shift;
my $packageDirectory = "$baseDirectory/$applicationName/$rfcNumber/$packageName";
if ( -d $packageDirectory ){
  print "checkPackageLocOnSys OK\n";
}else{
  print "checkPackageLocOnSys NOK\n";
}


sub checkPackageMapInDb{
  my $dbName = 'Application';
  my $dbUser = 'saif';
  my $dbPass = 'password';
  my $projectName = shift;
  my $applicationName = shift;
  my $rfcNum = shift;
  my $packageName = shift;
  my $dbh = DBI->connect("DBI:mysql:$dbName", "$dbUser", "$dbPass") or die "Couldn't open database: $DBI::errstr; stopped";
  my $myQuery = "SELECT count(*) FROM Application.Project WHERE ProjectName=\'$projectName\' AND ApplicationName=\'$applicationName\' AND RfcNum=$rfcNum AND PackageName=\'$packageName\'";
  my $sth = $dbh->prepare($myQuery);
  $sth->execute() or die $DBI::errstr;
  my $row = $sth->fetchrow_array();
  if ( $row!=1 ){
    print "checkPackageLocOnDb NOK\n";
  }else{
    print "checkPackageLocOnDb OK\n";
  }
}

sub createPackageLocOnSys{
  my $baseDirectory = shift;
  my $applicationName = shift;
  my $rfcNumber = shift;
  my $packageName = shift;
  my $packageDirectory = "$baseDirectory/$applicationName/$rfcNumber/$packageName";
  if (1){
    print "createPackageLocOnSys OK\n";
  }else{
    print "createPackageLocOnSys NOK\n";
  }
}

sub insertPackageMapInDb{
  my $dbName = 'Application';
  my $dbUser = 'saif';
  my $dbPass = 'password';
  my $projectName = shift;
  my $applicationName = shift;
  my $rfcNum = shift;
  my $packageName = shift;
  my $dbh = DBI->connect("DBI:mysql:$dbName", "$dbUser", "$dbPass") or die "Couldn't open database: $DBI::errstr; stopped";
  if(1){
    print "createPackageOnDb OK\n";
  }else{
    print "createPackageOnDb NOK\n";
  }
}

sub copyNewPackage{
  my $tempDir = "/home/Drive2/rpm-gen/templates/generic";
  my $newDir = "$packageDirectory";
  print "$tempDir\n";
  print "$newDir\n";
}

my $noOfArgs = $#ARGV + 1;
my @listOfArgs = @ARGV;

if ( $noOfArgs!=4 ) {
  commandUsage();
}else{
  print "-----------------------------\n";
  #checkPackageLocOnSys(@listOfArgs);
  #checkPackageMapInDb(@listOfArgs);
  #createPackageLocOnSys(@listOfArgs);
  #insertPackageMapInDb(@listOfArgs);
  copyNewPackage();
  print "-----------------------------\n";
}
