---
layout: page
title: Discussion
---

## Parallel Execution

Make can build dependencies in _parallel_ sub-processes, via its `--jobs`
flag (or its `-j` abbreviation) which specifies the number of sub-processes to use e.g.

~~~
$ make --jobs 4 results.txt
~~~
{: .bash}

If we have independent dependencies then these can be built at the
same time. For example, `abyss.dat` and `isles.dat` are mutually
independent and can both be built at the same time. Likewise for
`abyss.png` and `isles.png`. If you've got a bunch of independent
branches in your analysis, this can greatly speed up your build
process.

For more information see the GNU Make manual chapter on [Parallel
Execution][gnu-make-parallel].

## Different Types of Assignment

Some Makefiles may contain `:=` instead of `=`. Your Makefile may
behave differently depending upon which you use and how you use it:

* A variable defined using `=` is a _recursively expanded
  variable_. Its value is calculated only when its value is
  requested. If the value assigned to the variable itself contains
  variables (e.g. `A = $(B)`) then these variables' values are only
  calculated when the variable's value is requested (e.g. the value of
  `B` is only calculated when the value of `A` is requested via
  `$(A)`. This can be termed _lazy setting_.

* A variable defined using `:=` is a _simply expanded variable_. Its
  value is calculated when it is declared. If the value assigned to
  the variable contains variables (e.g. `A = $(B)`) then these
  variables' values are also calculated when the variable is declared
  (e.g. the value of `B` is calculated when `A` is assigned
  above). This can be termed _immediate setting_.

For a detailed explanation, see:

* StackOverflow [Makefile variable assignment][makefile-variable]
* GNU Make [The Two Flavors of Variables][gnu-make-variables]

## Make and Version Control

Imagine that we manage our Makefiles using a version control 
system such as Git.

Let's say we'd like to run the workflow developed in this lesson
for three different word counting scripts, in order to compare their
speed (e.g. `wordcount.py`, `wordcount2.py`, `wordcount3.py`).

To do this we could edit `config.mk` each time by replacing
`COUNT_SRC=wordcount.py` with `COUNT_SRC=wordcount2.py` or
`COUNT_SRC=wordcount3.py`,
but this would be detected as a change by the version control system.
This is a minor configuration change, rather than a change to the 
workflow, and so we probably would rather avoid committing this change
to our repository each time we decide to test a different counting script.

An alternative is to leave `config.mk` untouched, by overwriting the value 
of `COUNT_SRC` at the command line instead:

```
$ make variables COUNT_SRC=wordcount2.py
```

The configuration file then simply contains the default values for the 
workflow, and by overwriting the defaults at the command line you can
maintain a neater and more meaningful version control history.

## Make and Reproducible Research

Blog articles, papers, and tutorials on automating commonly
occurring research activities using Make:

* [minimal make][minimal-make] by Karl Broman. A minimal tutorial on
  using Make with R and LaTeX to automate data analysis, visualization
  and paper preparation. This page has links to Makefiles for many of
  his papers.

* [Why Use Make][why-use-make] by Mike Bostock. An example of using
  Make to download and convert data.

* [Makefiles for R/LaTeX projects][makefiles-for-r-latex] by Rob
  Hyndman. Another example of using Make with R and LaTeX.

* [GNU Make for Reproducible Data Analysis][make-reproducible-research]
  by Zachary Jones. Using Make with Python and LaTeX.

* Shaun Jackman's [Using Make to Increase Automation &
  Reproducibility][increase-automation] video lesson, and accompanying
  [example][increase-automation-example].

* Lars Yencken's [Driving experiments with
  make][driving-experiments]. Using Make to sandbox Python
  dependencies and pull down data sets from Amazon S3.

* Askren MK, McAllister-Day TK, Koh N, Mestre Z, Dines JN, Korman BA,
  Melhorn SJ, Peterson DJ, Peverill M, Qin X, Rane SD, Reilly MA,
  Reiter MA, Sambrook KA, Woelfer KA, Grabowski TJ and Madhyastha TM
  (2016) [Using Make for Reproducible and Parallel Neuroimaging
  Workflow and
  Quality-Assurance][make-neuroscience]. Front. Neuroinform. 10:2. doi:
  10.3389/fninf.2016.00002

* Li Haoyi's [What's in a Build Tool?][whats-a-build-tool] A review of
  popular build tools (including Make) in terms of their strengths and
  weaknesses for common build-related use cases in software
  development.

[driving-experiments]: http://lifesum.github.io/posts/2016/01/14/make-experiments/
[gnu-make-parallel]: https://www.gnu.org/software/make/manual/html_node/Parallel.html
[gnu-make-variables]: https://www.gnu.org/software/make/manual/html_node/Flavors.html#Flavors
[increase-automation]: https://www.youtube.com/watch?v=_F5f0qi-aEc
[increase-automation-example]: https://github.com/sjackman/makefile-example
[make-neuroscience]: http://journal.frontiersin.org/article/10.3389/fninf.2016.00002/full
[make-reproducible-research]: http://zmjones.com/make/
[makefile-variable]: http://stackoverflow.com/questions/448910/makefile-variable-assignment
[makefiles-for-r-latex]: http://robjhyndman.com/hyndsight/makefiles/
[minimal-make]: http://kbroman.org/minimal_make/
[whats-a-build-tool]: http://www.lihaoyi.com/post/WhatsinaBuildTool.html
[why-use-make]: http://bost.ocks.org/mike/make/
