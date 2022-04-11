#!/usr/bin/perl

use strict;
use warnings;

use LWP::Simple qw($ua get);

# -----------------------------------------------------------------------------
# User Agent Setup and main hash variable setup to store author-> comment pairs.
# -----------------------------------------------------------------------------

# Gets UserAgent
$ua->agent('My agent/1.0');

# Gets html from url
my $url = "https://forums.ashesofcreation.com/discussion/46150/what-class-will-you-be-picking#latest";
my $html = get $url || die "Timed out!";

# Creates a hash to insert author-comment pairs into.
our %comments;
# Stores the number of pages in the thread.
#our $NavNumber
# -----------------------------------------------------------------------------
# Subroutine to get Author name (For use by extractComments ONLY).
# -----------------------------------------------------------------------------

sub extractAuthor {
  # (str) -> str
  # (html line) -> Comment Author Name.
  # Takes a tag following the desired pattern and extracts the author name.
  # For use in extractComments subroutine.
  my $target = $_[0];
  our $nameEndCounter = 10;
  until (substr($target, $nameEndCounter+1, 7) eq "\" href=") {
    $nameEndCounter++;
  }
  return substr($target, 10, $nameEndCounter - 9)
}

# -----------------------------------------------------------------------------
# Subroutine to get Block Quote (For use by extractComments ONLY).
# -----------------------------------------------------------------------------

sub extractBlockComment {
  # (array reference, int) -> str
  # (html lines, line counter) -> Block Comment.
  # Takes lines of html and extracts the block comment using commentCounter
  # as a line index.
  # For use in extractComments subroutine.
  # ---------------------------------------------------------------------------

  # Takes reference of array of html lines.
  my $targetref = $_[0];
  # Converts reference of array of html lines to actual array.
  my @target = @$targetref;
  # Creates a restult variable to hold the block comment.
  my $result;

  # Finds line where block comment content begins
  until (substr($target[$_[1]] , 0, 42) eq "<div class=\"QuoteText blockquote-content\">"  ) {
    $_[1]++;
  }

  # Creates counter to move through last line of block comment till
  # ending div tag.
  our $blockCounter = 0;

  # If the block comment is only one line (the div tag closes on this line).
  if (substr($target[$_[1]] ,-6) eq "</div>") {
    # Skips the opening tag part of the line.
    $blockCounter = 42;
    # Increase block counter till we get index where block comment ends.
    until (substr($target[$_[1]], $blockCounter+1, 6) eq "</div>") {
      $blockCounter++;
    }
    # Save block comment in result.
    $result = substr($target[$_[1]], 42, $blockCounter - 41)
  }

  # If the block comment is multiple lines.
  else {
    # Save first line of block comment.
    $result = substr(($target[$_[1]], 42))."\n";
    # Move to second line of block comment
    $_[1]++;

    # While last line of block comment hasnt been reached keep adding the lines
    # to result
    until (substr($target[$_[1]] ,-6) eq "</div>") {
      $result = $result.$target[$_[1]]."\n";
      # Move to next line of block comment.
      $_[1]++;
    }

    # Cuts off </div> tag from last line.
    until(substr($target[$_[1]], $blockCounter + 1, 6) eq "</div>") {
      $blockCounter++;
    }

    # Adds last line to result
    $result = $result.substr($target[$_[1]], 0, $blockCounter);
  }

  return $result;
}

# -----------------------------------------------------------------------------
# Subroutine to get Comment (For use by extractComments ONLY).
# -----------------------------------------------------------------------------

sub extractUserComment {
  # (array referece, int) -> str
  # (html Lines, line counter) -> Comment.
  # Takes lines of html and extracts the user comment using commentCounter
  # as a line index.
  # For use in extractComments subroutine.
  # ---------------------------------------------------------------------------

  # Takes reference of array of html lines.
  my $targetref = $_[0];
  # Converts reference of array of html lines to actual array.
  my @target = @$targetref;
  # Creates a restult variable to hold the block comment.
  my $result = "";

  # Counter for extracting </div? tag.
  our $userCommentCounter = 0;

  # Adds each line before the last, each line is added as a separate line.
  until (substr($target[$_[1]], -6) eq "</div>") {
    $result = $result.$target[$_[1]]."\n";
    # commentCounter increased to next line of html.
    $_[1]++;
  }

  # Moves index to right before the </div> tag on last line of comment.
  until (substr($target[$_[1]], $userCommentCounter + 1) eq "</div>") {
    $userCommentCounter++;
  }

  # Concatonates result with the last comment line with the </div. tag removed.
  $result = $result.substr($target[$_[1]], 0, $userCommentCounter + 1);
  # For testing
  # print "User comment ending on Line ", $_[1], ": ", $result, "\n";
}

