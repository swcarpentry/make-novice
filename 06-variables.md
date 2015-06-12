---
layout: page
title: Automation and Make
subtitle: Variables
minutes: TBC
---

> ## Learning Objectives {.objectives}
>
> * Use variables in a Makefile.

Despite our efforts, our Makefile still has repeated content, namely the name of our script, `wordcount.py`. If we renamed our script we'd have to update our Makefile in multiple places.

We can introduce a Make *variable* (called a *macro* in some versions of Make). To hold our script name:

~~~ {.make}
COUNT_SRC=wordcount.py
~~~

`wordcount.py` is our script and it is invoked by passing it to `python`. We can introduce a variable to represent this execution:

~~~ {.make}
COUNT_EXE=python $(COUNT_SRC)
~~~

`$(...)` tells Make to replace the variable with its value when Make is run.

This allows us to easily change how our script is run (if, for example, we changed the language used to implement our script from Python to R).

> ## Use variables {.challenge}
>
> Update `Makefile` so that the `%.dat` and `analysis.tar.gz` rules use the variables `COUNT_SRC` and `COUNT_EXE`.

We place variables at the top of a Makefile means they are easy to find and modify. Alternatively, we can pull them out into a new Makefile that just holds variable definitions. Let us create `config.mk`:

~~~ {.make}
# Count words script.
COUNT_SRC=wordcount.py
COUNT_EXE=python $(COUNT_SRC)
~~~

We can then import this Makefile into `Makefile` using:

~~~ {.make}
include config.mk
~~~

We can re-run Make to see that everything still works:

~~~ {.bash}
$ make clean
$ make dats
$ make analysis.tar.gz
~~~

We have separated the configuration of our Makefile from its rules, the parts that do all the work. If we want to change our script name or how it is executed we just need to edit our configuration file, not our source code in `Makefile`. Decoupling code from configuration in this way is good programming practice, as it promotes more modular, flexible and reusable code.
