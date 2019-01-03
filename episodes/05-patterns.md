---
title: "Pattern Rules"
teaching: 10
exercises: 0
questions:
- "How can I define rules to operate on similar files?"
objectives:
- "Write Make pattern rules."
keypoints:
- "Use the wildcard `%` as a placeholder in targets and dependencies."
- "Use the special variable `$*` to refer to matching sets of files in actions."
---

Our Makefile still has repeated content. The rules for each `.dat`
file are identical apart from the text and data file names. We can
replace these rules with a single [pattern
rule]({{ page.root }}/reference#pattern-rule) which can be used to build any
`.dat` file from a `.txt` file in `books/`:

~~~
%.dat : books/%.txt countwords.py
	python countwords.py $< $*.dat
~~~
{: .language-make}

`%` is a Make [wildcard]({{ page.root }}/reference#wildcard).  `$*` is a special
variable which gets replaced by the [stem]({{ page.root }}/reference#stem) with
which the rule matched.

This rule can be interpreted as:
"In order to build a file named `[something].dat` (the target)
find a file named `books/[that same something].txt` (the dependency)
and run `countwords.py [the dependency] [the target]`."

If we re-run Make,

~~~
$ make clean
$ make dats
~~~
{: .language-bash}

then we get:

~~~
python countwords.py books/isles.txt isles.dat
python countwords.py books/abyss.txt abyss.dat
python countwords.py books/last.txt last.dat
~~~
{: .output}

Note that we can still use Make to build individual `.dat` targets as before,
and that our new rule will work no matter what stem is being matched.

```
$ make sierra.dat
```
{: .language-bash}

which gives the output below:

```
python countwords.py books/sierra.txt sierra.dat
```
{: .output}

> ## Using Make Wildcards
>
> The Make `%` wildcard can only be used in a target and in its
> dependencies. It cannot be used in actions. In actions, you may
> however use `$*`, which will be replaced by the stem with which
> the rule matched.
{: .callout}

Our Makefile is now much shorter and cleaner:

~~~
# Generate summary table.
results.txt : testzipf.py isles.dat abyss.dat last.dat
	python $< *.dat > $@

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

%.dat : books/%.txt countwords.py
	python countwords.py $< $*.dat

.PHONY : clean
clean :
	rm -f *.dat
	rm -f results.txt
~~~
{: .language-make}

> ## Where We Are
>
> [This Makefile]({{ page.root }}/code/05-patterns/Makefile)
> contains all of our work so far.
{: .callout}

This episode has introduced pattern rules, and used the `$*` variable
in the `dat` rule in order to explain how to use it.
Arguably, a neater solution would have been to use `$@` to refer to
the target of the current rule (see below),
but then we wouldn't have learned about `$*`.

```
%.dat : books/%.txt countwords.py
	python countwords.py $< $@
```
{: .language-make}

