---
layout: lesson
title: Automation and Make
---

Make is a tool which can run commands to read files, process these files in some way, and write out the processed files. Make can be used to:

* Run analysis scripts on raw data files to get data files that summarise the raw data.
* Run visualisation scripts on data files to produce plots.
* Parse and combine text files and plots to create papers.
* Compile source code into executable programs or libraries.

Make is called a build tool - it builds data files, plots, papers, programs or libraries. 

Make records the dependencies between the files it creates and the files used to create these. If one of the original files (e.g. a data file) is changed, then Make knows to recreate the files that depend upon this file (e.g. a plot).

There are now many build tools available, all of which are based on the same concepts as Make.

> ## Prerequisites {.prereq}
>
> In this lesson we use Make from the Unix Shell. Some previous
> experience with using the shell would be useful but is not
> mandatory. 

## Topics

1.  [Introduction](01-intro.html)
2.  [Makefiles](02-makefiles.html)
3.  [Automatic variables and wildcards](03-variables.html)
4.  [Pattern rules](04-patterns.html)
5.  [Macros](05-macros.html)
6.  [Functions](06-functions.html)
7.  [Conclusion](07-conclusion.html)

## Other Resources

*   [Motivation](motivation.html)
*   [Reference](reference.html)
*   [Discussion](discussion.html)
*   [Instructor's Guide](instructors.html)
