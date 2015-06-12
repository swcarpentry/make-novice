---
layout: page
title: Automation and Make
subtitle: Makefiles
minutes: TBC
---

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

