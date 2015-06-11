
Macros
------

Question: there's still duplication in our makefile, where?

Answer: the program name. Suppose the name of our program changes?

    COUNT=wordcount.py

Question: is there an alternative to this?

Answer: we might change our programming language or the way in which our command is invoked, so we can instead define:

    COUNT_SRC=wordcount.py
    COUNT_EXE=python $(COUNT_SRC)

`$(...)` tells Make to replace the macro with its value when Make is run.

Exercise 3 - use macros (10 minutes)
-----------------------

See [exercises](MakeExercises.md).

Solution:

    COUNT_SRC=wordcount.py
    COUNT_EXE=python $(COUNT_SRC)

    # Count words.
    %.dat : books/%.txt $(COUNT_SRC)
            $(COUNT_EXE) $< $@

    analysis.tar.gz : *.dat $(COUNT_SRC)
            tar -czf $@ $^

    .PHONY : dats
    dats : isles.dat abyss.dat last.dat

Let's check:

    rm *.dat
    make dats

Keeping macros at the top of a Makefile means they are easy to find and modify. Alternatively, we can pull them out into a configuration file, `config.mk`:

    # Count words script.
    COUNT_SRC=wordcount.py
    COUNT_EXE=python $(COUNT_SRC)

We can then import these into our Makefile using:

    include config.mk

And, let's see that it still works:

    rm *.dat
    make dats

This is an example of good programming practice:

* It separates code from data.
* There is no need to edit the code to change its configuration which reduces the risk of introducing a bug.
* Code that is configurable is more modular, flexible and reusable.
