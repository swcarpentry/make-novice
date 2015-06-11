---
layout: lesson
title: Automation and Make
---

Originally invented in 1977 to manage the compilation of programs,
 `make` can be used to automate any repetitive sequence of commands
 which create, or 'build' files. For this reason, make is called a
 'build tool'. make can be used, amongst other things, to invoke
 commands that: 

* Run analysis scripts on data files to produce new data files.
* Run visualisation scripts on data files to produce plots.
* Process text files and plots to create papers.
* Compile source code into executable programs.

'make' records the dependencies between the files it builds and the
files that are needed to build these. 

There are now many build tools available, all of which are based on
the same concepts as make.

> ## Prerequisites {.prereq}
>
> In this lesson we use make from the Unix Shell. Some previous
> experience with the shell is expected, *but isn't mandatory*.

> ## Getting ready {.getready}
>
> Nothing to do: you're ready to go!

## Topics

1.  [Introduction](01-intro.html)
2.  [Basic Tasks](02-basics.html)
3.  [Automatic Variables and Wildcards](03-automatic-variables.html)
4.  [Patterns](04-patterns.html)
5.  [Variables](05-variables.html)

## Other Resources

*   [Motivation](motivation.html)
*   [Reference](reference.html)
*   [Discussion](discussion.html)
*   [Instructor's Guide](instructors.html)
