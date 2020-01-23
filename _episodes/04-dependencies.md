---
title: "Dependencies on Data and Code"
teaching: 15
exercises: 5
questions:
- "How can I write a Makefile to update things when my scripts have changed rather than my input files?"
objectives:
- "Output files are a product not only of input files but of the scripts or code that created the output files."
- "Recognize and avoid false dependencies."
keypoints:
- "Make results depend on processing scripts as well as data files."
- "Dependencies are transitive: if A depends on B and B depends on C, a change to C will indirectly trigger an update to A."
---

Our Makefile now looks like this:

~~~
# Generate summary table.
results.txt : isles.dat abyss.dat last.dat
	python testzipf.py $^ > $@

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

isles.dat : books/isles.txt
	python countwords.py $< $@

abyss.dat : books/abyss.txt
	python countwords.py $< $@

last.dat : books/last.txt
	python countwords.py $< $@

.PHONY : clean
clean :
	rm -f *.dat
	rm -f results.txt
~~~
{: .language-make}

Our data files are a product not only of our text files but the
script, `countwords.py`, that processes the text files and creates the
data files. A change to `countwords.py` (e.g. to add a new column of
summary data or remove an existing one) results in changes to the
`.dat` files it outputs. So, let's pretend to edit `countwords.py`,
using `touch`, and re-run Make:

~~~
$ make dats
$ touch countwords.py
$ make dats
~~~
{: .language-bash}

Nothing happens! Though we've updated `countwords.py` our data files
are not updated because our rules for creating `.dat` files don't
record any dependencies on `countwords.py`.

We need to add `countwords.py` as a dependency of each of our
data files also:

~~~
isles.dat : books/isles.txt countwords.py
	python countwords.py $< $@

abyss.dat : books/abyss.txt countwords.py
	python countwords.py $< $@

last.dat : books/last.txt countwords.py
	python countwords.py $< $@
~~~
{: .language-make}

If we pretend to edit `countwords.py` and re-run Make,

~~~
$ touch countwords.py
$ make dats
~~~
{: .language-bash}

then we get:

~~~
python countwords.py books/isles.txt isles.dat
python countwords.py books/abyss.txt abyss.dat
python countwords.py books/last.txt last.dat
~~~
{: .output}

> ## Dry run
>
> `make` can show the commands it will execute without actually running them if we pass the `-n` flag:
>
> ~~~
> $ touch countwords.py
> $ make -n dats
> ~~~
> {: .language-bash}
>
> This gives the same output to the screen as without the `-n` flag, but the commands are not actually run. Using this 'dry-run' mode is a good way to check that you have set up your Makefile properly before actually running the commands in it.
>
{: .callout}

The following figure shows the dependencies embodied within our
Makefile, involved in building the `results.txt` target, after adding
`countwords.py` and `testzipf.py` as dependencies to their respective target
files (i.e. how the Makefile should look after completing the rest of the
exercises in this episode).

![results.txt dependencies after adding countwords.py and testzipf.py as dependencies](../fig/04-dependencies.png "results.txt dependencies after adding countwords.py and testzipf.py as dependencies")

> ## Why Don't the `.txt` Files Depend on `countwords.py`?
>
> `.txt` files are input files and have no dependencies. To make these
> depend on `countwords.py` would introduce a [false
> dependency]({{ page.root }}/reference#false-dependency).
{: .callout}

Intuitively, we should also add `countwords.py` as dependency for
`results.txt`, as the final table should be rebuilt as we remake the
`.dat` files. However, it turns out we don't have to! Let's see what
happens to `results.txt` when we update `countwords.py`:

~~~
$ touch countwords.py
$ make results.txt
~~~
{: .language-bash}

then we get:

~~~
python countwords.py books/abyss.txt abyss.dat
python countwords.py books/isles.txt isles.dat
python countwords.py books/last.txt last.dat
python testzipf.py abyss.dat isles.dat last.dat > results.txt
~~~
{: .output}

The whole pipeline is triggered, even the creation of the
`results.txt` file! To understand this, note that according to the
dependency figure, `results.txt` depends on the `.dat` files. The
update of `countwords.py` triggers an update of the `*.dat`
files. Thus, `make` sees that the dependencies (the `.dat` files) are
newer than the target file (`results.txt`) and thus it recreates
`results.txt`. This is an example of the power of `make`: updating a
subset of the files in the pipeline triggers rerunning the appropriate
downstream steps.

> ## Updating One Input File
>
> What will happen if you now execute:
>
> ~~~
> $ touch books/last.txt
> $ make results.txt
> ~~~
> {: .language-bash}
>
> 1. only `last.dat` is recreated
> 2. all `.dat` files are recreated
> 3. only `last.dat` and `results.txt` are recreated
> 4. all `.dat` and `results.txt` are recreated
>
> > ## Solution
> > `3.` only `last.dat` and `results.txt` are recreated.
> >
> > Follow the dependency tree to understand the answer(s).
> {: .solution}
{: .challenge}

> ## `testzipf.py` as a Dependency of `results.txt`.
>
> What would happen if you added `testzipf.py` as dependency of `results.txt`, and why?
>
> > ## Solution
> >
> > If you change the rule for the `results.txt` file like this:
> >
> > ~~~
> > results.txt : isles.dat abyss.dat last.dat testzipf.py
> >         python testzipf.py $^ > $@
> > ~~~
> > {: .language-make}
> >
> > `testzipf.py` becomes a part of `$^`, thus the command becomes
> >
> > ~~~
> > python testzipf.py abyss.dat isles.dat last.dat testzipf.py > results.txt
> > ~~~
> > {: .language-bash}
> >
> > This results in an error from `testzipf.py` as it tries to parse the
> > script as if it were a `.dat` file. Try this by running:
> >
> > ~~~
> > $ make results.txt
> > ~~~
> > {: .language-bash}
> >
> > You'll get
> >
> > ~~~
> > python testzipf.py abyss.dat isles.dat last.dat testzipf.py > results.txt
> > Traceback (most recent call last):
> >   File "testzipf.py", line 19, in <module>
> >     counts = load_word_counts(input_file)
> >   File "path/to/testzipf.py", line 39, in load_word_counts
> >     counts.append((fields[0], int(fields[1]), float(fields[2])))
> > IndexError: list index out of range
> > make: *** [results.txt] Error 1
> > ~~~
> > {: .error}
> {: .solution}
{: .challenge}

We still have to add the `testzipf.py` script as dependency to
`results.txt`. Given the answer to the challenge above, we cannot use
`$^` in the rule.  
We can however move `testzipf.py` to be the
first dependency and then use `$<` to refer to it. 
In order to refer to the `.dat` files, we can just use `*.dat` for now (we will
cover a better solution later on).

~~~
results.txt : testzipf.py isles.dat abyss.dat last.dat
	python $< *.dat > $@
~~~
{: .language-make}

> ## Where We Are
>
> [This Makefile]({{ page.root }}/code/04-dependencies/Makefile)
> contains everything done so far in this topic.
{: .callout}
