---
layout: page
title: Automation and Make
subtitle: Dependencies on data and code
minutes: TBC
---

Output data depends on both input data and programs that create it. In our workflow, each data file depends on


isles.data : books/isles.txt wordcount.py
...
abyss.dat : books/abyss.txt wordcount.py
...
last.dat : books/last.txt wordcount.py
...

Let's recreate them all:

touch wordcount.py
make dats

Question: why don't we make the `.txt` files depend on `wordcount.py`?

Answer: `.txt` files are input files and have no dependencies. To make these depend on `wordcount.py` would introduce a 'false dependency'.

Let's add our analysis script to the archive too:

analysis.tar.gz : *.dat wordcount.py
        tar -czf $@ $^
