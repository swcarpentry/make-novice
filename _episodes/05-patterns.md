---
title: "Pattern Rules"
teaching: 15
exercises: 15
questions:
- "FIXME?"
objectives:
- "Write Make pattern rules."
- "Use the Make wildcard `%` in targets and dependencies."
- "Use the Make special variable `$*` in actions."
- "Avoid using the Make wildcard in rules."
keypoints:
- "FIXME."
---

Our Makefile still has repeated content. The rules for each `.dat`
file are identical apart from the text and data file names. We can
replace these rules with a single [pattern
rule]({{ site.root }}/reference/#pattern-rule) which can be used to build any
`.dat` file from a `.txt` file in `books/`:

~~~
%.dat : books/%.txt wordcount.py
        python wordcount.py $< $*.dat
~~~
{: .make}

`%` is a Make [wildcard]({{ site.root }}/reference/#wildcard).  `$*` is a special
variable which gets replaced by the [stem]({{ site.root }}/reference/#stem) with
which the rule matched.

This rule can be interpreted as:
"In order to build a file named `[something].dat` (the target)
find a file named `books/[that same something].txt` (the dependency)
and run `wordcount.py [the dependency] [the target]`."

If we re-run Make,

~~~
$ make clean
$ make dats
~~~
{: .bash}

then we get:

~~~
python wordcount.py books/isles.txt isles.dat
python wordcount.py books/abyss.txt abyss.dat
python wordcount.py books/last.txt last.dat
~~~
{: .output}

Our new rule will work no matter what stem is being matched.

> ## Using Make wildcards
>
> The Make `%` wildcard can only be used in a target and in its
> dependencies. It cannot be used in actions. In actions, you may
> however use `$*`, which will be replaced by the stem with which 
> the rule matched.
{: .callout}

Our Makefile is now much shorter and cleaner:

~~~
# Generate summary table.
results.txt : *.dat zipf_test.py
	    python zipf_test.py *.dat > $@

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

%.dat : books/%.txt wordcount.py
      python wordcount.py $< $*.dat

.PHONY : clean
clean :
      rm -f *.dat
      rm -f results.txt
~~~
{: .make}
