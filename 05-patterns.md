---
layout: page
title: Automation and Make
subtitle: Pattern rules
minutes: TBC
---

> ## Learning Objectives {.objectives}
>
> * Write Make pattern rules.
> * Use the Make wild-card `%` in targets and dependencies.

Our Makefile still has repeated content. The rules for each `.dat` file are identical apart from the text and data file names. We can replace these rules with a single *pattern rule*.

~~~ {.make}
%.dat : books/%.txt wordcount.py
        python wordcount.py $< $@
~~~

`%` is a Make *wild-card*.

Re-run Make:

~~~ {.bash}
$ make clean
$ make dats
~~~

We get:

~~~ {.output}
python wordcount.py books/isles.txt isles.dat
python wordcount.py books/abyss.txt abyss.dat
python wordcount.py books/last.txt last.dat
~~~

> ## Using Make wild-cards {.callout}
>
> The Make `%` wild-card can only be used in a target and in its dependencies. It cannot be used in actions.
