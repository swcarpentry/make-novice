---
layout: page
title: Automation and Make
subtitle: Solutions
minutes: 0
---

## Lesson 02-makefiles

> ## Write two new rules {.challenge}
>
> Write a new rule for `last.dat`, created from `books/last.txt`.
>
> Update the `dats` rule with this target.
>
> Write a new rule for `results.txt`, which creates the summary
> table. The rule needs to:
>
> * Depend upon each of the three `.dat` files.
> * Invoke the action `python zipf_test.py abyss.dat isles.dat last-dat > results.txt`.
>
> Put this rule at the top of the Makefile so that it is the default target.
>
> Update `clean` so that it removes `results.txt`.

~~~ {.make}
# Generate summary table.
results.txt : isles.dat abyss.dat last.dat
    	python zipf_test.py abyss.dat isles.dat last.dat > results.txt

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

isles.dat : books/isles.txt
    	python wordcount.py books/isles.txt isles.dat

abyss.dat : books/abyss.txt
    	python wordcount.py books/abyss.txt abyss.dat

last.dat : books/last.txt
    	python wordcount.py books/last.txt last.dat

.PHONY : clean
clean :
    	rm -f *.dat
    	rm -f results.txt
~~~

## Lesson 03-variables
> ## Update dependencies {.challenge}
> 
> What will happen if you now execute:
> 
> ~~~ {.bash}
> $ touch *.dat
> $ make results.txt
> ~~~
> 
> 1. nothing
> 2. all files recreated
> 3. only `.dat` files recreated
> 4. only `results.txt` recreated

* * *
4.) only `results.txt` recreated. 

You can check that `*.dat` is being expanded in the target of the rule for `results.txt` by echoing the value of the automatic variable `$^` (all dependencies of the current rule).

~~~ {.bash}
results.txt: *.dat
    @echo $^
    python zipf_test.py $^ > $@
~~~
The rules for `*.dat` are not executed because their corresponding `.txt` files
haven't been modified.

If you run:

~~~ {.bash}
    $ touch *.dat
    $ touch books/*.txt
    $ make results.txt
~~~

You will find that the `.dat` files as well as `results.txt` are recreated.

* * *



> ## Rewrite `.dat` rules to use automatic variables {.challenge}
>
> Rewrite each `.dat` rule to use the automatic variables `$@` ('the
> target of the current rule') and `$<` ('the first dependency of the
> current rule').

~~~ {.make}
# Generate summary table.
results.txt : *.dat
    	python zipf_test.py $^ > $@

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

isles.dat : books/isles.txt
    	python wordcount.py $< $@

abyss.dat : books/abyss.txt
    	python wordcount.py $< $@

last.dat : books/last.txt
    	python wordcount.py $< $@

.PHONY : clean
clean :
    	rm -f *.dat
    	rm -f results.txt
~~~

## Lesson 04-dependencies

> ## Updating one input file {.challenge}
>
> What will happen if you now execute:
>
> ~~~ {.bash}
> $ touch books/last.txt
> $ make results.txt
> ~~~
>
> 1. only `last.dat` is recreated
> 2. all `.dat` files are recreated
> 3. only `last.dat` and `results.txt` are recreated
> 4. all `.dat` and `results.txt` are recreated

* * *
3. only `last.dat` and `results.txt` are recreated

'Follow' the decency tree to understand the answer(s).

> ## `workcloud.py` as dependency of `results.txt` {.challenge}
>
> What would happen if you actually added `workcloud.py` as dependency of `results.txt`, and why?

`workcloud.py` becomes a part of `$^`, thus the command becomes

~~~ {.bash}
python zipf_test.py abyss.dat isles.dat last.dat workcloud.py > results.txt
~~~

This results in an error from `zipf_test.py` as it tries to parse the script:

~~~ {.output}
Traceback (most recent call last):
  File "zipf_test.py", line 19, in <module>
    counts = load_word_counts(input_file)
  File "path/to/wordcount.py", line 35, in load_word_counts
    with open(filename, "r") as input_fd:
IOError: [Errno 2] No such file or directory: 'workcloud.py'
~~~


## Lesson 06-variables

> ## Use variables {.challenge}
>
> Update `Makefile` so that the `%.dat` rule
> reference the variables `COUNT_SRC` and `COUNT_EXE`.
> Then do the same for the `zipf-test.py` script and the `results.txt` rule, using `ZIPF_SRC` and `ZIPF_EXE` as variable names


~~~ {.make}
COUNT_SRC=wordcount.py
COUNT_EXE=python $(COUNT_SRC)
ZIPF_SRC=zipf_test.py
ZIPF_EXE=python $(ZIPF_SRC)

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

## Lesson 08-variables

> ## Extend the Makefile to create PNGs {.challenge}
>
> Add new rules, update existing rules, and add new macros to:
> 
> * Create `.png` files from `.dat` files using `plotcount.py`.
> * Add the script and `.png` files to the archive.
> * Remove all auto-generated files (`.dat`, `.png`,
>   `results.txt`). 
>
> Finally, many Makefiles define a default [phony target](reference.html#phony-target) called `all` that will build what the Makefile has been written to build (e.g. in our case, `results.txt`). As others may assume your Makefile confirms to convention and supports an `all` target, add an `all` target to your Makefile (Hint: this rule has a single dependency but no actions).


~~~{.make}
# config.mk
# Count words script.
COUNT_SRC=wordcount.py
COUNT_EXE=python $(COUNT_SRC)

# Test Zipf's rule
ZIPF_SRC=zipf_test.py
ZIPF_EXE=python $(ZIPF_SRC)
~~~

~~~{.make}
# Makefile
include config.mk

TXT_FILES=$(wildcard books/*.txt)
DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))
PNG_FILES=$(patsubst books/%.txt, %.png, $(TXT_FILES))

.PHONY : all
all : results.txt

# Generate summary table.
results.txt : $(DAT_FILES) $(PNG_FILES) $(ZIPF_SRC)
	$(ZIPF_EXE) *.dat > $@

# Count words.
.PHONY : dats
dats : $(DAT_FILES)

%.dat : books/%.txt $(COUNT_SRC)
	$(COUNT_EXE) $< $*.dat

# Plot word counts.
.PHONY : pngs
pngs : $(PNG_FILES)

%.png : %.dat $(PLOT_SRC)
	$(PLOT_EXE) $*.dat $*.png

.PHONY : clean
clean :
	rm -f $(DAT_FILES)
	rm -f $(PNG_FILES)
	rm -f results.txt

.PHONY : variables
variables:
	@echo TXT_FILES: $(TXT_FILES)
	@echo DAT_FILES: $(DAT_FILES)
	@echo PNG_FILES: $(PNG_FILES)
~~~
