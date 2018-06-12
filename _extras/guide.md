---
layout: page
title: "Instructor Notes"
permalink: /guide/
---

Make is a popular tool for automating the building of software -
compiling source code into executable programs.

Though Make is nearly 40 years old, and there are many other build
tools available, its fundamental concepts are common across build
tools.

Today, researchers working with legacy codes in C or FORTRAN, which
are very common in high-performance computing, will, very likely
encounter Make.

Researchers are also finding Make of use in implementing reproducible
research workflows, automating data analysis and visualization (using
Python or R) and combining tables and plots with text to produce
reports and papers for publication.

## Overall

The overall lesson can be done in a 2 hour slot.

Solutions for challenges are used in subsequent topics.

A number of example Makefiles, including sample solutions to
challenges, are in `code/samples` and are identified below.

It can be useful to use two windows during the lesson, one with the terminal where you run the `make` commands, the other with the Makefile opened in a text editor all the time. This makes it possible to refer to the Makefile while explaining the output from the commandline, for example. Make sure, though, that the text in both windows is readable from the back of the room.

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

* `countwords.py`
* `plotcounts.py`
* `testzipf.py`
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

## Makefile Dependency Images

Some of these pages use images of Makefile dependencies, in the `fig` directory.

These are created using [makefile2graph][makefile2graph],
which is assumed to be in the `PATH`.
This tool, in turn, needs the `dot` tool, part of [GraphViz][graphviz].

To install GraphViz on Scientific Linux 6:

~~~
$ sudo yum install graphviz
$ dot -V
~~~
{: .bash}
~~~
dot - graphviz version 2.26.0 (20091210.2329)
~~~
{: .output}

To install GraphViz on Ubuntu 14.04.3 and 15.10:

~~~
$ sudo apt-get install graphviz
$ dot -V
~~~
{: .bash}
~~~
dot - graphviz version 2.38.0 (20140413.2041)
~~~
{: .output}

To download and build makefile2graph on Linux:

~~~
$ cd
$ git clone https://github.com/lindenb/makefile2graph
$ cd makefile2graph/
$ make
$ export PATH=~/makefile2graph/:$PATH
$ cd
$ which makefile2graph
~~~
{: .bash}
~~~
/home/ubuntu/makefile2graph/makefile2graph
~~~
{: .output}

To create the image files for the lesson:

~~~
$ make diagrams
~~~
{: .bash}

See `commands.mk`'s `diagrams` target.

## UnicodeDecodeError troubleshooting

When processing `books/last.txt` with Python 3 and vanilla shell environment on Arch Linux
the following error has appeared:

~~~
$ python wordcount.py books/last.txt last.dat
~~~
{: .bash}
~~~
Traceback (most recent call last):
  File "wordcount.py", line 131, in <module>
    word_count(input_file, output_file, min_length)
  File "wordcount.py", line 118, in word_count
    lines = load_text(input_file)
  File "wordcount.py", line 14, in load_text
    lines = input_fd.read().splitlines()
  File "/usr/lib/python3.6/encodings/ascii.py", line 26, in decode
    return codecs.ascii_decode(input, self.errors)[0]
UnicodeDecodeError: 'ascii' codec can't decode byte 0xc3 in position 6862: ordinal not in range(128)
~~~
{: .output}

The workaround was to define encoding for the terminal session (this can be either done at the command line
or placed in the `.bashrc` or equivalent):

~~~
$ export LC_ALL=en_US.UTF-8
$ export LANG=en_US.UTF-8
$ export LANGUAGE=en_US.UTF-8
~~~
{: .bash}

[graphviz]: http://www.graphviz.org/
[lesson-example]: https://github.com/carpentries/lesson-example/
[makefile2graph]: https://github.com/lindenb/makefile2graph
[zipfile]: {{ page.root }}/files/make-lesson.zip
