---
layout: page
title: Automation and Make
subtitle: Introduction
minutes: 0
---

> ## Learning Objectives {.objectives}
>
> * Explain what Make is for.
> * Explain why Make differs from shell scripts.
> * Name other popular build tools.

Suppose we have a script, `wordcount.py`, that reads in a text file,
counts the words in this text file, and outputs a data file:

~~~ {.bash}
$ python wordcount.py books/isles.txt isles.dat
~~~

If we view the first 5 rows of the data file using `head`,

~~~ {.bash}
$ head -5 isles.dat
~~~

we can see that the file consists of one row per word. 

~~~ {.output}
the 3822 6.7371760973
of 2460 4.33632998414
and 1723 3.03719372466
to 1479 2.60708619778
a 1308 2.30565838181
~~~

Each row shows the word itself, the number of occurrences of that
word, and the number of occurrences as a percentage of the total
number of words in the text file. As another example:

~~~ {.bash}
$ python wordcount.py books/abyss.txt abyss.dat
$ head -5 abyss.dat
~~~

~~~ {.output}
the 4044 6.35449402891
and 2807 4.41074795726
of 1907 2.99654305468
a 1594 2.50471401634
to 1515 2.38057825267
~~~

> ## Zipf's Law {.callout}
>
> The most frequently-occurring word occurs approximately twice as
> often as the second most frequent word. This is [Zipf's
> Law](http://en.wikipedia.org/wiki/Zipf%27s_law). 

Suppose we also have a script, `plotcount.py`, that reads in a data
file and plots the 10 most frequently occurring words:

~~~ {.bash}
$ python plotcount.py isles.dat show
~~~

Close the window to exit the plot.

`plotcount.py` can also save the plot as an image (e.g. a JPEG):

~~~ {.bash}
$ python plotcount.py isles.dat isles.jpg
~~~

Together these scripts implement a common workflow:

1. Read a data file.
2. Perform an analysis on this data file.
3. Write the analysis results to a new file.
4. Plot a graph of the analysis results.
5. Save the graph as an image, so we can put it in a paper.

Running `wordcount.py` and `plotcount.py` at the shell prompt, as we
have been doing, is fine for one or two files. If, however, we had 5
or 10 or 20 text files, this would quickly become monotonous. We could
write a shell script to loop over our text files and create data files
and images for each in turn, but this too can cause problems. If a
text file changes then we need to re-run our analysis and recreate our
graph, but only for the text file that changed, not all of
them. Furthermore, we only want do this if and only if the text file
has changed.

[Make](http://www.gnu.org/software/make/) (also known as GNU Make) is
a fast, free and well-documented [build
manager](reference.html#build-manager). Make was developed by 
Stuart Feldman in 1977 as a Bell Labs summer intern, and remains in
widespread use today. Make can execute the commands needed to run our
analysis and plot our results. Like shell scripts it allows us to
execute complex sequences of commands via a single shell
command. Unlike shell scripts it explicitly records the dependencies
between files and so can determine when to recreate our data files or
image files, if our text files change. Make can be used for any
commands that follow the general pattern of processing files to create
new files, for example: 

* Run analysis scripts on raw data files to get data files that
  summarise the raw data. 
* Run visualisation scripts on data files to produce plots.
* Parse and combine text files and plots to create papers.
* Compile source code into executable programs or libraries.

There are now many build tools available, for example [Apache
ANT](http://ant.apache.org/), [doit](http://pydoit.org/), and
[nmake](https://msdn.microsoft.com/en-us/library/dd9y37ha.aspx) for
Windows. There are also build tools that build scripts for use with
these build tools and others e.g. [GNU
Autoconf](http://www.gnu.org/software/autoconf/autoconf.html) and
[CMake](http://www.cmake.org/). Which is best for you depends on your
requirements, intended usage, and operating system. However, they
all share the same fundamental concepts as Make.

> ## Why use Make if it is almost 40 years old? {.callout}
>
> Today, researchers working with legacy codes in C or FORTRAN, which
> are very common in high-performance computing, will, very likely
> encounter Make. 
>
> Researchers are also finding Make of use in implementing
> reproducible research workflows, automating data analysis and
> visualisation (using Python or R) and combining tables and plots
> with text to produce reports and papers for publication.
>
> Make's fundamental concepts are common across build tools.
