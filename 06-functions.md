
wildcard and patsubst
---------------------

Make has many functions. 

`wildcard` gets files matching a pattern and save these in a macro:

    TXT_FILES=$(wildcard books/*.txt)

`patsubst` substitutes patterns in files e.g. change one suffix to another:

    DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))

With these we can rewrite `dats` to remove the list of files:

    .PHONY : dats
    dats : $(DAT_FILES)

Let's check:

    make clean
    make dats

Note how `sierra.txt` is now processed too.

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

