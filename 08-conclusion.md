---
layout: page
title: Automation and Make
subtitle: Conclusion
minutes: TBC
---

Parallel jobs
-------------

Make can run on multiple cores if available:

    make -j 4 analysis.tar.gz

Conclusion
----------

See [the purpose of Make](MakePurpose.png).

Why use Make if it is so old?

* It is still very prevalent.
* It runs on Unix/Linux, Windows and Mac.
* The concepts - targets, dependencies, actions, rules - are common to
  most build tools.

Automated build scripts help us in a number of ways. They:

* Automate repetitive tasks.
* Reduce errors that we might make if typing commands manually.
* Document how software is built, data is created, graphs are plotted, papers are composed.
* Document dependencies between code, scripts, tools, inputs, configurations, outputs.

Automated scripts are code so:

* Use meaningful variable names.
* Provide comments to explain anything that is not clear.
* Separate configuration from computation via the use of configuration files.
* Keep under revision control.

Exercise 4 - extend the Makefile to create jpgs (15 minutes)
-----------------------------------------------

See [exercises](MakeExercises.md).

Solution:

Configuration file, `config.mk`:

    # Count words script.
    COUNT_SRC=wordcount.py
    COUNT_EXE=python $(COUNT_SRC)
    # Plot word counts script.
    PLOT_SRC=plotcount.py
    PLOT_EXE=python $(PLOT_SRC)

Makefile, `Makefile`:

    include config.mk

    TXT_FILES=$(wildcard books/*.txt)
    DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))
    JPG_FILES=$(patsubst books/%.txt, %.jpg, $(TXT_FILES))

    # Count words.
    %.dat : books/%.txt $(COUNT_SRC)
            $(COUNT_EXE) $< $@

    # Plot word counts.
    %.jpg : %.dat $(PLOT_SRC)
            $(PLOT_EXE) $< $@

    .PHONY : dats
    dats : $(DAT_FILES)

    .PHONY : jpgs
    jpgs : $(JPG_FILES)

    analysis.tar.gz : $(DAT_FILES) $(JPG_FILES) $(COUNT_SRC) $(PLOT_SRC)
            tar -czf $@ $^

    .PHONY : clean
    clean : 
            rm -f $(DAT_FILES)
            rm -f $(JPG_FILES)
            rm -f analysis.tar.gz

Let's check:

    make clean
    make analysis.tar.gz




> ## Extend the Makefile to create jpgs {.challenge}
>
> Add new rules, update existing rules, and add new macros to:
> 
> * Create `.jpg` files from `.dat` files using `plotcount.py`.
> * Add the script and `.jpg` files to the archive.
> * Remove all auto-generated files (`.dat`, `.jpg`, `analysis.tar.gz`).

