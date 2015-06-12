---
layout: page
title: Automation and Make
subtitle: Automatic variables
minutes: TBC
---

Our Makefile has a lot of duplication. For example, the names of text files and data files are repeated in many places throughout the Makefile. Makefiles are a form of code and, in any code, repeated code can lead to problems e.g. we rename a data file in one part of the Makefile but forget the rename it elsewhere. Let us set about removing some of this repetition.

In our `analysis.tar.gz` rule we duplicate the data file names and the archive name:

~~~ {.make}
analysis.tar.gz : isles.dat abyss.dat last.dat
        tar -czf analysis.tar.gz isles.dat abyss.dat last.dat
~~~

Looking at the archive name first, we can replace it in the action with `$@`:

~~~ {.make}
analysis.tar.gz : isles.dat abyss.dat last.dat
        tar -czf $@ isles.dat abyss.dat last.dat
~~~

`$@` is a Make *automatic variable* which means 'the target of the current rule'. When Make is run it will replace this variable with the target name.

We can replace the dependencies in the action with `$^`:

~~~ {.make}
analysis.tar.gz : isles.dat abyss.dat last.dat
        tar -czf $@ $^
~~~

`$^` is another automatic variable which means 'all the dependencies of the current rule'. Again, when Make is run it will replace this variable with the dependencies.
 
Let's update our text files and re-run our rule:

~~~ {.bash}
$ touch books/*.txt
$ make analysis.tar.gz
~~~

We get:

~~~ {.output}
python wordcount.py books/isles.txt isles.dat
python wordcount.py books/abyss.txt abyss.dat
python wordcount.py books/last.txt last.dat
tar -czf analysis.tar.gz isles.dat abyss.dat last.dat
~~~

We can use the bash wild-card in our dependency list:

~~~ {.make}
analysis.tar.gz : *.dat
        tar -czf $@ $^
~~~

Let's update our text files and re-run our rule:

~~~ {.bash}
$ touch books/*.txt
$ make analysis.tar.gz
~~~

We get the same as above.

Now let's delete the data files and re-run our rule:

~~~ {.bash}
$ make clean
$ make analysis.tar.gz
~~~

We get:

~~~ {.output}
make: *** No rule to make target `*.dat', needed by `analysis.tar.gz'.  Stop.
~~~

As there are no files that match the pattern `*.dat` the name `*.dat` is used as a file name itself, and there is no file matching that, nor any rule so we get an error. We need to explicitly rebuild the `.dat` files first:

~~~ {.bash}
$ make dats
$ make analysis.tar.gz
~~~







Dependencies on data and code
-----------------------------

Output data depends on both input data and programs that create it:

    isles.data : books/isles.txt wordcount.py
    ...
    abyss.dat : books/abyss.txt wordcount.py
    ...
    last.dat : books/last.txt wordcount.py
    ...

Let's recreate them all:

    touch wordcount.py
    make dats

Question: why don't we make the `.txt` files depend on `wordcount.py`?

Answer: `.txt` files are input files and have no dependencies. To make these depend on `wordcount.py` would introduce a 'false dependency'.

Let's add our analysis script to the archive too:

    analysis.tar.gz : *.dat wordcount.py
            tar -czf $@ $^
