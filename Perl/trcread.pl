#!/usr/bin/env perl

# Jared Still
# 2014-11-16
# read ADR sqlnet traces to get times between packets
# currently for use with ADR tracefiles

use strict;
use warnings;
use Date::Manip;

my ($rcvTime,$rcvMsecs,$sndTime,$sndMsecs);
my $skipCounter=0;
my $firstOp; # for later use when Send/Recv order unknown

my $debug=1;

my $filename=shift @ARGV || die "please specify filename\n\n";

-r $filename || die "cannot read $filename - $!\n";

#print "\n\n";
#print "calculating time between sent data and next request\n";
#print "\nPress <ENTER> to continue\n";
#my $dummy=<>;
#print "\n\n";

open F,'<',$filename || die "cannot open $filename - $!\n";

=head1 identify packets

Send packet starts following this line:
: nsbasic_bsd:packet dump

Receive packet starts followin this line:
: nsbasic_brc:packet dump

=cut

my $packetStart=0;

while (<F>) {

	## there is now a space before 'packet', following a bracket
	#next unless /(:\snsbasic_bsd:\s*packet dump|:\snsbasic_brc:\s*packet dump)\s+/;
	next unless /(\snsbasic_bsd:\s*packet dump|\snsbasic_brc:\s*packet dump)\s+/;
	print "Line: $_" if $debug;
	chomp; # remove line termination character(s)
	my $line = $_;  # current input line

   my $packetType =  /nsbasic_brc:packet dump/ ? 'RCV' : 'SND';
   print "PacketType: $packetType\n" if $debug;

   if ( $skipCounter++ == 0 ) {
      $firstOp = $packetType;
   }

   # line following this will be first line of SND/RCV packet
   my $packetLine = <F> unless eof(F);
   print "PacketLine: $packetLine\n" if $debug;

   my ($rawdate,$rawtime,@dummy) = split(/\s+/,$line);
   my ($timestamp, $msecs) = split(/\./,$rawtime);

   $timestamp = $rawdate . ' ' . $timestamp;
   print "Timestamp: $timestamp\n" if $debug;

   if ( $packetType eq 'RCV' ) {
      $rcvTime = $timestamp;
      $rcvMsecs = $msecs;
      print "$line\n" if $debug;
      $packetStart=0;
   } else { # Send
      $sndTime = $timestamp;
      $sndMsecs = $msecs;
      print "$line\n" if $debug;
      next;
   }

   my $date1 = ParseDate($sndTime);
   my $date2 = ParseDate($rcvTime);

   my $epoch1 = UnixDate( ParseDate($sndTime), "%s" ) . '.' . $sndMsecs;
   my $epoch2 = UnixDate( ParseDate($rcvTime), "%s" ) . '.' . $rcvMsecs;

   print "epoch1: $epoch1\n" if $debug;
   print "epoch2: $epoch2\n" if $debug;

   my $delta = sprintf('%3.3f',$epoch2 - $epoch1);
   print "Delta: " if $debug;
   print "$delta\n";

}

#print "$firstOp\n";