# -----------------------------------------------------------------------------
# Subroutine to get Comment (For use by extractComments ONLY).
# -----------------------------------------------------------------------------

sub saveComment {
  # (hash, str, str, str) -> null.
  # (comments hash, Author, BlockComment, Comment) -> null.
  # Takes an Author Name, Block Quote and Comment and adds it to the provided
  # hash.
  # For use in extractComments subroutine.
  # ---------------------------------------------------------------------------
}

# -----------------------------------------------------------------------------
# Subroutine to get the names of all classes in a blockquote+comment
# -----------------------------------------------------------------------------

sub getClasses {
  my $result = "";
  if (lc($_[0]) =~ lc("Bard")) {
  	$result = $result."Bard.";
  }
  if (lc($_[0]) =~ lc("Cleric")) {
  	$result = $result."Cleric.";
  }
  if (lc($_[0]) =~ lc("Fighter")) {
  	$result = $result."Fighter.";
  }
  if (lc($_[0]) =~ lc("Mage")) {
  	$result = $result."Mage.";
  }
  if (lc($_[0]) =~ lc("Ranger")) {
  	$result = $result."Ranger.";
  }
  if (lc($_[0]) =~ lc("Rogue")) {
  	$result = $result."Rogue.";
  }
  if (lc($_[0]) =~ lc("Summoner")) {
  	$result = $result."Summoner.";
  }
  if (lc($_[0]) =~ lc("Tank")) {
  	$result = $result."Tank.";
  }
  if (lc($_[0]) =~ lc("Minstrel")) {
  	$result = $result."Minstrel.";
  }
  if (lc($_[0]) =~ lc("Soul Weaver")) {
  	$result = $result."Soul Weaver.";
  }
  if (lc($_[0]) =~ lc("Tellsword")) {
  	$result = $result."Tellsword.";
  }
  if (lc($_[0]) =~ lc("Magician")) {
  	$result = $result."Magician.";
  }
  if (lc($_[0]) =~ lc("Song Warden")) {
  	$result = $result."Song Warden.";
  }
  if (lc($_[0]) =~ lc("Trickster")) {
  	$result = $result."Trickster.";
  }
  if (lc($_[0]) =~ lc("Songcaller")) {
  	$result = $result."Songcaller.";
  }
  if (lc($_[0]) =~ lc("Siren")) {
  	$result = $result."Siren.";
  }
  if (lc($_[0]) =~ lc("Scryer")) {
  	$result = $result."Scryer.";
  }
  if (lc($_[0]) =~ lc("High Priest")) {
  	$result = $result."High Priest.";
  }
  if (lc($_[0]) =~ lc("Templar")) {
  	$result = $result."Templar.";
  }
  if (lc($_[0]) =~ lc("Oracle")) {
  	$result = $result."Oracle.";
  }
  if (lc($_[0]) =~ lc("Protector")) {
  	$result = $result."Protector.";
  }
  if (lc($_[0]) =~ lc("Shadow Disciple")) {
  	$result = $result."Shadow Disciple.";
  }
  if (lc($_[0]) =~ lc("Shaman")) {
  	$result = $result."Shaman.";
  }
  if (lc($_[0]) =~ lc("Apostle")) {
  	$result = $result."Apostle.";
  }
  if (lc($_[0]) =~ lc("Bladedancer")) {
  	$result = $result."Bladedancer.";
  }
  if (lc($_[0]) =~ lc("Highsword")) {
  	$result = $result."Highsword.";
  }
  if (lc($_[0]) =~ lc("Weapon Master")) {
  	$result = $result."Weapon Master.";
  }
  if (lc($_[0]) =~ lc("Spellsword")) {
  	$result = $result."Spellsword.";
  }
  if (lc($_[0]) =~ lc("Hunter")) {
  	$result = $result."Hunter.";
  }
  if (lc($_[0]) =~ lc("Shadowblade")) {
  	$result = $result."Shadowblade.";
  }
  if (lc($_[0]) =~ lc("Bladecaller")) {
  	$result = $result."Bladecaller.";
  }
  if (lc($_[0]) =~ lc("Dreadnought")) {
  	$result = $result."Dreadnought.";
  }
  if (lc($_[0]) =~ lc("Sorcerer")) {
  	$result = $result."Sorcerer.";
  }
  if (lc($_[0]) =~ lc("Acolyte")) {
  	$result = $result."Acolyte.";
  }
  if (lc($_[0]) =~ lc("Battle Mage")) {
  	$result = $result."Battle Mage.";
  }
  if (lc($_[0]) =~ lc("Archwizard")) {
  	$result = $result."Archwizard.";
  }
  if (lc($_[0]) =~ lc("Spellhunter")) {
  	$result = $result."Spellhunter.";
  }
  if (lc($_[0]) =~ lc("Shadow Caster")) {
  	$result = $result."Shadow Caster.";
  }
  if (lc($_[0]) =~ lc("Warlock")) {
  	$result = $result."Warlock.";
  }
  if (lc($_[0]) =~ lc("Spellstone")) {
  	$result = $result."Spellstone.";
  }
  if (lc($_[0]) =~ lc("Bowsinger")) {
  	$result = $result."Bowsinger.";
  }
  if (lc($_[0]) =~ lc("Soulbow")) {
  	$result = $result."Soulbow.";
  }
  if (lc($_[0]) =~ lc("Strider")) {
  	$result = $result."Strider.";
  }
  if (lc($_[0]) =~ lc("Scion")) {
  	$result = $result."Scion.";
  }
  if (lc($_[0]) =~ lc("Hawkeye")) {
  	$result = $result."Hawkeye.";
  }
  if (lc($_[0]) =~ lc("Scout")) {
  	$result = $result."Scout.";
  }
  if (lc($_[0]) =~ lc("Falconer")) {
  	$result = $result."Falconer.";
  }
  if (lc($_[0]) =~ lc("Sentinel")) {
  	$result = $result."Sentinel.";
  }
  if (lc($_[0]) =~ lc("Charlatan")) {
  	$result = $result."Charlatan.";
  }
  if (lc($_[0]) =~ lc("Cultist")) {
  	$result = $result."Cultist.";
  }
  if (lc($_[0]) =~ lc("Duelist")) {
  	$result = $result."Duelist.";
  }
  if (lc($_[0]) =~ lc("Nightspell")) {
  	$result = $result."Nightspell.";
  }
  if (lc($_[0]) =~ lc("Predator")) {
  	$result = $result."Predator.";
  }
  if (lc($_[0]) =~ lc("Assassin")) {
  	$result = $result."Assassin.";
  }
  if (lc($_[0]) =~ lc("Shadow Lord")) {
  	$result = $result."Shadow Lord.";
  }
  if (lc($_[0]) =~ lc("Shadow Guardian")) {
  	$result = $result."Shadow Guardian.";
  }
  if (lc($_[0]) =~ lc("Enchanter")) {
  	$result = $result."Enchanter.";
  }
  if (lc($_[0]) =~ lc("Necromancer")) {
  	$result = $result."Necromancer.";
  }
  if (lc($_[0]) =~ lc("Wild Blade")) {
  	$result = $result."Wild Blade.";
  }
  if (lc($_[0]) =~ lc("Spellmancer")) {
  	$result = $result."Spellmancer.";
  }
  if (lc($_[0]) =~ lc("Beastmaster")) {
  	$result = $result."Beastmaster.";
  }
  if (lc($_[0]) =~ lc("Shadowmancer")) {
  	$result = $result."Shadowmancer.";
  }
  if (lc($_[0]) =~ lc("Conjurer")) {
  	$result = $result."Conjurer.";
  }
  if (lc($_[0]) =~ lc("Brood Warden")) {
  	$result = $result."Brood Warden.";
  }
  if (lc($_[0]) =~ lc("Argent")) {
  	$result = $result."Argent.";
  }
  if (lc($_[0]) =~ lc("Paladin")) {
  	$result = $result."Paladin.";
  }
  if (lc($_[0]) =~ lc("Knight")) {
  	$result = $result."Knight.";
  }
  if (lc($_[0]) =~ lc("Spellshield")) {
  	$result = $result."Spellshield.";
  }
  if (lc($_[0]) =~ lc("Warden")) {
  	$result = $result."Warden.";
  }
  if (lc($_[0]) =~ lc("Nightshield")) {
  	$result = $result."Nightshield.";
  }
  if (lc($_[0]) =~ lc("Keeper")) {
  	$result = $result."Keeper.";
  }
  if (lc($_[0]) =~ lc("Guardian")) {
  	$result = $result."Guardian.";
  }

  return $result;
}

