#!/usr/bin/perl

use strict;
use warnings;

use LWP::Simple qw($ua get);

# Gets UserAgent
$ua->agent('My agent/1.0');

# Gets html from url
my $url = "https://forums.ashesofcreation.com/discussion/46150/what-class-will-you-be-picking#latest";
my $html = get $url || die "Timed out!";

# Creates a hash to insert author-comment pairs into.
our %comments;

sub extractComments {
  # (str, hash) -> null
  # Takes html file from a page of the target comment thread and extracts
  # The commentors and associated comments as a key value pair in the
  # provided hash
  # ----------------------------


  # Makes a list with each line of the html as an element
  my @lines = split(/\n/, $_[0]);
  print "Number of lines: ", scalar @lines, "\n";

  # String to match with to find beginning of comment box
  my $commentBoxMatch = "<ul class=\"MessageList DataList Comments pageBox\">";

  # Finds where comment divider starts
  our $startCounter = 0;
  until ($lines[$startCounter] =~ /$commentBoxMatch/) {
    $startCounter++;
  }

  # For testing
  print " The comment thread divider tag is on line: $startCounter\n";
  print "The comment divider line is: $lines[$startCounter]\n";

  # Finds where comment thread ends on current page
  # Each comment is essentially an <li> element for a long <ul>
  our $endCounter = $startCounter;
  until ($lines[$endCounter] =~/<\/ul>/) {
    $endCounter++;
  }

  # For testing
  print "comment thread ends on line: $endCounter\n";
  print "comment thread ends on tag: $lines[$endCounter]\n";

  my @thread = splice(@lines, $startCounter, ($endCounter - $startCounter + 1));

  our $threadCounter = 0;
  foreach my $line (@thread) {
    print "Line number $threadCounter: $line\n";
    $threadCounter++;
  }

# End of subroutine extractComments
}

extractComments($html);
