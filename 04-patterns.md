---
layout: page
title: Automation and Make
subtitle: Pattern rules
minutes: TBC
---

Question: our Makefile still has repeated content. Where?

Answer: the rules for each .dat file.

Let's replace the rules with a single 'pattern rule':

    %.dat : books/%.txt wordcount.py

`%` is a Make wild-card.

We now need to provide a body for the rule. Let's try:

	python wordcount.py books/%.txt %.dat

This does **not** work. 

We can use `-n` to see what make would do - the commands it will run - without it actually running them:

    touch books/*.txt
    make -n analysis.tar.gz

It is treating `%.dat` as an actual file name in the action - the `%` wild-card is only expanded in the target and dependencies. 

We need to rewrite the action.

Exercise 2 - change an action (10 minutes)
-----------------------------

See [exercises](MakeExercises.md).

You will need another special macro, `$<` which means 'the first dependency of the current rule'.

Solution: 

    # Count words.
    %.dat : books/%.txt wordcount.py
	    python wordcount.py $< $@

    analysis.tar.gz : *.dat wordcount.py
        tar -czf $@ $^

    .PHONY : dats
    dats : isles.dat abyss.dat last.dat

Let's check:

    rm *.dat
    make dats