# -----------------------------------------------------------------------------
# Subroutine to add all author and block comment + comment pairs to main
# comments hash.
# -----------------------------------------------------------------------------

# Variable to handle duplicate author names.
# declared before function to carry variable across mutliple uses of the
# subroutine for multiple pages of comments.
our $authorID = 0;

sub extractComments {
  # (str, hash, str) -> null.
  # (html code, author -> block comment + comment hash, Get pages number)
  # -> null.
  # Takes html file from a page of the target comment thread and extracts
  # The commentors and associated comments as a key value pair in the
  # provided hash.
  # get pages number is a yes/no value on whether to get the total number of
  # pages in the thread.
  # ---------------------------------------------------------------------------


  # Makes a list with each line of the html as an element
  my @lines = split(/\n/, $_[0]);
  my $numberOfLines = scalar @lines;
  #print "Number of lines: ", scalar @lines, "\n";

  # String to match with to find beginning of comment box
  my $commentBoxMatch = "<ul class=\"MessageList DataList Comments pageBox\">";

  # Finds where comment divider starts
  our $startCounter = 0;
  until (($lines[$startCounter] =~ /$commentBoxMatch/) || ($startCounter+1 == $numberOfLines)) {
    $startCounter++;
  }

  # For testing
  #print " The comment thread divider tag is on line: $startCounter\n";
  #print "The comment divider line is: $lines[$startCounter]\n";

  # Finds where comment thread ends on current page
  # Each comment is essentially an <li> element for a long <ul>
  our $endCounter = $startCounter;
  until ($lines[$endCounter] =~/<\/ul>/) {
    $endCounter++;
  }

  # For testing
  #print "comment thread ends on line: $endCounter\n";
  #print "comment thread ends on tag: $lines[$endCounter]\n\n\n";

  # Counter to go through all the lines in the comment thread section of the
  # html.
  our $commentCounter = $startCounter;
  # Initializing empty variable to hold author names.
  our $Author = "";
  # Initializing empty variable to hold embedded block comments.
  our $blockComment = "";
  # Initializing empty variable to hold author's comment.
  our $comment = "";
  #Create a reference for the html lines Array
  my $linesref = \@lines;

  # Loop to iterate through the comment section.
  # Uses commentCounter to count through $lines.
  # Stops when the </ul> tag to end the comment list in html is reached.
  until (($lines[$commentCounter] =~ /<\/ul>/) || ($startCounter+1 == $numberOfLines)) {

    #Checks if this is a line BEFORE the line containing author name.
    if ($lines[$commentCounter] =~ /<span class="Author">/) {
      # Moves to line containing author name.
      $commentCounter++;
      # extractAuthor extracts the name of the author from the html line.
      $Author = extractAuthor($lines[$commentCounter]);
      # For testing.
      #print "Author at line $commentCounter: $Author\n";

      # Moves on to search for the comment (and any potential block comment).
      $commentCounter++;

      # Now we search for the author's comment and any block comments.
      # Loop until comment div tag found.
      until (($lines[$commentCounter] eq "<div class=\"Message userContent\">") || ($startCounter+1 == $numberOfLines)) {
        $commentCounter++;
      }
      # Moves to line after Message userContent tag opens.
      # The next line has two possibilities:
      # (1) It is the users message directly.
      # (2) It is the opening tag for a block quote.
      $commentCounter++;

      # Conditiong to handle the case of block quotes.
      if ($lines[$commentCounter] eq "<blockquote class=\"Quote UserQuote blockquote\">") {
        #print "Block comment on line: $commentCounter\n";
        # Calls subroutine to extract entire block comment
        # subroutine moves commentCounter to last line of the block comment.
        $blockComment = extractBlockComment($linesref, $commentCounter);
        # print "Block comment ending at line $commentCounter: $blockComment\n";
        # Finds the line with the blockquote end tag
        # (Note: $commentCounter keeps track of the line).
        until (($lines[$commentCounter] eq "</blockquote>") || ($startCounter+1 == $numberOfLines)) {
          $commentCounter++;
          #print "html on line $commentCounter: ", $lines[$commentCounter], "\n";
        }
        # Moves to line with actual comment.
        $commentCounter++;
      }
      # Execute this code to get actual line, if block comment was found
      # it has been handled and we have been moved to the index of the line
      # where the actual message starts.
      $comment = extractUserComment($linesref, $commentCounter);

      # Adds data to the hash.
      # my @commentArray = [$blockComment, $comment];
      # my $commentArrayRef = \@commentArray;
      my $fullComment = "Block Comment: ".$blockComment."\n\n"."Comment: ".$comment;
      my $authorKey = "($authorID) ".$Author;
      $comments{$authorKey} = $fullComment;
      $authorID++;

      # Writes authorID and full blockquote and comment to full-comment-hostory.txt.
      print fhFull "$authorKey\n\n", "$fullComment\n\n";

      # gets classes in blockquote and comment to add to class-summary.txt.
      my $blockclasses = getClasses($blockComment);
      my $commentclasses = getClasses($comment);

      my @blockclassesList = split('\.', $blockclasses);
      my @commentclassesList = split('\.', $commentclasses);

      print fhSummary "$authorKey\n", "Block Quote Classes: ", join(", ", @blockclassesList),
      "\nComment Classes: ", join(", ", @commentclassesList), "\n\n\n";

      #reset variable values
      $Author = "";
      $blockComment = "";
      $comment = "";
    }
    $commentCounter++;
  }

  #print $numberOfLines."\n";
  #print $lines[$commentCounter]."\n\n";
  #print "$commentCounter\n\n";
  # until (($lines[$commentCounter] =~ "<div class=\"P PagerWrap\"><div role=\"navigation\" id=\"PagerAfter\"") || ($commentCounter == $numberOfLines)) {
  #  $commentCounter++;
    #print $commentCounter."\n";
  #}

# End of subroutine extractComments
}

