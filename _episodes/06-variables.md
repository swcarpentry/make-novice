---
title: "Variables"
teaching: 15
exercises: 5
questions:
- "How can I eliminate redundancy in my Makefiles?"
objectives:
- "Use variables in a Makefile."
- "Explain the benefits of decoupling configuration from computation."
keypoints:
- "Define variables by assigning values to names."
- "Reference variables using `$(...)`."
---

Despite our efforts, our Makefile still has repeated content, i.e.
the name of our script -- `countwords.py`, and the program we use to run it -- `python`.
If we renamed our script we'd have to update our Makefile in multiple places.

We can introduce a Make [variable]({{ page.root }}/reference#variable) (called a
[macro]({{ page.root }}/reference#macro) in some versions of Make) to hold our
script name:

~~~
COUNT_SRC=countwords.py
~~~
{: .language-make}

This is a variable [assignment]({{ page.root }}/reference#assignment) -
`COUNT_SRC` is assigned the value `countwords.py`.

`countwords.py` is our script and it is invoked by passing it to
`python`. We can introduce another couple of variables to represent this
execution:

~~~
LANGUAGE=python
COUNT_EXE=$(LANGUAGE) $(COUNT_SRC)
~~~
{: .language-make}

`$(...)` tells Make to replace a variable with its value when Make
is run. This is a variable [reference]({{ page.root }}/reference#reference). At
any place where we want to use the value of a variable we have to
write it, or reference it, in this way.

Here we reference the variables `LANGUAGE` and `COUNT_SRC`. This tells Make to
replace the variable `LANGUAGE` with its value `python`,
and to replace the variable `COUNT_SRC` with its value `countwords.py`. When
Make is run it will assign to `COUNT_EXE` the value `python
countwords.py`.

Defining the variable `COUNT_EXE` in this way avoids repeating `python` in our 
Makefile, and allows us to easily
change how our script is run (e.g. we might want to use a different
version of Python and need to change `python` to `python2` -- or we might want to
rewrite the script using another language (e.g. switch from Python to R)).

> ## Use Variables
>
> Update `Makefile` so that the `%.dat` rule
> references the variables `COUNT_SRC` and `COUNT_EXE`.
> Then do the same for the `zipf-test.py` script
> and the `results.txt` rule,
> using `ZIPF_SRC` and `ZIPF_EXE` as variable names
>
> > ## Solution
> > [This Makefile]({{ page.root }}/code/06-variables-challenge/Makefile)
> > contains a solution to this challenge.
> {: .solution}
{: .challenge}

We place variables at the top of a Makefile so they are easy to
find and modify. Alternatively, we can pull them out into a new
file that just holds variable definitions (i.e. delete them from
the original makefile). Let us create `config.mk`:

~~~
# Count words script.
LANGUAGE=python
COUNT_SRC=countwords.py
COUNT_EXE=$(LANGUAGE) $(COUNT_SRC)

# Test Zipf's rule
ZIPF_SRC=testzipf.py
ZIPF_EXE=$(LANGUAGE) $(ZIPF_SRC)
~~~
{: .language-make}

We can then import `config.mk` into `Makefile` using:

~~~
include config.mk
~~~
{: .language-make}

We can re-run Make to see that everything still works:

~~~
$ make clean
$ make dats
$ make results.txt
~~~
{: .language-bash}

We have separated the configuration of our Makefile from its rules,
the parts that do all the work. If we want to change our script name
or how it is executed we just need to edit our configuration file, not
our source code in `Makefile`. Decoupling code from configuration in
this way is good programming practice, as it promotes more modular,
flexible and reusable code.

> ## Where We Are
>
> [This Makefile]({{ page.root }}/code/06-variables/Makefile)
> and [its accompanying `config.mk`]({{ page.root }}/code/06-variables/config.mk)
> contain all of our work so far.
{: .callout}
