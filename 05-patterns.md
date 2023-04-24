---
title: Pattern Rules
teaching: 10
exercises: 0
---

::::::::::::::::::::::::::::::::::::::: objectives

- Write Make pattern rules.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How can I define rules to operate on similar files?

::::::::::::::::::::::::::::::::::::::::::::::::::

Our Makefile still has repeated content. The rules for each `.dat`
file are identical apart from the text and data file names. We can
replace these rules with a single [pattern
rule](../learners/reference.md#pattern-rule) which can be used to build any
`.dat` file from a `.txt` file in `books/`:

```make
%.dat : countwords.py books/%.txt
	python $^ $@
```

`%` is a Make [wildcard](../learners/reference.md#wildcard),
matching any number of any characters.

This rule can be interpreted as:
"In order to build a file named `[something].dat` (the target)
find a file named `books/[that same something].txt` (one of the dependencies)
and run `python [the dependencies] [the target]`."

If we re-run Make,

```bash
$ make clean
$ make dats
```

then we get:

```output
python countwords.py books/isles.txt isles.dat
python countwords.py books/abyss.txt abyss.dat
python countwords.py books/last.txt last.dat
```

Note that we can still use Make to build individual `.dat` targets as before,
and that our new rule will work no matter what stem is being matched.

```bash
$ make sierra.dat
```

which gives the output below:

```output
python countwords.py books/sierra.txt sierra.dat
```

:::::::::::::::::::::::::::::::::::::::::  callout

## Using Make Wildcards

The Make `%` wildcard can only be used in a target and in its
dependencies. It cannot be used in actions. In actions, you may
however use `$*`, which will be replaced by the stem with which
the rule matched.


::::::::::::::::::::::::::::::::::::::::::::::::::

Our Makefile is now much shorter and cleaner:

```make
# Generate summary table.
results.txt : testzipf.py isles.dat abyss.dat last.dat
	python $^ > $@

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

%.dat : countwords.py books/%.txt
	python $^ $@

.PHONY : clean
clean :
	rm -f *.dat
	rm -f results.txt
```

:::::::::::::::::::::::::::::::::::::::::  callout

## Where We Are

[This Makefile](files/code/05-patterns/Makefile)
contains all of our work so far.


::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: keypoints

- Use the wildcard `%` as a placeholder in targets and dependencies.
- Use the special variable `$*` to refer to matching sets of files in actions.

::::::::::::::::::::::::::::::::::::::::::::::::::


