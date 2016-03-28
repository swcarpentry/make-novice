---
layout: page
title: Automation and Make
subtitle: Discussion
---

## Parallel execution

Make can build dependencies in parallel sub-processes, via its `-j`
flag which specifies the number of sub-processes to use e.g.

~~~ {.bash}
$ make -j 4 analysis.tar.gz
~~~

For more information see the GNU Make manual chapter on [Parallel
Execution](https://www.gnu.org/software/make/manual/html_node/Parallel.html).

## Make and reproducible research

Blog articles, papers, and tutorials on automating commonly
occurring research activities using Make:

* [minimal make](http://kbroman.org/minimal_make/) by Karl Broman. A
  minimal tutorial on using Make with R and LaTeX to automate data
  analysis, visualisation and paper preparation. This page has links
  to Makefiles for many of his papers. 
* [Why Use Make](http://bost.ocks.org/mike/make/) by Mike Bostock. An
  example of using Make to download and convert data. 
* [Makefiles for R/LaTeX
  projects](http://robjhyndman.com/hyndsight/makefiles/) by Rob
  Hyndman. Another example of using Make with R and LaTeX. 
* [GNU Make for Reproducible Data Analysis](http://zmjones.com/make/)
  by Zachary Jones. Using Make with Python and LaTeX. 
* Shaun Jackman's [Using Make to increase Automation &
  Reproducibility](https://www.youtube.com/watch?v=_F5f0qi-aEc)
  video lesson, and accompanying
  [example](https://github.com/sjackman/makefile-example).
* Askren MK, McAllister-Day TK, Koh N, Mestre Z, Dines JN, Korman BA,
  Melhorn SJ, Peterson DJ, Peverill M, Qin X, Rane SD, Reilly MA,
  Reiter MA, Sambrook KA, Woelfer KA, Grabowski TJ and Madhyastha 
  TM (2016) [Using Make for Reproducible and Parallel Neuroimaging
  Workflow and Quality-Assurance](http://journal.frontiersin.org/article/10.3389/fninf.2016.00002/full). Front. Neuroinform. 10:2. doi: 10.3389/fninf.2016.00002 
