---
layout: page
title: Automation and Make
subtitle: Pattern rules
minutes: 0
---

> ## Learning Objectives {.objectives}
>
> * Write Make pattern rules.
> * Use the Make wild-card `%` in targets and dependencies.
> * Avoid using the Make wild-card in rules.

Our Makefile still has repeated content. The rules for each `.dat`
file are identical apart from the text and data file names. We can
replace these rules with a single [pattern
rule](reference.html#pattern-rule) which can be used to build any
`.dat` file from a `.txt` file in `books/`:

~~~ {.make}
%.dat : books/%.txt wordcount.py
        python wordcount.py $< $@
~~~

`%` is a Make [wild-card](reference.html#wild-card).

If we re-run Make,

~~~ {.bash}
$ make clean
$ make dats
~~~

then we get:

~~~ {.output}
python wordcount.py books/isles.txt isles.dat
python wordcount.py books/abyss.txt abyss.dat
python wordcount.py books/last.txt last.dat
~~~

> ## Using Make wild-cards {.callout}
>
> The Make `%` wild-card can only be used in a target and in its
> dependencies. It cannot be used in actions. 

Our Makefile is now much shorter and cleaner:

~~~ {.make}
# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

%.dat : books/%.txt wordcount.py
	python wordcount.py $< $@

# Generate archive file.
analysis.tar.gz : *.dat wordcount.py
	tar -czf $@ $^

.PHONY : clean
clean :
        rm -f *.dat
        rm -f analysis.tar.gz
~~~
