#!/usr/local/bin/perl

use strict;
use warnings;

while (<>) {
  chomp;
  my @colors = split(/\s+/, $_);
  for (my $i=0; $i<=$#colors; $i++) {
    if ($colors[$i] =~ /^[0-7]$/) {
      print "\e[4$colors[$i]m  ";
    } else {
      print "\e[0m  ";
	}
  }
  print "\e[0m\n";
}

