---
title: "Dependencies on Data and Code"
teaching: 15
exercises: 15
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
results.txt : *.dat
        python zipf_test.py $^ > $@

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

isles.dat : books/isles.txt
        python wordcount.py $< $@

abyss.dat : books/abyss.txt
        python wordcount.py $< $@

last.dat : books/last.txt
        python wordcount.py $< $@

.PHONY : clean
clean :
        rm -f *.dat
        rm -f results.txt
~~~
{: .make}

Our data files are a product not only of our text files but the
script, `wordcount.py`, that processes the text files and creates the
data files. A change to `wordcount.py` (e.g. to add a new column of
summary data or remove an existing one) results in changes to the
`.dat` files it outputs. So, let's pretend to edit `wordcount.py`,
using `touch`, and re-run Make:

~~~
$ make dats
$ touch wordcount.py
$ make dats
~~~
{: .bash}

Nothing happens! Though we've updated `wordcount.py` our data files
are not updated because our rules for creating `.dat` files don't
record any dependencies on `wordcount.py`.

We need to add `wordcount.py` as a dependency of each of our
data files also:

~~~
isles.dat : books/isles.txt wordcount.py
        python wordcount.py $< $@

abyss.dat : books/abyss.txt wordcount.py
        python wordcount.py $< $@

last.dat : books/last.txt wordcount.py
        python wordcount.py $< $@
~~~
{: .make}

If we pretend to edit `wordcount.py` and re-run Make,

~~~
$ touch wordcount.py
$ make dats
~~~
{: .bash}

then we get:

~~~
python wordcount.py books/isles.txt isles.dat
python wordcount.py books/abyss.txt abyss.dat
python wordcount.py books/last.txt last.dat
~~~
{: .output}

Similarly, we should add the `zipf_test.py` script as dependency to the rule for `results.txt`:

~~~
# Generate summary table.
results.txt : *.dat zipf_test.py
        python zipf_test.py $^ > $@
~~~
{: .make}

> ## Dry run
>
> `make` can show the commands it will execute without actually running them if we pass the `-n` flag:
>
> ~~~
> $ touch wordcount.py
> $ make -n dats
> ~~~
> {: .bash}
>
> This gives the same output to the screen as without the `-n` flag, but the commands are not actually run. Using this 'dry-run' mode is a good way to check that you have set up your Makefile properly before actually running the commands in it.
>
{: .callout}

The following figure shows the dependencies embodied within our
Makefile, involved in building the `results.txt` target, after adding
`wordcount.py` and `zipf_test.py` as dependencies to their respective target files:

![results.txt dependencies after adding wordcount.py and zipf_test.py as dependencies](../fig/04-dependencies.png "results.txt dependencies after adding wordcount.py and zipf_test.py as dependencies")

> ## Why Don't the `.txt` Files Depend on `wordcount.py`?
>
> `.txt` files are input files and have no dependencies. To make these
> depend on `wordcount.py` would introduce a [false
> dependency]({{ page.root }}/reference/#false-dependency).
{: .callout}

Intuitively, we should also add `wordcount.py` as dependency for
`results.txt`, as the final table should be rebuilt as we remake the
`.dat` files. However, it turns out we don't have to! Let's see what
happens to `results.txt` when we update `wordcount.py`:

~~~
$ touch wordcount.py
$ make results.txt
~~~
{: .bash}

then we get:

~~~
python wordcount.py books/abyss.txt abyss.dat
python wordcount.py books/isles.txt isles.dat
python wordcount.py books/last.txt last.dat
python zipf_test.py abyss.dat isles.dat last.dat > results.txt
~~~
{: .output}

The whole pipeline is triggered, even the creation of the
`results.txt` file! To understand this, note that according to the
dependency figure, `results.txt` depends on the `.dat` files. The
update of `wordcount.py` triggers an update of the `*.dat`
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
> {: .bash}
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

> ## `wordcount` as a Dependency of `results.txt`.
>
> What would happen if you actually added `wordcount.py` as dependency of `results.txt`, and why?
>
> > ## Solution
> >
> > If you change the rule for the `results.txt` file like this:
> >
> > ~~~
> > results.txt : *.dat wordcount.py
> >         python zipf_test.py $^ > $@
> > ~~~
> > {: .make}
> >
> > `wordcount.py` becomes a part of `$^`, thus the command becomes
> >
> > ~~~
> > python zipf_test.py abyss.dat isles.dat last.dat wordcount.py > results.txt
> > ~~~
> > {: .bash}
> >
> > This results in an error from `zipf_test.py` as it tries to parse the
> > script as if it were a `.dat` file. Try this by running:
> >
> > ~~~
> > $ make results.txt
> > ~~~
> > {: .bash}
> >
> > You'll get
> >
> > ~~~
> > python zipf_test.py abyss.dat isles.dat last.dat wordcount.py > results.txt
> > Traceback (most recent call last):
> >   File "zipf_test.py", line 19, in <module>
> >     counts = load_word_counts(input_file)
> >   File "path/to/wordcount.py", line 39, in load_word_counts
> >     counts.append((fields[0], int(fields[1]), float(fields[2])))
> > IndexError: list index out of range
> > make: *** [results.txt] Error 1
> > ~~~
> > {: .error}
> {: .solution}
{: .challenge}

We still have to add the `zipf-test.py` script as dependency to
`results.txt`. Given the answer to the challenge above, we cannot use
`$^` for the rule. We'll go back to using `*.dat`:

~~~
results.txt : *.dat zipf_test.py
        python zipf_test.py *.dat > $@
~~~
{: .make}

> ## Where We Are
>
> [This Makefile]({{ page.root }}/code/04-dependencies/Makefile)
> contains everything done so far in this topic.
{: .callout}
