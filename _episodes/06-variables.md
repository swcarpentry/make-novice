---
title: "Variables"
teaching: 15
exercises: 15
questions:
- "How can I eliminate redundancy in my Makefiles?"
objectives:
- "Use variables in a Makefile."
- "Explain the benefits of decoupling configuration from computation."
keypoints:
- "Define variables by assigning values to names."
- "Reference variables using `$(...)`."
---

Despite our efforts, our Makefile still has repeated content, namely
the name of our script, `wordcount.py`. If we renamed our script we'd
have to update our Makefile in multiple places.

We can introduce a Make [variable]({{ site.github.url }}/reference/#variable) (called a
[macro]({{ site.github.url }}/reference/#macro) in some versions of Make) to hold our
script name:

~~~
COUNT_SRC=wordcount.py
~~~
{: .make}

This is a variable [assignment]({{ site.github.url }}/reference/#assignment) -
`COUNT_SRC` is assigned the value `wordcount.py`.

`wordcount.py` is our script and it is invoked by passing it to
`python`. We can introduce another variable to represent this
execution:

~~~
COUNT_EXE=python $(COUNT_SRC)
~~~
{: .make}

`$(...)` tells Make to replace a variable with its value when Make
is run. This is a variable [reference]({{ site.github.url }}/reference/#reference). At
any place where we want to use the value of a variable we have to
write it, or reference it, in this way.

Here we reference the variable `COUNT_SRC`. This tells Make to
replace the variable `COUNT_SRC` with its value `wordcount.py`. When
Make is run it will assign to `COUNT_EXE` the value `python
wordcount.py`.

Defining the variable `COUNT_EXE` in this way allows us to easily
change how our script is run (if, for example, we changed the language
used to implement our script from Python to R).

> ## Use Variables
>
> Update `Makefile` so that the `%.dat` rule
> references the variables `COUNT_SRC` and `COUNT_EXE`.
> Then do the same for the `zipf-test.py` script
> and the `results.txt` rule,
> using `ZIPF_SRC` and `ZIPF_EXE` as variable names
>
> > ## Solution

> > > ```Makefile
> > > COUNT_SRC=wordcount.py
> > > COUNT_EXE=python $(COUNT_SRC)
> > > ZIPF_SRC=zipf_test.py
> > > ZIPF_EXE=python $(ZIPF_SRC)
> > > 
> > > # Generate summary table.
> > > results.txt : *.dat $(ZIPF_SRC)
> > > 	$(ZIPF_EXE) *.dat > $@
> > > 
> > > # Count words.
> > > .PHONY : dats
> > > dats : isles.dat abyss.dat last.dat
> > > 
> > > %.dat : books/%.txt $(COUNT_SRC)
> > > 	$(COUNT_EXE) $< $*.dat
> > > 
> > > .PHONY : clean
> > > clean :
> > > 	rm -f *.dat
> > > 	rm -f results.txt
> > > ```
> {: .solution}
{: .challenge}

We place variables at the top of a Makefile so they are easy to
find and modify. Alternatively, we can pull them out into a new
file that just holds variable definitions (i.e. delete them from
the original makefile). Let us create `config.mk`:

~~~
# Count words script.
COUNT_SRC=wordcount.py
COUNT_EXE=python $(COUNT_SRC)

# Test Zipf's rule
ZIPF_SRC=zipf_test.py
ZIPF_EXE=python $(ZIPF_SRC)
~~~
{: .make}

We can then import `config.mk` into `Makefile` using:

~~~
include config.mk
~~~
{: .make}

We can re-run Make to see that everything still works:

~~~
$ make clean
$ make dats
$ make results.txt
~~~
{: .bash}

We have separated the configuration of our Makefile from its rules,
the parts that do all the work. If we want to change our script name
or how it is executed we just need to edit our configuration file, not
our source code in `Makefile`. Decoupling code from configuration in
this way is good programming practice, as it promotes more modular,
flexible and reusable code.

> ## Where We Are
>
> [This Makefile]({{ site.github.url }}/code/06-variables/Makefile)

> > ```Makefile
> > include config.mk
> > 
> > # Generate summary table.
> > results.txt : *.dat $(ZIPF_SRC)
> > 	$(ZIPF_EXE) *.dat > $@
> > 
> > # Count words.
> > .PHONY : dats
> > dats : isles.dat abyss.dat last.dat
> > 
> > %.dat : books/%.txt $(COUNT_SRC)
> > 	$(COUNT_EXE) $< $*.dat
> > 
> > .PHONY : clean
> > clean :
> > 	rm -f *.dat
> > 	rm -f results.txt
> > ```
> and [its accompanying `config.mk`]({{ site.github.url }}/code/06-variables/config.mk)

> > ```Makefile
> > # Count words script.
> > COUNT_SRC=wordcount.py
> > COUNT_EXE=python $(COUNT_SRC)
> > 
> > # Test Zipf's rule
> > ZIPF_SRC=zipf_test.py
> > ZIPF_EXE=python $(ZIPF_SRC)
> > ```
> contain all of our work so far.
{: .callout}



