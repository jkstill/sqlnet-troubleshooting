#!/usr/local/bin/perl -w

# Jared Still 2014
# DIY oerr
# jkstill@gmail.com

use strict;

my ($product,$err)=@ARGV[0..1];

die "usage: oerr.pl product error - eg. oerr.pl ora 1555\n" unless ($product and $err);

# not all error files pad with zero
# project for some other time
$err=substr('0000'.$err,-5);

my $f="$ENV{ORACLE_HOME}/rdbms/mesg/${product}us.msg";
my $errmsg;

-r $f || die "cannot open \"$f\" - $!\n";

print "product: $product\n";
print "error: $err\n";

open (F,"<",$f);

while (<F>) {
	next unless /^$err,/; # find the error from the cmdline
	$errmsg = $_;
	last;
}

# continue scanning file
while (<F>) {
	last unless /^\/\//; # read the file and you will understand
	$errmsg .= $_;
}

print $errmsg;
