#!/usr/bin/perl -w

=head1 Bibliography

Perl Cookbook, 2nd Edition
Tom Christiansen

Nathan Torkington

=cut

use strict;
use Net::Ping;

die "tcpping <hostname>\n" unless $ARGV[0];
my $host=shift;
my $net = Net::Ping->new('tcp');

if ($net->ping($host) ) { print "$host is alive\n" }
else { print "$host unreachable\n" }

