#!/bin/sh
pid=$$
commandUsage(){
echo "______________"
echo "Command Usage:"
  echo "./create_package.pl <BASEDIR> <PROJ> <APPL> <RFC> <TYPE> <PKG>"
echo ""
}

configFile="/home/Drive2/rpm-gen/conf/gen.config"
. $configFile
logFile="$log/createlog.$pid"
echo "$logFile - saif"

baseDirectory=$1
projectName=$2
applicationName=$3
rfcNum=$4
packageType=$5
packageName=$6

if [ $# -ne 6 ]; then
  commandUsage
  exit 1
fi

baseDirectory=/home/Drive2/test

packageDirectory="$baseDirectory/$projectName/$applicationName/$rfcNum/$packageName"
if [ -d $packageDirectory ]; then
  echo "[Error]: Package already exist, exiting..." >> $logFile
  exit 1
fi
$bin/packageDb.pl checkPackageInDb $baseDirectory $projectName $applicationName $rfcNum $packageType $packageName $logFile
if [ $? -eq 0 ]; then
  if [ $packageType = "generic" -o $packageType = "webinfra" -o $packageType = "webapp" -o $packageType = "dbaas" -o $packageType = "usrgrp" ]; then
    mkdir -p $packageDirectory > /dev/null
    [ $? -eq 0 ] && echo "[INFO]: Package Directory $packageDirectory Created" >> $logFile
    cp -pR $template/$packageType/* $packageDirectory >/dev/null
    if [ $? -eq 0 ]; then
      echo "[INFO]: Type $packageType created for package $packageName" >> $logFile
    else
      echo "[ERROR]: Can't create $packageType for $packageName, exiting..."
      exit 1
    fi
  else
    echo "[ERROR]: Bad Package Type $packageType exiting..." >> $logFile
    exit 1
  fi
fi
$bin/packageDb.pl insertPackageInDb $baseDirectory $projectName $applicationName $rfcNum $packageType $packageName $logFile
