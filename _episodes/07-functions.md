---
title: "Functions"
teaching: 15
exercises: 15
questions:
- "How *else* can I eliminate redundancy in my Makefiles?"
objectives:
- "Write Makefiles that use functions to match and transform sets of files."
keypoints:
- "Make is actually a small programming language with many built-in functions."
- "Use `wildcard` function to get lists of files matching a pattern."
- "Use `patsubst` function to rewrite file names."
---

At this point, we have the following Makefile:

~~~
include config.mk

# Generate summary table.
results.txt : *.dat $(ZIPF_SRC)
        $(ZIPF_EXE) *.dat > $@

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

%.dat : books/%.txt $(COUNT_SRC)
        $(COUNT_EXE) $< $*.dat

.PHONY : clean
clean :
        rm -f *.dat
        rm -f results.txt
~~~
{: .make}

Make has many [functions]({{ site.github.url }}/reference/#function) which can be used to
write more complex rules. One example is `wildcard`. `wildcard` gets a
list of files matching some pattern, which we can then save in a
variable. So, for example, we can get a list of all our text files
(files ending in `.txt`) and save these in a variable by adding this at
the beginning of our makefile:

~~~
TXT_FILES=$(wildcard books/*.txt)
~~~
{: .make}

We can add `.PHONY` target and rule to show the variable's value:

~~~
.PHONY : variables
variables:
	@echo TXT_FILES: $(TXT_FILES)
~~~
{: .make}

> ## @echo
>
> Make prints actions as it executes them. Using `@` at the start of
> an action tells Make not to print this action. So, by using `@echo`
> instead of `echo`, we can see the result of `echo` (the variable's
> value being printed) but not the `echo` command itself.
{: .callout}

If we run Make:

~~~
$ make variables
~~~
{: .bash}

We get:

~~~
TXT_FILES: books/abyss.txt books/isles.txt books/last.txt books/sierra.txt
~~~
{: .output}

Note how `sierra.txt` is now included too.

The following figure shows the dependencies embodied within our Makefile,
involved in building the `results.txt` target,
once we have introduced our function:

![results.txt dependencies after introducing a function]({{ site.github.url }}/fig/07-functions.png "results.txt dependencies after introducing a function")

`patsubst` ('pattern substitution') takes a pattern, a replacement string and a
list of names in that order; each name in the list that matches the pattern is
replaced by the replacement string. Again, we can save the result in a
variable. So, for example, we can rewrite our list of text files into
a list of data files (files ending in `.dat`) and save these in a
variable:

~~~
DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))
~~~
{: .make}

We can extend `variables` to show the value of `DAT_FILES` too:

~~~
.PHONY : variables
variables:
        @echo TXT_FILES: $(TXT_FILES)
        @echo DAT_FILES: $(DAT_FILES)
~~~
{: .make}

If we run Make,

~~~
$ make variables
~~~
{: .bash}

then we get:

~~~
TXT_FILES: books/abyss.txt books/isles.txt books/last.txt books/sierra.txt
DAT_FILES: abyss.dat isles.dat last.dat sierra.dat
~~~
{: .output}

Now, `sierra.txt` is processed too.

With these we can rewrite `clean` and `dats`:

~~~
.PHONY : dats
dats : $(DAT_FILES)

.PHONY : clean
clean :
        rm -f $(DAT_FILES)
        rm -f results.txt
~~~
{: .make}

Let's check:

~~~
$ make clean
$ make dats
~~~
{: .bash}

We get:

~~~
python wordcount.py books/abyss.txt abyss.dat
python wordcount.py books/isles.txt isles.dat
python wordcount.py books/last.txt last.dat
python wordcount.py books/sierra.txt sierra.dat
~~~
{: .output}

We can also rewrite `results.txt`:

~~~
results.txt : $(DAT_FILES) $(ZIPF_SRC)
        $(ZIPF_EXE) *.dat > $@
~~~
{: .make}

If we re-run Make:

~~~
$ make clean
$ make results.txt
~~~
{: .bash}

We get:

~~~
python wordcount.py books/abyss.txt abyss.dat
python wordcount.py books/isles.txt isles.dat
python wordcount.py books/last.txt last.dat
python wordcount.py books/sierra.txt sierra.dat
python zipf_test.py *.dat > results.txt
~~~
{: .output}

We see that the problem we had when using the bash wild-card, `*.dat`,
which required us to run `make dats` before `make results.txt` has
now disappeared, since our functions allow us to create `.dat` file
names from those `.txt` file names in `books/`.

Let's check the `results.txt` file:

~~~
$ cat results.txt
~~~
{: .bash}

~~~
Book	First	Second	Ratio
abyss	4044	2807	1.44
isles	3822	2460	1.55
last	12244	5566	2.20
sierra	4242	2469	1.72
~~~
{: .output}

So the range of the ratios of occurrences of the two most frequent
words in our books is indeed around 2, as predicted by Zipf's Law,
i.e., the most frequently-occurring word occurs approximately twice as
often as the second most frequent word.  Here is our final Makefile:

~~~
include config.mk

TXT_FILES=$(wildcard books/*.txt)
DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))

# Generate summary table.
results.txt : $(DAT_FILES) $(ZIPF_SRC)
	$(ZIPF_EXE) *.dat > $@

# Count words.
.PHONY : dats
dats : $(DAT_FILES)

%.dat : books/%.txt $(COUNT_SRC)
	$(COUNT_EXE) $< $*.dat

.PHONY : clean
clean :
	rm -f $(DAT_FILES)
	rm -f results.txt

.PHONY : variables
variables:
	@echo TXT_FILES: $(TXT_FILES)
	@echo DAT_FILES: $(DAT_FILES)
~~~
{: .make}

Remember, the `config.mk` file contains:

~~~
# Count words script.
COUNT_SRC=wordcount.py
COUNT_EXE=python $(COUNT_SRC)

# Test Zipf's rule
ZIPF_SRC=zipf_test.py
ZIPF_EXE=python $(ZIPF_SRC)
~~~
{: .make}

> ## Where We Are
>
> [This Makefile]({{ site.github.url }}/code/07-functions/Makefile)
> and [its accompanying `config.mk`]({{ site.github.url }}/code/07-functions/config.mk)
> contain all of our work so far.
{: .callout}
