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

#------------------------------------------------------------------------------
# Below Variables are to store statistics (73 lines).
#------------------------------------------------------------------------------

our $total_class_counter = 0;
our $Bard_counter = 0;
our $Cleric_counter = 0;
our $Fighter_counter = 0;
our $Mage_counter = 0;
our $Ranger_counter = 0;
our $Rogue_counter = 0;
our $Summoner_counter = 0;
our $Tank_counter = 0;
our $Minstrel_counter = 0;
our $Soul_Weaver_counter = 0;
our $Tellsword_counter = 0;
our $Magician_counter = 0;
our $Song_Warden_counter = 0;
our $Trickster_counter = 0;
our $Songcaller_counter = 0;
our $Siren_counter = 0;
our $Scryer_counter = 0;
our $High_Priest_counter = 0;
our $Templar_counter = 0;
our $Oracle_counter = 0;
our $Protector_counter = 0;
our $Shadow_Disciple_counter = 0;
our $Shaman_counter = 0;
our $Apostle_counter = 0;
our $Bladedancer_counter = 0;
our $Highsword_counter = 0;
our $Weapon_Master_counter = 0;
our $Spellsword_counter = 0;
our $Hunter_counter = 0;
our $Shadowblade_counter = 0;
our $Bladecaller_counter = 0;
our $Dreadnought_counter = 0;
our $Sorcerer_counter = 0;
our $Acolyte_counter = 0;
our $Battle_Mage_counter = 0;
our $Archwizard_counter = 0;
our $Spellhunter_counter = 0;
our $Shadow_Caster_counter = 0;
our $Warlock_counter = 0;
our $Spellstone_counter = 0;
our $Bowsinger_counter = 0;
our $Soulbow_counter = 0;
our $Strider_counter = 0;
our $Scion_counter = 0;
our $Hawkeye_counter = 0;
our $Scout_counter = 0;
our $Falconer_counter = 0;
our $Sentinel_counter = 0;
our $Charlatan_counter = 0;
our $Cultist_counter = 0;
our $Duelist_counter = 0;
our $Nightspell_counter = 0;
our $Predator_counter = 0;
our $Assassin_counter = 0;
our $Shadow_Lord_counter = 0;
our $Shadow_Guardian_counter = 0;
our $Enchanter_counter = 0;
our $Necromancer_counter = 0;
our $Wild_Blade_counter = 0;
our $Spellmancer_counter = 0;
our $Beastmaster_counter = 0;
our $Shadowmancer_counter = 0;
our $Conjurer_counter = 0;
our $Brood_Warden_counter = 0;
our $Argent_counter = 0;
our $Paladin_counter = 0;
our $Knight_counter = 0;
our $Spellshield_counter = 0;
our $Warden_counter = 0;
our $Nightshield_counter = 0;
our $Keeper_counter = 0;
our $Guardian_counter = 0;

#------------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Subroutine to get the names of all classes in a blockquote+comment
# -----------------------------------------------------------------------------

