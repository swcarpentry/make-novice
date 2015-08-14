---
layout: page
title: Automation and Make
subtitle: Functions
minutes: 0
---

> ## Learning Objectives {.objectives}
>
> * Use Make's `wildcard` function to get lists of files matching a
>   pattern. 
> * Use Make's `patsubst` function to rewrite file names.

At this point, we have the following Makefile:

~~~ {.make}
include config.mk

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

%.dat : books/%.txt $(COUNT_SRC)
	$(COUNT_EXE) $< $*.dat

# Generate archive file.
analysis.tar.gz : *.dat $(COUNT_SRC)
	tar -czf $@ $^

.PHONY : clean
clean :
        rm -f *.dat
        rm -f analysis.tar.gz
~~~

Make has many [functions](reference.html#function) which can be used to
write more complex rules. One example is `wildcard`. `wildcard` gets a
list of files matching some pattern, which we can then save in a
variable. So, for example, we can get a list of all our text files
(files ending in `.txt`) and save these in a variable by adding this at
the beginning of our makefile:

~~~ {.make}
TXT_FILES=$(wildcard books/*.txt)
~~~

We can add `.PHONY` target and rule to show the variable's value:

~~~ {.make}
.PHONY : variables
variables:
	@echo TXT_FILES: $(TXT_FILES)
~~~

> ## @echo {.callout}
>
> Make prints actions as it executes them. Using `@` at the start of
> an action tells Make not to print this action. So, by using `@echo`
> instead of `echo`, we can see the result of `echo` (the variable's
> value being printed) but not the `echo` command itself.

If we run Make:

~~~ {.bash}
$ make variables
~~~

We get:

~~~ {.output}
TXT_FILES: books/abyss.txt books/isles.txt books/last.txt books/sierra.txt
~~~

Note how `sierra.txt` is now included too.

`patsubst` ('pattern substitution') takes a pattern, a replacement string and a
list of names in that order; each name in the list that matches the pattern is 
replaced by the replacement string. Again, we can save the result in a
variable. So, for example, we can rewrite our list of text files into
a list of data files (files ending in `.dat`) and save these in a
variable:

~~~ {.make}
DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))
~~~

We can extend `variables` to show the value of `DAT_FILES` too:

~~~ {.make}
.PHONY : variables
variables:
	@echo TXT_FILES: $(TXT_FILES)
	@echo DAT_FILES: $(DAT_FILES)
~~~

If we run Make,

~~~ {.bash}
$ make variables
~~~

then we get:

~~~ {.output}
TXT_FILES: books/abyss.txt books/isles.txt books/last.txt books/sierra.txt
DAT_FILES: abyss.dat isles.dat last.dat sierra.dat
~~~

Now, `sierra.txt` is processed too.

With these we can rewrite `clean` and `dats`:

~~~ {.make}
.PHONY : clean
clean :
        rm -f $(DAT_FILES)
        rm -f analysis.tar.gz

.PHONY : dats
dats : $(DAT_FILES)
~~~

Let's check:

~~~ {.bash}
$ make clean
$ make dats
~~~

We get:

~~~ {.output}
python wordcount.py books/abyss.txt abyss.dat
python wordcount.py books/isles.txt isles.dat
python wordcount.py books/last.txt last.dat
python wordcount.py books/sierra.txt sierra.dat
~~~

We can also rewrite `analysis.tar.gz` too:

~~~ {.make}
analysis.tar.gz : $(DAT_FILES) $(COUNT_SRC)
	tar -czf $@ $^
~~~

If we re-run Make:

~~~ {.bash}
$ make clean
$ make analysis.tar.gz
~~~

We get:

~~~ {.output}
$ make analysis.tar.gz
python wordcount.py books/abyss.txt abyss.dat
python wordcount.py books/isles.txt isles.dat
python wordcount.py books/last.txt last.dat
python wordcount.py books/sierra.txt sierra.dat
tar -czf analysis.tar.gz abyss.dat isles.dat last.dat sierra.dat wordcount.py
~~~

We see that the problem we had when using the bash wild-card, `*.dat`,
which required us to run `make dats` before `make analysis.tar.gz` has
now disappeared, since our functions allow us to create `.dat` file
names from those `.txt` file names in `books/`.

Here is our final Makefile:

~~~ {.make}
include config.mk

TXT_FILES=$(wildcard books/*.txt)
DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))

.PHONY: variables
variables:
	@echo TXT_FILES: $(TXT_FILES)
	@echo DAT_FILES: $(DAT_FILES)

# Count words.
.PHONY : dats
dats : $(DAT_FILES)

%.dat : books/%.txt $(COUNT_SRC)
	$(COUNT_EXE) $< $*.dat

# Generate archive file.
analysis.tar.gz : $(DAT_FILES) $(COUNT_SRC)
	tar -czf $@ $^

.PHONY : clean
clean :
	rm -f $(DAT_FILES)
	rm -f analysis.tar.gz
~~~

Remember, the `config.mk` file contains:

~~~ {.make}
# Count words script.
COUNT_SRC=wordcount.py
COUNT_EXE=python $(COUNT_SRC)
~~~
