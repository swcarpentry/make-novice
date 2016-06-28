---
layout: page
title: "Instructor's Guide"
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

## Code and Data Files

Python scripts to be invoked by Make are in `code/`.

Data files are in `data/books`.

You can either create a simple Git repository for students to clone
which contains:

* `wordcount.py`
* `plotcount.py`
* `zipf_test.py`
* `books/`

Or, ask students to download
[make-lesson.zip][zipfile] from this repository.

To recreate `make-lesson.zip`, run:

~~~
$ make make-lesson.zip
~~~
{: .bash}

## Beware of Spaces!

The single most commonly occurring problem will be students using
spaces instead of TABs when intending actions.

## [Introduction]({{ site.root }}/01-intro/)

## [Makefiles]({{ site.root }}/02-makefiles/)

`02-makefile/Makefile` contains an example of the Makefile,
immediately before the challenge is attempted.

Write two new rules - challenge

* Allow 10 minutes.
* `02-makefile-challenge/Makefile` contains a solution.

## [Automatic variables]({{ site.root }}/03-variables/)

`03-variables/Makefile` contains an example of the Makefile,
immediately before the challenge is attempted.

Rewrite `.dat` rules to use automatic variables - challenge

* Allow 5 minutes.
* `03-variables-challenge/Makefile` contains a solution.

## [Dependencies on data and code]({{ site.root }}/04-dependencies/)

`04-dependencies/Makefile` contains an example of the Makefile on
completion of the topic.

## [Pattern rules]({{ site.root }}/05-patterns/)

`04-patterns/Makefile` contains an example of the Makefile on
completion of the topic.

## [Variables]({{ site.root }}/06-variables/)

Use variables - challenge

* Allow 10 minutes.
* `06-variables-challenge/Makefile` contains a solution.

`06-variables/Makefile` and `06-variables/config.mk` contains an
example of the Makefiles on completion of the topic.

## [Functions]({{ site.root }}/07-functions/)

`07-functions/Makefile` and `07-functions/config.mk` contains an
example of the Makefiles on completion of the topic.

## [Self-documenting Makefiles]({{ site.root }}/08-self/.html)

## [Conclusion]({{ site.root }}/09-conclusion/)

Extend the Makefile to create PNGs - challenge

* Allow 15 minutes.
* `09-conclusion-challenge/Makefile` and
  `09-conclusion-challenge/config.mk` contain a solution.

Extend the Makefile to create an archive of code, data, plots and Zipf summary table - challenge

* Allow 15 minutes.
* `09-conclusion-challenge-2/Makefile` and
  `09-conclusion-challenge-2/config.mk` contain a solution.

## Makefile Dependency Images

Some of these pages use images of Makefile dependencies, in the [fig]({{ site.root }}/fig/) directory.

These are created using [makefile2graph][makefile2graph],
which is assumed to be in the `PATH`.
This tool, in turn, needs the `dot` tool, part of [GraphViz][graphviz].

To install GraphViz on Scientific Linux 6:

```
$ sudo yum install graphviz
$ dot -V
dot - graphviz version 2.26.0 (20091210.2329)
```

To install GraphViz on Ubuntu 14.04.3 and 15.10:

```
$ sudo apt-get install graphviz
$ dot -V
dot - graphviz version 2.38.0 (20140413.2041)
```

To download and build makefile2graph on Linux:

```
$ cd
$ git clone https://github.com/lindenb/makefile2graph
$ cd makefile2graph/
$ make
$ export PATH=~/makefile2graph/:$PATH
$ cd
$ which makefile2graph
/home/ubuntu/makefile2graph//makefile2graph
```

To create the image files for the lesson:

```
$ make figures
```

See `commands.mk`'s `figures` target.

[graphviz]: http://www.graphviz.org/
[lesson-example]: https://github.com/swcarpentry/lesson-example/
[makefile2graph]: https://github.com/lindenb/makefile2graph
[zipfile]: {{ site.root }}/files/make-lesson.zip