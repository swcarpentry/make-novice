---
layout: lesson
title: Automation and Make
---

Make is a tool which can run commands to read files, process these
files in some way, and write out the processed files. For example,
in software development, Make is used to compile source code
into executable programs or libraries, but Make can also be used
to:

* run analysis scripts on raw data files to get data files that
  summarize the raw data;
* run visualisation scripts on data files to produce plots; and to
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

> ## Prerequisites {.prereq}
>
> In this lesson we use `make` from the Unix Shell. Some previous
> experience with using the shell to list directories, create, copy,
> remove and list files and directories, and run simple scripts is
> necessary.

> ## Getting ready {.getready}
>
> You need to download some files to follow this lesson:
> 
> 1. Download [make-lesson.tar.gz](./make-lesson.tar.gz).
> 2. Move `make-lesson.tar.gz` into a directory which you can access via your bash shell.
> 3. Open a bash shell window.
> 4. Navigate to the directory where you downloaded the file.
> 5. Unpack `make-lesson.tar.gz`:
>
> ~~~ {.bash}
> $ tar -xvf make-lesson.tar.gz
> ~~~
>
> 6. Change into the `make-lesson` directory:
>
> ~~~ {.bash}
> $ cd make-lesson
> ~~~

## Topics

1.  [Introduction](01-intro.html)
2.  [Makefiles](02-makefiles.html)
3.  [Automatic variables](03-variables.html)
4.  [Dependencies on data and code](04-dependencies.html)
5.  [Pattern rules](05-patterns.html)
6.  [Variables](06-variables.html)
7.  [Functions](07-functions.html)
8.  [Conclusion](08-conclusion.html)

## Other Resources

*   [Reference](reference.html)
*   [Discussion](discussion.html)
*   [Instructor's Guide](instructors.html)
*   [Solutions](solutions.html)