# -----------------------------------------------------------------------------
# Code to use the extractComments subroutine on all pages
# -----------------------------------------------------------------------------

# Warning that a new directory will be made with two files for the data.
print "Warning: a new folder will be made in the current working directory ",
"with the following files inside:\n- full-comment-history.txt\n- class-summary.txt\n",
"If you agree press y, else press another key.\n";
# Get agreement input.
my $agree = <>;
# If the user presses y for the agree variable.
unless ($agree eq "y") {
  # Prompt to enter the number of total pages in the comment thread.
  print "Enter the number of pages in the comment thread.\n";
  # Line to take input for number of thread pages.
  my $navNumber = <>;
  # For testing and confirmation.
  print "number entered: $navNumber\n";

  # Create Directory for data unless it exists already.
  my $directory = "AC-files";

  unless (-e $directory or mkdir $directory) {
    die "Unable to create directory"
  }

  # Names the desired files.
  my $nameFull = "./AC-files/full-comment-history.txt";
  my $nameSummary = "./AC-files/class-summary.txt";

  # Opens the desired files, creates them if they don't exist, else clears them.
  open(fhFull, '>', $nameFull) or die "File opening failed: full-comment-history.txt";
  open(fhSummary, '>', $nameSummary) or die "File opening failed: class-summary.txt";

  # Calls subroutine to collect comments from the first page of the thread.
  extractComments($html, %comments);
  # Moves to second page of thread.
  our $currentNav = 2;

  # Loops through all the remaining pages of the comment thread and calls
  # the extract comment subroutine on each.
  while ($currentNav <= $navNumber) {
    #print "Before Loop: $currentNav\n";
    $url = "https://forums.ashesofcreation.com/discussion/46150/what-class-will-you-be-picking/p".$currentNav;
    $html = get $url || die "Timed out!";
    extractComments($html, %comments);
    # Move to next comment thread page.
    $currentNav++;
    #print "After Loop: $currentNav\n\n";
  }

  # Closes the desired files.
  close(fhFull);
  close(fhSummary);

  # For testing the hash keys and values.
  #foreach my $author (keys %comments) {
  #  print "Author ID and Name: $author\n\n";
  #  print $comments{$author}."\n\n";
  #}
}
