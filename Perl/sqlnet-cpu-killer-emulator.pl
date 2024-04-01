#!/u01/app/oracle/product/11.2.0/db/perl/bin/perl

# emulate a condition where program is connected to db as well 
# as unknown remote connection 
# TCP to this connection is killing CPU

use warnings;
use FileHandle;
use DBI;
use strict;

my($localDB, $remoteDB, $username, $password) =
(
   'js03',
   'js02',
   'scott',
   'tiger'
) ;


my $localDBH = DBI->connect(
   'dbi:Oracle:' . $localDB,
   $username, $password,
   {
      RaiseError => 1,
      AutoCommit => 0
   }
);

die "Connect to  $localDB failed \n" unless $localDBH;

my $remoteDBH = DBI->connect(
   'dbi:Oracle:' . $remoteDB,
   $username, $password,
   {
      RaiseError => 1,
      AutoCommit => 0
   }
);

die "Connect to  $remoteDB failed \n" unless $remoteDBH;

sleep 99999;

$localDBH->disconnect;
$remoteDBH->disconnect;

