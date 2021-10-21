%define _unpackaged_files_terminate_build 0
%define __jar_repack 0
Name: newpackage
Version: 1.0.2
Release: 1
Summary: Land-Based Trash Repository
License: SAIF:LICENCE
Distribution: NA
Vendor: Sanitation Workers of Washington, D.C.
URL: https://www.trash.gov/
Group: Application/Collectors
Packager: saifnaqviit3019@gmail.com
autoprov: yes
autoreq: yes
Prefix: /usr/local
BuildArch: noarch
BuildRoot: /usr/src/mymaven/target/rpm/newpackage/buildroot

%description
This is a sample using trash collection as an example.

%install

if [ -d $RPM_BUILD_ROOT ];
then
  mv /usr/src/mymaven/target/rpm/newpackage/tmp-buildroot/* $RPM_BUILD_ROOT
else
  mv /usr/src/mymaven/target/rpm/newpackage/tmp-buildroot $RPM_BUILD_ROOT
fi

%files

%attr(440,dumper,dumpgroup) "/usr/local/rpmpackage/bin"
%attr(777,dumper,dumpgroup) "/usr/local/rpmpackage/log"
%attr(440,dumper,dumpgroup) "/usr/local/rpmpackage/conf"

%pre
echo "installing Land-Based Trash Repository now"

%post

%preun
