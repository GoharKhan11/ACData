# ACData

A program to read data from ashes webpage and store data on desired classes.
I do not own and am not affiliated with Ashes of Creation.
This program is for learning purposes only.

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
- Creates a directory with two files. One has the entire comment history, one has only class mentions. Both have authors and author IDs.

Issues:
- All code in a single file. (Fixable and section marked using comments for easier visualization and readability).
- Relies on the user providing proper input for the comment.
- lots of regex searches.


Key Things learnt:
- Perl (basics, subroutines, File IO, references, UserAgent).
- Keep outputs flexible to allow for easier changes and less changes to existing code.
- Handling perl specific issues around subroutine arguments and other limitations.
