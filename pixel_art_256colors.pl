#!/usr/local/bin/perl

use strict;
use warnings;

while (<>) {
  chomp;
  my @colors = split(/\s+/, $_);
  for (my $i=0; $i<=$#colors; $i++) {
    if ($colors[$i] =~ /^([12]?[0-9])?[0-9]$/) {
      if (0 <= $colors[$i] && $colors[$i] <= 255) {
        print "\e[48;5;$colors[$i]m  ";
      } else {
        print "\e[0m  ";
	  }
    } else {
      print "\e[0m  ";
	}
  }
  print "\e[0m\n";
}