sub getClasses {
  my $result = "";

  if (lc($_[0]) =~ lc("Bard")) {
  	$result = $result."Bard.";
  	$Bard_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Cleric")) {
  	$result = $result."Cleric.";
  	$Cleric_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Fighter")) {
  	$result = $result."Fighter.";
  	$Fighter_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Mage")) {
  	$result = $result."Mage.";
  	$Mage_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Ranger")) {
  	$result = $result."Ranger.";
  	$Ranger_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Rogue")) {
  	$result = $result."Rogue.";
  	$Rogue_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Summoner")) {
  	$result = $result."Summoner.";
  	$Summoner_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Tank")) {
  	$result = $result."Tank.";
  	$Tank_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Minstrel")) {
  	$result = $result."Minstrel.";
  	$Minstrel_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Soul_Weaver")) {
  	$result = $result."Soul_Weaver.";
  	$Soul_Weaver_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Tellsword")) {
  	$result = $result."Tellsword.";
  	$Tellsword_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Magician")) {
  	$result = $result."Magician.";
  	$Magician_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Song_Warden")) {
  	$result = $result."Song_Warden.";
  	$Song_Warden_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Trickster")) {
  	$result = $result."Trickster.";
  	$Trickster_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Songcaller")) {
  	$result = $result."Songcaller.";
  	$Songcaller_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Siren")) {
  	$result = $result."Siren.";
  	$Siren_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Scryer")) {
  	$result = $result."Scryer.";
  	$Scryer_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("High_Priest")) {
  	$result = $result."High_Priest.";
  	$High_Priest_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Templar")) {
  	$result = $result."Templar.";
  	$Templar_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Oracle")) {
  	$result = $result."Oracle.";
  	$Oracle_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Protector")) {
  	$result = $result."Protector.";
  	$Protector_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Shadow_Disciple")) {
  	$result = $result."Shadow_Disciple.";
  	$Shadow_Disciple_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Shaman")) {
  	$result = $result."Shaman.";
  	$Shaman_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Apostle")) {
  	$result = $result."Apostle.";
  	$Apostle_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Bladedancer")) {
  	$result = $result."Bladedancer.";
  	$Bladedancer_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Highsword")) {
  	$result = $result."Highsword.";
  	$Highsword_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Weapon_Master")) {
  	$result = $result."Weapon_Master.";
  	$Weapon_Master_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Spellsword")) {
  	$result = $result."Spellsword.";
  	$Spellsword_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Hunter")) {
  	$result = $result."Hunter.";
  	$Hunter_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Shadowblade")) {
  	$result = $result."Shadowblade.";
  	$Shadowblade_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Bladecaller")) {
  	$result = $result."Bladecaller.";
  	$Bladecaller_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Dreadnought")) {
  	$result = $result."Dreadnought.";
  	$Dreadnought_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Sorcerer")) {
  	$result = $result."Sorcerer.";
  	$Sorcerer_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Acolyte")) {
  	$result = $result."Acolyte.";
  	$Acolyte_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Battle_Mage")) {
  	$result = $result."Battle_Mage.";
  	$Battle_Mage_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Archwizard")) {
  	$result = $result."Archwizard.";
  	$Archwizard_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Spellhunter")) {
  	$result = $result."Spellhunter.";
  	$Spellhunter_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Shadow_Caster")) {
  	$result = $result."Shadow_Caster.";
  	$Shadow_Caster_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Warlock")) {
  	$result = $result."Warlock.";
  	$Warlock_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Spellstone")) {
  	$result = $result."Spellstone.";
  	$Spellstone_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Bowsinger")) {
  	$result = $result."Bowsinger.";
  	$Bowsinger_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Soulbow")) {
  	$result = $result."Soulbow.";
  	$Soulbow_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Strider")) {
  	$result = $result."Strider.";
  	$Strider_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Scion")) {
  	$result = $result."Scion.";
  	$Scion_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Hawkeye")) {
  	$result = $result."Hawkeye.";
  	$Hawkeye_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Scout")) {
  	$result = $result."Scout.";
  	$Scout_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Falconer")) {
  	$result = $result."Falconer.";
  	$Falconer_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Sentinel")) {
  	$result = $result."Sentinel.";
  	$Sentinel_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Charlatan")) {
  	$result = $result."Charlatan.";
  	$Charlatan_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Cultist")) {
  	$result = $result."Cultist.";
  	$Cultist_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Duelist")) {
  	$result = $result."Duelist.";
  	$Duelist_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Nightspell")) {
  	$result = $result."Nightspell.";
  	$Nightspell_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Predator")) {
  	$result = $result."Predator.";
  	$Predator_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Assassin")) {
  	$result = $result."Assassin.";
  	$Assassin_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Shadow_Lord")) {
  	$result = $result."Shadow_Lord.";
  	$Shadow_Lord_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Shadow_Guardian")) {
  	$result = $result."Shadow_Guardian.";
  	$Shadow_Guardian_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Enchanter")) {
  	$result = $result."Enchanter.";
  	$Enchanter_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Necromancer")) {
  	$result = $result."Necromancer.";
  	$Necromancer_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Wild Blade")) {
  	$result = $result."Wild Blade.";
  	$Wild_Blade_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Spellmancer")) {
  	$result = $result."Spellmancer.";
  	$Spellmancer_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Beastmaster")) {
  	$result = $result."Beastmaster.";
  	$Beastmaster_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Shadowmancer")) {
  	$result = $result."Shadowmancer.";
  	$Shadowmancer_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Conjurer")) {
  	$result = $result."Conjurer.";
  	$Conjurer_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Brood Warden")) {
  	$result = $result."Brood Warden.";
  	$Brood_Warden_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Argent")) {
  	$result = $result."Argent.";
  	$Argent_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Paladin")) {
  	$result = $result."Paladin.";
  	$Paladin_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Knight")) {
  	$result = $result."Knight.";
  	$Knight_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Spellshield")) {
  	$result = $result."Spellshield.";
  	$Spellshield_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Warden")) {
  	$result = $result."Warden.";
  	$Warden_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Nightshield")) {
  	$result = $result."Nightshield.";
  	$Nightshield_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Keeper")) {
  	$result = $result."Keeper.";
  	$Keeper_counter++;
  	$total_class_counter++;
  }

  if (lc($_[0]) =~ lc("Guardian")) {
  	$result = $result."Guardian.";
  	$Guardian_counter++;
  	$total_class_counter++;
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

  my $statsFile = "./AC-files/class-stats.txt";

  open(fhStats, '>', $statsFile) or die "File opening failed: class-stats.txt";

  sub percentage {
    my $result = 0;
    if ($total_class_counter > 0) {
      $result = ($_[0] / $total_class_counter) * 100;
    }
    return $result;
  }

  #----------------------------------------------------------------------------
  # statements to generate the stats file (143 lines).
  #----------------------------------------------------------------------------

  print fhStats "Bard occurance count: $Bard_counter\nBard percentage occurance: " . percentage($Bard_counter) . "\n\n";

  print fhStats "Cleric occurance count: $Cleric_counter\nCleric percentage occurance: " . percentage($Cleric_counter) . "\n\n";

  print fhStats "Fighter occurance count: $Fighter_counter\nFighter percentage occurance: " . percentage($Fighter_counter) . "\n\n";

  print fhStats "Mage occurance count: $Mage_counter\nMage percentage occurance: " . percentage($Mage_counter) . "\n\n";

  print fhStats "Ranger occurance count: $Ranger_counter\nRanger percentage occurance: " . percentage($Ranger_counter) . "\n\n";

  print fhStats "Rogue occurance count: $Rogue_counter\nRogue percentage occurance: " . percentage($Rogue_counter) . "\n\n";

  print fhStats "Summoner occurance count: $Summoner_counter\nSummoner percentage occurance: " . percentage($Summoner_counter) . "\n\n";

  print fhStats "Tank occurance count: $Tank_counter\nTank percentage occurance: " . percentage($Tank_counter) . "\n\n";

  print fhStats "Minstrel occurance count: $Minstrel_counter\nMinstrel percentage occurance: " . percentage($Minstrel_counter) . "\n\n";

  print fhStats "Soul_Weaver occurance count: $Soul_Weaver_counter\nSoul_Weaver percentage occurance: " . percentage($Soul_Weaver_counter) . "\n\n";

  print fhStats "Tellsword occurance count: $Tellsword_counter\nTellsword percentage occurance: " . percentage($Tellsword_counter) . "\n\n";

  print fhStats "Magician occurance count: $Magician_counter\nMagician percentage occurance: " . percentage($Magician_counter) . "\n\n";

  print fhStats "Song_Warden occurance count: $Song_Warden_counter\nSong_Warden percentage occurance: " . percentage($Song_Warden_counter) . "\n\n";

  print fhStats "Trickster occurance count: $Trickster_counter\nTrickster percentage occurance: " . percentage($Trickster_counter) . "\n\n";

  print fhStats "Songcaller occurance count: $Songcaller_counter\nSongcaller percentage occurance: " . percentage($Songcaller_counter) . "\n\n";

  print fhStats "Siren occurance count: $Siren_counter\nSiren percentage occurance: " . percentage($Siren_counter) . "\n\n";

  print fhStats "Scryer occurance count: $Scryer_counter\nScryer percentage occurance: " . percentage($Scryer_counter) . "\n\n";

  print fhStats "High_Priest occurance count: $High_Priest_counter\nHigh_Priest percentage occurance: " . percentage($High_Priest_counter) . "\n\n";

  print fhStats "Templar occurance count: $Templar_counter\nTemplar percentage occurance: " . percentage($Templar_counter) . "\n\n";

  print fhStats "Oracle occurance count: $Oracle_counter\nOracle percentage occurance: " . percentage($Oracle_counter) . "\n\n";

  print fhStats "Protector occurance count: $Protector_counter\nProtector percentage occurance: " . percentage($Protector_counter) . "\n\n";

  print fhStats "Shadow_Disciple occurance count: $Shadow_Disciple_counter\nShadow_Disciple percentage occurance: " . percentage($Shadow_Disciple_counter) . "\n\n";

  print fhStats "Shaman occurance count: $Shaman_counter\nShaman percentage occurance: " . percentage($Shaman_counter) . "\n\n";

  print fhStats "Apostle occurance count: $Apostle_counter\nApostle percentage occurance: " . percentage($Apostle_counter) . "\n\n";

  print fhStats "Bladedancer occurance count: $Bladedancer_counter\nBladedancer percentage occurance: " . percentage($Bladedancer_counter) . "\n\n";

  print fhStats "Highsword occurance count: $Highsword_counter\nHighsword percentage occurance: " . percentage($Highsword_counter) . "\n\n";

  print fhStats "Weapon_Master occurance count: $Weapon_Master_counter\nWeapon_Master percentage occurance: " . percentage($Weapon_Master_counter) . "\n\n";

  print fhStats "Spellsword occurance count: $Spellsword_counter\nSpellsword percentage occurance: " . percentage($Spellsword_counter) . "\n\n";

  print fhStats "Hunter occurance count: $Hunter_counter\nHunter percentage occurance: " . percentage($Hunter_counter) . "\n\n";

  print fhStats "Shadowblade occurance count: $Shadowblade_counter\nShadowblade percentage occurance: " . percentage($Shadowblade_counter) . "\n\n";

  print fhStats "Bladecaller occurance count: $Bladecaller_counter\nBladecaller percentage occurance: " . percentage($Bladecaller_counter) . "\n\n";

  print fhStats "Dreadnought occurance count: $Dreadnought_counter\nDreadnought percentage occurance: " . percentage($Dreadnought_counter) . "\n\n";

  print fhStats "Sorcerer occurance count: $Sorcerer_counter\nSorcerer percentage occurance: " . percentage($Sorcerer_counter) . "\n\n";

  print fhStats "Acolyte occurance count: $Acolyte_counter\nAcolyte percentage occurance: " . percentage($Acolyte_counter) . "\n\n";

  print fhStats "Battle_Mage occurance count: $Battle_Mage_counter\nBattle_Mage percentage occurance: " . percentage($Battle_Mage_counter) . "\n\n";

  print fhStats "Archwizard occurance count: $Archwizard_counter\nArchwizard percentage occurance: " . percentage($Archwizard_counter) . "\n\n";

  print fhStats "Spellhunter occurance count: $Spellhunter_counter\nSpellhunter percentage occurance: " . percentage($Spellhunter_counter) . "\n\n";

  print fhStats "Shadow_Caster occurance count: $Shadow_Caster_counter\nShadow_Caster percentage occurance: " . percentage($Shadow_Caster_counter) . "\n\n";

  print fhStats "Warlock occurance count: $Warlock_counter\nWarlock percentage occurance: " . percentage($Warlock_counter) . "\n\n";

  print fhStats "Spellstone occurance count: $Spellstone_counter\nSpellstone percentage occurance: " . percentage($Spellstone_counter) . "\n\n";

  print fhStats "Bowsinger occurance count: $Bowsinger_counter\nBowsinger percentage occurance: " . percentage($Bowsinger_counter) . "\n\n";

  print fhStats "Soulbow occurance count: $Soulbow_counter\nSoulbow percentage occurance: " . percentage($Soulbow_counter) . "\n\n";

  print fhStats "Strider occurance count: $Strider_counter\nStrider percentage occurance: " . percentage($Strider_counter) . "\n\n";

  print fhStats "Scion occurance count: $Scion_counter\nScion percentage occurance: " . percentage($Scion_counter) . "\n\n";

  print fhStats "Hawkeye occurance count: $Hawkeye_counter\nHawkeye percentage occurance: " . percentage($Hawkeye_counter) . "\n\n";

  print fhStats "Scout occurance count: $Scout_counter\nScout percentage occurance: " . percentage($Scout_counter) . "\n\n";

  print fhStats "Falconer occurance count: $Falconer_counter\nFalconer percentage occurance: " . percentage($Falconer_counter) . "\n\n";

  print fhStats "Sentinel occurance count: $Sentinel_counter\nSentinel percentage occurance: " . percentage($Sentinel_counter) . "\n\n";

  print fhStats "Charlatan occurance count: $Charlatan_counter\nCharlatan percentage occurance: " . percentage($Charlatan_counter) . "\n\n";

  print fhStats "Cultist occurance count: $Cultist_counter\nCultist percentage occurance: " . percentage($Cultist_counter) . "\n\n";

  print fhStats "Duelist occurance count: $Duelist_counter\nDuelist percentage occurance: " . percentage($Duelist_counter) . "\n\n";

  print fhStats "Nightspell occurance count: $Nightspell_counter\nNightspell percentage occurance: " . percentage($Nightspell_counter) . "\n\n";

  print fhStats "Predator occurance count: $Predator_counter\nPredator percentage occurance: " . percentage($Predator_counter) . "\n\n";

  print fhStats "Assassin occurance count: $Assassin_counter\nAssassin percentage occurance: " . percentage($Assassin_counter) . "\n\n";

  print fhStats "Shadow_Lord occurance count: $Shadow_Lord_counter\nShadow_Lord percentage occurance: " . percentage($Shadow_Lord_counter) . "\n\n";

  print fhStats "Shadow_Guardian occurance count: $Shadow_Guardian_counter\nShadow_Guardian percentage occurance: " . percentage($Shadow_Guardian_counter) . "\n\n";

  print fhStats "Enchanter occurance count: $Enchanter_counter\nEnchanter percentage occurance: " . percentage($Enchanter_counter) . "\n\n";

  print fhStats "Necromancer occurance count: $Necromancer_counter\nNecromancer percentage occurance: " . percentage($Necromancer_counter) . "\n\n";

  print fhStats "Wild_Blade occurance count: $Wild_Blade_counter\nWild_Blade percentage occurance: " . percentage($Wild_Blade_counter) . "\n\n";

  print fhStats "Spellmancer occurance count: $Spellmancer_counter\nSpellmancer percentage occurance: " . percentage($Spellmancer_counter) . "\n\n";

  print fhStats "Beastmaster occurance count: $Beastmaster_counter\nBeastmaster percentage occurance: " . percentage($Beastmaster_counter) . "\n\n";

  print fhStats "Shadowmancer occurance count: $Shadowmancer_counter\nShadowmancer percentage occurance: " . percentage($Shadowmancer_counter) . "\n\n";

  print fhStats "Conjurer occurance count: $Conjurer_counter\nConjurer percentage occurance: " . percentage($Conjurer_counter) . "\n\n";

  print fhStats "Brood_Warden occurance count: $Brood_Warden_counter\nBrood_Warden percentage occurance: " . percentage($Brood_Warden_counter) . "\n\n";

  print fhStats "Argent occurance count: $Argent_counter\nArgent percentage occurance: " . percentage($Argent_counter) . "\n\n";

  print fhStats "Paladin occurance count: $Paladin_counter\nPaladin percentage occurance: " . percentage($Paladin_counter) . "\n\n";

  print fhStats "Knight occurance count: $Knight_counter\nKnight percentage occurance: " . percentage($Knight_counter) . "\n\n";

  print fhStats "Spellshield occurance count: $Spellshield_counter\nSpellshield percentage occurance: " . percentage($Spellshield_counter) . "\n\n";

  print fhStats "Warden occurance count: $Warden_counter\nWarden percentage occurance: " . percentage($Warden_counter) . "\n\n";

  print fhStats "Nightshield occurance count: $Nightshield_counter\nNightshield percentage occurance: " . percentage($Nightshield_counter) . "\n\n";

  print fhStats "Keeper occurance count: $Keeper_counter\nKeeper percentage occurance: " . percentage($Keeper_counter) . "\n\n";

  print fhStats "Guardian occurance count: $Guardian_counter\nGuardian percentage occurance: " . percentage($Guardian_counter) . "\n\n";


  #----------------------------------------------------------------------------
  close(fhStats);

  # For testing the hash keys and values.
  #foreach my $author (keys %comments) {
  #  print "Author ID and Name: $author\n\n";
  #  print $comments{$author}."\n\n";
  #}
}
