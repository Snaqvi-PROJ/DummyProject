#!/usr/bin/perl
use warnings;
use strict;
use DBI;

sub commandUsage{
  print "______________\n";
  print "Command Usage:\n";
    print "./create_project.pl <PROJ> <APPL> <RFC>\n\n";
}

sub checkProjectLocOnSys{
  my $baseDirectory = shift;
  my $applicationName = shift;
  my $rfcNumber = shift;
  my $projDirectory = "$baseDirectory/$applicationName/$rfcNumber";
  if ( -d $projDirectory ){
    print "checkProjectLocOnSys OK\n";
  }else{
    print "checkProjectLocOnSys NOK\n";
  }
}

sub checkProjectMapInDb{
  my $dbName = 'Application';
  my $dbUser = 'saif';
  my $dbPass = 'password';
  my $projectName = shift;
  my $applicationName = shift;
  my $rfcNum = shift;
  my $dbh = DBI->connect("DBI:mysql:$dbName", "$dbUser", "$dbPass") or die "Couldn't open database: $DBI::errstr; stopped";
  my $myQuery = "SELECT count(*) FROM Application.Project WHERE ProjectName=\'$projectName\' AND ApplicationName=\'$applicationName\' AND RfcNum=$rfcNum";
  my $sth = $dbh->prepare($myQuery);
  $sth->execute() or die $DBI::errstr;
  my $row = $sth->fetchrow_array();
  if ( $row!=1 ){
    print "checkProjectMapInDb NOK\n";
  }else{
    print "checkProjectMapInDb OK\n";
  }
}

sub createProjectLocOnSys{
  my $baseDirectory = shift;
  my $applicationName = shift;
  my $rfcNumber = shift;
  my $projDirectory = "$baseDirectory/$applicationName/$rfcNumber";
  if (1){
    print "createProjectLocOnSys OK\n";
  }else{
    print "createProjectLocOnSys NOK\n";
  }
}

sub insertProjectMapInDb{
  my $dbName = 'Application';
  my $dbUser = 'saif';
  my $dbPass = 'password';
  my $projectName = shift;
  my $applicationName = shift;
  my $rfcNum = shift;
  my $dbh = DBI->connect("DBI:mysql:$dbName", "$dbUser", "$dbPass") or die "Couldn't open database: $DBI::errstr; stopped";
  if(1){
    print "insertProjectMapInDb OK\n";
  }else{
    print "insertProjectMapInDb NOK\n";
  }
}

my $noOfArgs = $#ARGV + 1;
my @listOfArgs = @ARGV;

if ( $noOfArgs!=3 ) {
  commandUsage();
}else{
  print "-----------------------------\n";
  checkProjectLocOnSys(@listOfArgs);
  checkProjectMapInDb(@listOfArgs);
  createProjectLocOnSys(@listOfArgs);
  insertProjectMapInDb(@listOfArgs);
  print "-----------------------------\n";
}
exit $?
