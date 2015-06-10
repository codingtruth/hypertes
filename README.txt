=====================================================
AWK script for generating HTML file with hyperlinks
from the original hebrew text of Talmud Eser Sfirot.
=====================================================

===========
Invocation:
===========

awk -f hypertes16.awk tes16-shehelot-tshuvot.txt > tes16-shehelot-tshuvot.html

======
Input:
======

TXT file with questions and answers about words meaning,
copypasted from MS Word files of TES part 16, downloaded from
http://kab.co.il/heb/content/view/full/42384

=======
Output:
=======

HTML page with hyperlinks:

Each question in the question list becomes hyperlink to the corresponding 
answer, each question title in the answers list becomes hyperlink to the 
corresponding question, the list of referencing answers is added to each 
referenced answer.

This HTML file can be opened in MS Word, or Open Office,
and it can be saved as PDF, with the appropriate page size to fit 
the smart-phone or the tablet screen size.

===============
Repository URL:
===============

==========
Copyright:
==========

(c) 2015 Kirill Poyarkov