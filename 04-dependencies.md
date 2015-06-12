---
layout: page
title: Automation and Make
subtitle: Dependencies on data and code
minutes: TBC
---

> ## Learning Objectives {.objectives}
>
> * Output files are a product not only of input files but of the scripts or code that created the output files.

Our data files are a product not only of our text files but the script, `wordcount.py`, that processes the text files and creates the data files. We should add `workflow.py` as a dependency of each of our data files also:

~~~ {.make}
isles.dat : books/isles.txt wordcount.py
	python wordcount.py $< $@

abyss.dat : books/abyss.txt wordcount.py
	python wordcount.py $< $@

last.dat : books/last.txt wordcount.py
	python wordcount.py $< $@
~~~

If we pretend to edit `wordcount.py` and re-run Make:

~~~ {.bash}
$ touch wordcount.py
$ make dats
~~~

We get:

~~~ {.output}
python wordcount.py books/isles.txt isles.dat
python wordcount.py books/abyss.txt abyss.dat
python wordcount.py books/last.txt last.dat
~~~

> ## Why don't the `.txt` files depend on `wordcount.py`? {.callout}
>
> `.txt` files are input files and have no dependencies. To make these depend on `wordcount.py` would introduce a 'false dependency'.

Let's add our analysis script to the archive too:

~~~ {.make}
analysis.tar.gz : *.dat wordcount.py
        tar -czf $@ $^
~~~

If we re-run Make:

~~~ {.bash}
$ make analysis.tar.gz
~~~

We get:

~~~ {.output}
tar -czf analysis.tar.gz abyss.dat isles.dat last.dat wordcount.py
~~~
