---
layout: page
title: Automation and Make
subtitle: Makefiles
minutes: TBC
---

Create a `Makefile`:

    # Count words.
    isles.dat : books/isles.txt
            python wordcount.py books/isles.txt isles.dat
 
Makefile's structure:

* # denotes comments.
* `isles.dat` is a target.
  - Some 'thing' to be built.
* `:` separates targets from dependencies.
* `books/isles.dat` is a dependency.
  - Some 'thing' that is needed to build the target.
* `python wordcount.py books/isles.txt isles.dat` is an action.
  - A command to run to build the target ('thing'), or update it.
  - Actions are indented using TAB, not 8 spaces. 
  - A legacy of Make's 1970's origins.

To use the default Makefile:

    make

To use a named Makefile:

    make -f Makefile

Question: why did nothing happen?

Answer: the target is now up-to-date and newer than its dependency. Make uses a file's 'last modification time'.

Let's pretend we update books/isles.txt and try again:

    touch books/isles.txt
    make

Let's add another target:

    abyss.dat : books/abyss.txt
            python wordcount.py books/abyss.txt abyss.dat

And, run Make:

    make
    touch books/abyss.txt
    make

Nothing happens as the first, default, target in the makefile, is used. We can explicitly state which target to build:

    make abyss.dat

Let's add a target to allow us to build both data files:

    .PHONY : dats
    dats : isles.dat abyss.dat

`dats` is not a file or directory but depends on files and directories, so can trigger their rebuilding. It is a 'phony' target so we mark it as such.

A dependency in one rule can be a target in another. For example, isles.dat is a dependency in this rule and a target in our earlier rule.

We can now use this phony target:

    make dats
    touch books/isles.txt books/abyss.txt
    make dats

The order of rebuilding dependencies is arbitrary.

Dependencies must make up a directed acyclic graph.

Exercise 1 - write a new rule (5 minutes)
-----------------------------

See [exercises](MakeExercises.md).

Solution:

    # Count words.
    isles.dat : books/isles.txt
            python wordcount.py books/isles.txt isles.dat

    abyss.dat : books/abyss.txt
            python wordcount.py books/abyss.txt abyss.dat

    last.dat : books/last.txt
            python wordcount.py books/last.txt last.dat

    .PHONY : dats
    dats : isles.dat abyss.dat last.dat

Let's check:

    rm *.dat
    make dats

