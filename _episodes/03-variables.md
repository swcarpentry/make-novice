---
title: "Automatic Variables"
teaching: 10
exercises: 5
questions:
- "How can I abbreviate the rules in my Makefiles?"
objectives:
- "Use Make automatic variables to remove duplication in a Makefile."
- "Explain why shell wildcards in dependencies can cause problems."
keypoints:
- "Use `$@` to refer to the target of the current rule."
- "Use `$^` to refer to the dependencies of the current rule."
- "Use `$<` to refer to the first dependency of the current rule."
---

After the exercise at the end of the previous episode, our Makefile looked like
this:

~~~
# Generate summary table.
results.txt : isles.dat abyss.dat last.dat
	python testzipf.py abyss.dat isles.dat last.dat > results.txt

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

isles.dat : books/isles.txt
	python countwords.py books/isles.txt isles.dat

abyss.dat : books/abyss.txt
	python countwords.py books/abyss.txt abyss.dat

last.dat : books/last.txt
	python countwords.py books/last.txt last.dat

.PHONY : clean
clean :
	rm -f *.dat
	rm -f results.txt
~~~
{: .language-make}

Our Makefile has a lot of duplication. For example, the names of text
files and data files are repeated in many places throughout the
Makefile. Makefiles are a form of code and, in any code, repeated code
can lead to problems e.g. we rename a data file in one part of the
Makefile but forget to rename it elsewhere.

> ## D.R.Y. (Don't Repeat Yourself)
>
> In many programming languages, the bulk of the language features are
> there to allow the programmer to describe long-winded computational
> routines as short, expressive, beautiful code.  Features in Python
> or R or Java, such as user-defined variables and functions are useful in
> part because they mean we don't have to write out (or think about)
> all of the details over and over again.  This good habit of writing
> things out only once is known as the "Don't Repeat Yourself"
> principle or D.R.Y.
{: .callout}

Let us set about removing some of the repetition from our Makefile.

In our `results.txt` rule we duplicate the data file names and the
name of the results file name:

~~~
results.txt : isles.dat abyss.dat last.dat
	python testzipf.py abyss.dat isles.dat last.dat > results.txt
~~~
{: .language-make}

Looking at the results file name first, we can replace it in the action
with `$@`:

~~~
results.txt : isles.dat abyss.dat last.dat
	python testzipf.py abyss.dat isles.dat last.dat > $@
~~~
{: .language-make}

`$@` is a Make
[automatic variable]({{ page.root }}/reference.html#automatic-variable)
which means 'the target of the current rule'. When Make is run it will
replace this variable with the target name.

We can replace the dependencies in the action with `$^`:

~~~
results.txt : isles.dat abyss.dat last.dat
	python testzipf.py $^ > $@
~~~
{: .language-make}

`$^` is another automatic variable which means 'all the dependencies
of the current rule'. Again, when Make is run it will replace this
variable with the dependencies.

Let's update our text files and re-run our rule:

~~~
$ touch books/*.txt
$ make results.txt
~~~
{: .language-bash}

We get:

~~~
python countwords.py books/isles.txt isles.dat
python countwords.py books/abyss.txt abyss.dat
python countwords.py books/last.txt last.dat
python testzipf.py isles.dat abyss.dat last.dat > results.txt
~~~
{: .output}


> ## Update Dependencies
>
> What will happen if you now execute:
>
> ~~~
> $ touch *.dat
> $ make results.txt
> ~~~
> {: .language-bash}
>
> 1. nothing
> 2. all files recreated
> 3. only `.dat` files recreated
> 4. only `results.txt` recreated
>
> > ## Solution
> > `4.` Only `results.txt` recreated.
> >
> > The rules for `*.dat` are not executed because their corresponding `.txt` files
> > haven't been modified.
> >
> > If you run:
> >
> > ~~~
> > $ touch books/*.txt
> > $ make results.txt
> > ~~~
> > {: .language-bash}
> >
> > you will find that the `.dat` files as well as `results.txt` are recreated.
> {: .solution}
{: .challenge}

As we saw, `$^` means 'all the dependencies of the current rule'. This
works well for `results.txt` as its action treats all the dependencies
the same - as the input for the `testzipf.py` script.

However, for some rules, we may want to treat the first dependency
differently. For example, our rules for `.dat` use their first (and
only) dependency specifically as the input file to `countwords.py`. If
we add additional dependencies (as we will soon do) then we don't want
these being passed as input files to `countwords.py` as it expects only
one input file to be named when it is invoked.

Make provides an automatic variable for this, `$<` which means 'the
first dependency of the current rule'.

> ## Rewrite `.dat` Rules to Use Automatic Variables
>
> Rewrite each `.dat` rule to use the automatic variables `$@` ('the
> target of the current rule') and `$<` ('the first dependency of the
> current rule').
> [This file]({{ page.root }}/code/03-variables/Makefile) contains
> the Makefile immediately before the challenge.
>
> > ## Solution
> > See [this file]({{ page.root }}/code/03-variables-challenge/Makefile)
> > for a solution to this challenge.
> {: .solution}
{: .challenge}
