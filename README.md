# ACData

A program to read data from ashes comment thread and store data on character classes by mentions.
I do not own and am not affiliated with Ashes of Creation.
This program is for learning purposes only.

Version: 1.2

Requirements:
- Internet Connection
- Perl
- CPAN LWP::Protocol::https

Goals:
- Learn regex usage.
- Learn perl
- Learn to use LWP library (basics).
- Practice using git.

Method:
- Gets html from target page.
- Recognize html patterns (manually).
- extract comments from the comment thread using patterns.
- Use patterns/key words to find desired class demographic.

Inputs:
- Takes a yes/no confirmation from user ("y" for yes, any other key for no).
- Takes in an integer for the number of pages in the comment thread.

Outputs:
- Creates a directory (AC-files) with three files as follows:
-- full-comment-history.txt has the complete comment thread.
-- class-summary.txt has usernames and the classes they mention.
-- class-stats.txt has number of mentions for each class as well as percentage mentions out of total classes mentioned (added v1.2).

Strengths:
- Uses minimal traversals of the html and class count (uses a single pass through).

Issues:
- All code in a single file. (Fixable and section marked using comments for easier visualization and readability).
- Relies on the user providing proper input for the number of pages in the comment thread.
- lots of regex searches.
- Overcounts simpler names (will count battle mage as mage as well).


Key Things learnt:
- Perl (basics, subroutines, File IO, references, UserAgent).
- Keep outputs flexible to allow for easier changes and less changes to existing code.
- Different file IO usage (read and write).
- Handling perl specific issues around subroutine arguments and other limitations.
