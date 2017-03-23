#!/usr/bin/perl -w

use strict;

# Jared Still
# 2014-11-16
# use with trcasst output
# currently for use with ADR tracefiles
# non ADR sqlnet tracefile does not have microseconds - Oracle 11.2.0.4 Linux 64bit
# Note the kludge for timestamps - look for adding '2' to timestamp

my ($rcvTime,$rcvMsecs,$sndTime,$sndMsecs);
my $skipCounter=0;
my $firstOp; # for later use when Send/Recv order unknown
use Date::Manip;

my $debug=0;

while (<>) {
   next unless /(Received|Send)\s+\d+\s/;
   print "Line: $_" if $debug;
   if ( $skipCounter++ == 0 ) {
      $firstOp = $1;
   }

   my $direction = $1; # value returned from previous - will be Send or Received
   chomp; # remove line termination character(s)
   my $line = $_;  # current input line
   #print $direction,"\n";

   print "Direction: $direction\n" if $debug;

   my ($dummy,$rawdate) = split(/=/,$line);
   my ($timestamp, $msecs) = split(/\./,$rawdate);

   # ADR timestamp is missing the '2' in 2014
   $timestamp = '2' . $timestamp;

   print "Timestamp: $timestamp\n" if $debug;

   if ( $direction =~ /^Received$/ ) {
      $rcvTime = $timestamp;
      $rcvMsecs = $msecs;
      print "$line\n" if $debug;
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
