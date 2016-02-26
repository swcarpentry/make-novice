---
layout: page
title: Automation and Make
subtitle: Introduction
minutes: 30
---

> ## Learning Objectives {.objectives}
>
> * Explain what Make is for.
> * Explain why Make differs from shell scripts.
> * Name other popular build tools.

Let's imagine that we're interested in
testing Zipf's Law in some of our favorite books.

> ## Zipf's Law {.callout}
>
> The most frequently-occurring word occurs approximately twice as
> often as the second most frequent word. This is [Zipf's
> Law](http://en.wikipedia.org/wiki/Zipf%27s_law).

We've compiled our raw data, the books we want to analyze
(check out e.g. `head books/isles.txt`)
and have prepared several Python scripts that together make up our
analysis pipeline.

The first step is to count the frequency of each word in the book.

~~~ {.bash}
$ python wordcount.py books/isles.txt isles.dat
~~~

Let's take a quick peek at the result.

~~~ {.bash}
$ head -5 isles.dat
~~~

This shows us the top 5 lines in the output file:

~~~ {.output}
the 3822 6.7371760973
of 2460 4.33632998414
and 1723 3.03719372466
to 1479 2.60708619778
a 1308 2.30565838181
~~~

We can see that the file consists of one row per word.
Each row shows the word itself, the number of occurrences of that
word, and the number of occurrences as a percentage of the total
number of words in the text file.

We can do the same thing for a different book:

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


Finally, let's visualize the results.
The script `plotcount.py` reads in a data
file and plots the 10 most frequently occurring words.

~~~ {.bash}
$ python plotcount.py isles.dat show
~~~

Close the window to exit the plot.

`plotcount.py` can also save the plot as an image (e.g. a PNG file):

~~~ {.bash}
$ python plotcount.py isles.dat isles.png
~~~

Together these scripts implement a common workflow:

1. Read a data file.
2. Perform an analysis on this data file.
3. Write the analysis results to a new file.
4. Plot a graph of the analysis results.
5. Save the graph as an image, so we can put it in a paper.

To wrap it all up, let's archive our results to share with a collaborator.

~~~ {.bash}
tar -czf analysis.tar.gz isles.dat abyss.dat
~~~

Running `wordcount.py` and `plotcount.py` at the shell prompt, as we
have been doing, is fine for one or two files. If, however, we had 5
or 10 or 20 text files,
or if the number of steps in the pipeline were to expand, this could turn into
a lot of work.
Plus, no one wants to sit and wait for a command to finish, even just for 30
seconds.

The most common solution to the tedium of data processing is to write
a master script that runs the whole pipeline from start to finish.

Using your text editor of choice (e.g. nano), add the following to a file named
`run_pipeline.sh`.

~~~ {.bash}
# USAGE: bash run_pipeline.sh
# to produce plots for isles and abyss.

python wordcount.py isles.txt isles.dat
python wordcount.py abyss.txt abyss.dat

python plotcount.py isles.dat isles.png
python plotcount.py abyss.dat abyss.png

tar -czf analysis.tar.gz isles.dat abyss.dat
~~~

This master script solved several problems in computational reproducibility:

1.  It explicitly documents our pipeline,
    making communication with colleagues (and our future selves) more efficient.
2.  It allows us to type a single command, `bash run_pipeline.sh`, to
    reproduce the full analysis.
3.  It prevents us from _repeating_ typos or mistakes.
    You might not get it right the first time, but once you fix something
    it'll stay fixed.

Despite these benefits it has a few shortcomings.

Let's adjust the width of the bars in our plot produced by `plotcount.py`.
Edit the script so that the bars are 0.8 units wide instead of 1 unit.
(Hint: replace `width = 1.0` with `width = 1.0` in the definition of
`plot_word_counts`.)

Now we want to recreate our figures.
We _could_ just `bash run_pipeline.sh` again.
That would work, but it could also be a big pain if counting words takes
more than a few seconds.
The word counting routine hasn't changed; we shouldn't need to recreate
those files.

Alternatively, we could manually rerun the plotting for each word-count file.
(Experienced shell scripters can make this easier on themselves using a
for-loop.)

~~~ {.bash}
for book in abyss isles; do
    python plotcount.py $book.dat $book.png
done

tar -czf analysis.tar.gz isles.dat abyss.dat
~~~

With this approach, however,
we don't get many of the benefits of having a master script in the first place.

Another popular option is to comment out a subset of the lines in
`run_pipeline.sh`:

~~~ {.bash}
# USAGE: bash run_pipeline.sh
# to produce plots for isles and abyss.

#python wordcount.py isles.txt isles.dat
#python wordcount.py abyss.txt abyss.dat

python plotcount.py isles.dat isles.png
python plotcount.py abyss.dat abyss.png

tar -czf analysis.tar.gz isles.dat abyss.dat
~~~

Followed by `bash run_pipeline.sh`.

But this process, and subsequently undoing it,
can be a hassle and source of errors in complicated pipelines.

What we really want is an executable _description_ of our pipeline that
allows software to do the tricky part for us:
figuring out what steps need to be rerun.

Make was developed by 
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

[GNU Make](http://www.gnu.org/software/make/) is a free, fast, 
well-documented, and very popular Make implementation. From now on, 
we will focus on it, and when we say Make, we mean GNU Make.
