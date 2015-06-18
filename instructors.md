---
layout: page
title: Automation and Make
subtitle: Instructor's Guide
---

## Legend

Make is a popular tool for automating the building of software -
compiling source code into executable programs.

Though Make is nearly 40 years old, and there are many other build
tools available, its fundamental concepts are common across build
tools.

Today, researchers working with legacy codes in C or FORTRAN, which
are very common in high-performance computing, will, very likely
encounter Make.

Researchers are also finding Make of use in implementing reproducible
research workflows, automating data analysis and visualisation (using
Python or R) and combining tables and plots with text to produce
reports and papers for publication.

## Overall

The overall lesson can be done in a 2 hour slot.

Solutions for challenges are used in subsequent topics.

A number of example Makefiles, including sample solutions to
challenges, are in `code/samples` and are identified below.

## Setting up Make

Recommend instructors and students use `nano` as the text editor for
this lesson because 

* it runs in all three major operating systems,
* it runs inside the shell (switching windows can be confusing to
  students), and
* it has shortcut help at the bottom of the window.

Please point out to students during setup that they can and should use
another text editor if they're already familiar with it.

Instructors and students should use two shell windows: one for running
nano, and one for running Make.

Check that all attendees have Make installed and that it runs
correctly, before beginning the session.

## Code and data files

Python scripts to be invoked by Make are in `code/wordcount.py` and
`code/plotcount.py`.

Data files are in `data/books`.

You can either create a simple Git repository for students to clone
which contains:

* `wordcount.py`
* `plotcount.py`
* `books/`

Or, ask students to download
[make-lesson.tar.gz](./make-lesson.tar.gz) from this repository.

To recreate `make-lesson.tar.gz`, run:

~~~ {.bash}
$ make make-lesson.tar.gz
~~~

## Beware of spaces!

The single most commonly occurring problem will be students using
spaces instead of TABs when intending actions.

## [Introduction](01-intro.html)

## [Makefiles](02-makefiles.html)

`02-makefile/Makefile` contains an example of the Makefile,
immediately before the challenge is attempted.

Write two new rules - challenge

* Allow 10 minutes.
* `02-makefile-challenge/Makefile` contains a solution.

## [Automatic variables](03-variables.html)

`03-variables/Makefile` contains an example of the Makefile,
immediately before the challenge is attempted.

Rewrite `.dat` rules to use automatic variables - challenge

* Allow 5 minutes.
* `03-variables-challenge/Makefile` contains a solution.

## [Dependencies on data and code](04-dependencies.html)

`04-dependencies/Makefile` contains an example of the Makefile on
completion of the topic.

## [Pattern rules](05-patterns.html)

`04-patterns/Makefile` contains an example of the Makefile on
completion of the topic.

## [Variables](06-variables.html)

Use variables - challenge

* Allow 10 minutes.
* `06-variables-challenge/Makefile` contains a solution.

`06-variables/Makefile` and `06-variables/config.mk` contains an
example of the Makefiles on completion of the topic.

## [Functions](07-functions.html)

`07-functions/Makefile` and `07-functions/config.mk` contains an
example of the Makefiles on completion of the topic.

## [Conclusion](08-conclusion.html)

Extend the Makefile to create JPEGs - challenge

* Allow 15 minutes.
* `08-conclusion-challenge/Makefile` and
  `08-conclusion-challenge/config.mk` contain a solution.
