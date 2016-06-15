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

'Follow' the dependency tree to understand the answer(s).

* * *

> ## `wordcount.py` as dependency of `results.txt`. {.challenge}
>
> What would happen if you actually added `wordcount.py` as dependency of `results.txt`, and why?

If you change the rule for the `results.txt` file like this:

~~~ {.make}
results.txt : *.dat wordcount.py
        python zipf_test.py $^ > $@
~~~

`wordcount.py` becomes a part of `$^`, thus the command becomes

~~~ {.bash}
python zipf_test.py abyss.dat isles.dat last.dat wordcount.py > results.txt
~~~

This results in an error from `zipf_test.py` as it tries to parse the script as if it were a `.dat` file. Try this by running:

~~~ {.bash}
$ make results.txt
~~~

You'll get

~~~ {.output}
python zipf_test.py abyss.dat isles.dat last.dat wordcount.py > results.txt
Traceback (most recent call last):
  File "zipf_test.py", line 19, in <module>
    counts = load_word_counts(input_file)
  File "path/to/wordcount.py", line 39, in load_word_counts
    counts.append((fields[0], int(fields[1]), float(fields[2])))
IndexError: list index out of range
make: *** [results.txt] Error 1
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

## Lesson 09-conclusion

> ## Extend the Makefile to create PNGs {.challenge}
>
> Add new rules, update existing rules, and add new macros to:
> 
> * Create `.png` files from `.dat` files using `plotcount.py`.
> * Add the `zip_test.py` script as dependency of the `results.txt` file
> * Remove all auto-generated files (`.dat`, `.png`,
>   `results.txt`). 
>
> Finally, many Makefiles define a default [phony target](reference.html#phony-target) called `all` as first target, that will build what the Makefile has been written to build (e.g. in our case, the `.png` files and the `results.txt` file). As others may assume your Makefile confirms to convention and supports an `all` target, add an `all` target to your Makefile (Hint: this rule has the `results.txt` file and the `.png` files as dependencies, but no actions).
> With that in place, instead of running `make results.txt`, you should now run `make all`, or just simply `make`. By default, `make` runs the first target it finds in the Makefile, in this case your new `all` target.

~~~{.make}
# config.mk
# Count words script.
COUNT_SRC=wordcount.py
COUNT_EXE=python $(COUNT_SRC)

# Plot word counts script.
PLOT_SRC=plotcount.py
PLOT_EXE=python $(PLOT_SRC)

# Test Zipf's rule
ZIPF_SRC=zipf_test.py
ZIPF_EXE=python $(ZIPF_SRC)
~~~

~~~{.make}
include config.mk

TXT_FILES=$(wildcard books/*.txt)
DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))
PNG_FILES=$(patsubst books/%.txt, %.png, $(TXT_FILES))

## all         : Generate Zipf summary table and plots of word counts.
.PHONY : all
all : results.txt $(PNG_FILES)

## results.txt : Generate Zipf summary table.
results.txt : $(DAT_FILES) $(ZIPF_SRC)
        $(ZIPF_EXE) *.dat > $@

## dats        : Count words in text files.
.PHONY : dats
dats : $(DAT_FILES)

%.dat : books/%.txt $(COUNT_SRC)
        $(COUNT_EXE) $< $*.dat

## pngs        : Plot word counts.
.PHONY : pngs
pngs : $(PNG_FILES)

%.png : %.dat $(PLOT_SRC)
        $(PLOT_EXE) $*.dat $*.png

## clean       : Remove auto-generated files.
.PHONY : clean
clean :
        rm -f $(DAT_FILES)
        rm -f $(PNG_FILES)
        rm -f results.txt

## variables   : Print variables.
.PHONY : variables
variables:
        @echo TXT_FILES: $(TXT_FILES)
        @echo DAT_FILES: $(DAT_FILES)
        @echo PNG_FILES: $(PNG_FILES)

.PHONY : help
help : Makefile
        @sed -n 's/^##//p' $<
~~~

> ## Extend the Makefile to create an archive of code, data, plots and Zipf summary table {.challenge}
> 
> Add new rules, update existing rules, and add new macros to:
>
>  * Define the name of a directory, `zipf_analysis`, to hold all our
>    code, data, plots and the Zipf summary table.
> * Copy all our code, data, plots and the Zipf summary table to this
>   directory. 
> * Create an archive, `zipf_analysis.tar.gz`, of this directory. The
>   bash command `tar` can be used, as follows: 
>
> ~~~ {.bash}
> $ tar -czf zipf_analysis.tar.gz zipf_analysis
> ~~~
>
> * Update `all` to create `zipf_analysis.tar.gz`.
> * Remove `zipf_analysis` and `zipf_analysis.tar.gz` when `make
>   clean` is called. 
> * Print the values of any additional variables you have defined when
>   `make variables` is called. 

~~~ {.make}
include config.mk

TXT_FILES=$(wildcard books/*.txt)
DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))
PNG_FILES=$(patsubst books/%.txt, %.png, $(TXT_FILES))
ZIPF_DIR=zipf_analysis
ZIPF_ARCHIVE=$(ZIPF_DIR).tar.gz

## all         : Generate archive of code, data, plots and Zipf summary table.
.PHONY : all
all : $(ZIPF_ARCHIVE)

$(ZIPF_ARCHIVE) : $(ZIPF_DIR)
	tar -czf $@ $<

$(ZIPF_DIR): Makefile results.txt \
             $(DAT_FILES) $(PNG_FILES) $(RESULTS_TXT) \
             $(COUNT_SRC) $(PLOT_SRC) $(ZIPF_SRC)
	mkdir -p $@
	cp $^ $@

## results.txt : Generate Zipf summary table.
results.txt : $(DAT_FILES) $(ZIPF_SRC)
	$(ZIPF_EXE) *.dat > $@

## dats        : Count words in text files.
.PHONY : dats
dats : $(DAT_FILES)

%.dat : books/%.txt $(COUNT_SRC)
	$(COUNT_EXE) $< $*.dat

## pngs        : Plot word counts.
.PHONY : pngs
pngs : $(PNG_FILES)

%.png : %.dat $(PLOT_SRC)
	$(PLOT_EXE) $*.dat $*.png

## clean       : Remove auto-generated files.
.PHONY : clean
clean :
	rm -f $(DAT_FILES)
	rm -f $(PNG_FILES)
	rm -f results.txt
	rm -rf $(ZIPF_DIR)
	rm -f $(ZIPF_ARCHIVE)

## variables   : Print variables.
.PHONY : variables
variables:
	@echo TXT_FILES: $(TXT_FILES)
	@echo DAT_FILES: $(DAT_FILES)
	@echo PNG_FILES: $(PNG_FILES)
	@echo ZIPF_DIR: $(ZIPF_DIR)
	@echo ZIPF_ARCHIVE: $(ZIPF_ARCHIVE)

.PHONY : help
help : Makefile
	@sed -n 's/^##//p' $<
~~~

> ## Adding the Makefile to our archive {.challenge}
>
> Why do we add the Makefile to our archive of code, data, plots and Zipf summary table?

Our code (`wordcount.py`, `plotcount.py`, `zipf_test.py`) implement the individual parts of our workflow. They allow us to create `.dat` files from `.txt` files, `.png` files from `.dat` files and `results.txt`. Our Makefile, however, documents dependencies between our code, raw data, derived data, and plots, as well as implementing our workflow as a whole.
