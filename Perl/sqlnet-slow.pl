#!/u01/app/oracle/product/11.2.0/db/perl/bin/perl

# emulate slow sql due to Windows In band breaks with HPUX 11 v3
# when hires timer is not set correctly (which is default)
# SQL elapsed time dramatically increases on HP-UX 11i v3 (Doc ID 1313110.1)

use warnings;
use FileHandle;
use DBI;
use strict;
use Time::HiRes qw( usleep);


my($db, $username, $password) =
(
   'js03',
   'scott',
   'tiger'
) ;


my $dbh = DBI->connect(
   'dbi:Oracle:' . $db,
   $username, $password,
   {
      RaiseError => 1,
      AutoCommit => 0
   }
);

# set array size 1
$dbh->{RowCacheSize} = 1;

printf "\n\nPlease press <ENTER> when ready:\n";
my $dummy=<>;
printf "Thank you\n";

my $sql='select level id from dual connect by level <= 1000000';

my $sth = $dbh->prepare($sql);
$sth->execute;

while ( my ($id) = @{$sth->fetchrow_arrayref}) {

   print "ud: $id\n";

   usleep(500000); # us
}

die "Connect to  $db failed \n" unless $dbh;

$dbh->disconnect;
