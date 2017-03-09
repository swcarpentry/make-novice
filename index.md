---
layout: lesson
root: .
---

Make is a tool which can run commands to read files, process these
files in some way, and write out the processed files. For example,
in software development, Make is used to compile source code
into executable programs or libraries, but Make can also be used
to:

* run analysis scripts on raw data files to get data files that
  summarize the raw data;
* run visualization scripts on data files to produce plots; and to
* parse and combine text files and plots to create papers.

Make is called a build tool - it builds data files, plots, papers,
programs or libraries. It can also update existing files if
desired.

Make tracks the dependencies between the files it creates and the
files used to create these. If one of the original files (e.g. a data
file) is changed, then Make knows to recreate, or update, the files
that depend upon this file (e.g. a plot).

There are now many build tools available, all of which are based on
the same concepts as Make.

> ## Prerequisites
>
> In this lesson we use `make` from the Unix Shell. Some previous
> experience with using the shell to list directories, create, copy,
> remove and list files and directories, and run simple scripts is
> necessary.
{: .prereq}

> ## Setup
> In order to follow this lesson, you will need to download some files.
> Please follow instructions on the [setup]({{ page.root }}/setup) page.
{: .prereq}
