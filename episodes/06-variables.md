---
title: Variables
teaching: 15
exercises: 5
---

::::::::::::::::::::::::::::::::::::::: objectives

- Use variables in a Makefile.
- Explain the benefits of decoupling configuration from computation.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How can I eliminate redundancy in my Makefiles?

::::::::::::::::::::::::::::::::::::::::::::::::::

Despite our efforts, our Makefile still has repeated content, i.e.
the name of our script -- `countwords.py`, and the program we use to run it --
`python`. If we renamed our script we'd have to update our Makefile in multiple
places.

We can introduce a Make [variable](../learners/reference.md#variable) (called a
[macro](../learners/reference.md#macro) in some versions of Make) to hold our
script name:

```make
COUNT_SRC=countwords.py
```

This is a variable [assignment](../learners/reference.md#assignment) -
`COUNT_SRC` is assigned the value `countwords.py`.

We can do the same thing with the interpreter language used to run the script:

```make
LANGUAGE=python
```

`$(...)` tells Make to replace a variable with its value when Make
is run. This is a variable [reference](../learners/reference.md#reference). At
any place where we want to use the value of a variable we have to
write it, or reference it, in this way.

Here we reference the variables `LANGUAGE` and `COUNT_SRC`. This tells Make to
replace the variable `LANGUAGE` with its value `python`,
and to replace the variable `COUNT_SRC` with its value `countwords.py`.

Defining the variable `LANGUAGE` in this way avoids repeating `python` in our
Makefile, and allows us to easily
change how our script is run (e.g. we might want to use a different
version of Python and need to change `python` to `python2` -- or we might want
to rewrite the script using another language (e.g. switch from Python to R)).

:::::::::::::::::::::::::::::::::::::::  challenge

## Use Variables

Update `Makefile` so that the `%.dat` rule
references the variable `COUNT_SRC`.
Then do the same for the `testzipf.py` script
and the `results.txt` rule,
using `ZIPF_SRC` as the variable name.

:::::::::::::::  solution

## Solution

[This Makefile](files/code/06-variables-challenge/Makefile)
contains a solution to this challenge.



:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

We place variables at the top of a Makefile so they are easy to
find and modify. Alternatively, we can pull them out into a new
file that just holds variable definitions (i.e. delete them from
the original Makefile). Let us create `config.mk`:

```make
# Count words script.
LANGUAGE=python
COUNT_SRC=countwords.py

# Test Zipf's rule
ZIPF_SRC=testzipf.py
```

We can then import `config.mk` into `Makefile` using:

```make
include config.mk
```

We can re-run Make to see that everything still works:

```bash
$ make clean
$ make dats
$ make results.txt
```

We have separated the configuration of our Makefile from its rules --
the parts that do all the work. If we want to change our script name
or how it is executed we just need to edit our configuration file, not
our source code in `Makefile`. Decoupling code from configuration in
this way is good programming practice, as it promotes more modular,
flexible and reusable code.

:::::::::::::::::::::::::::::::::::::::::  callout

## Where We Are

[This Makefile](files/code/06-variables/Makefile)
and [its accompanying `config.mk`](files/code/06-variables/config.mk)
contain all of our work so far.


::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: keypoints

- Define variables by assigning values to names.
- Reference variables using `$(...)`.

::::::::::::::::::::::::::::::::::::::::::::::::::


