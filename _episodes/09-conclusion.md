---
title: "Conclusion"
teaching: 15
exercises: 15
questions:
- "What are the advantages and disadvantages of using tools like Make?"
objectives:
- "Understand advantages of automated build tools such as Make."
keypoints:
- "Makefiles save time by automating repetitive work, and save thinking by documenting how to reproduce results."
---

Automated build tools such as Make can help us in a number of
ways. They help us to automate repetitive commands and, so, save us
time and reduce the risk of us making errors we might make if running
these commands manually.

They can also save time by ensuring that automatically-generated
artifacts (such as data files or plots) are only recreated when the
files that were used to create these have changed in some way.

Through their notion of targets, dependencies and actions they serve
as a form of documentation, recording dependencies between code,
scripts, tools, configurations, raw data, derived data, plots and
papers.

> ## Creating PNGs
>
> Add new rules, update existing rules, and add new macros to:
>
> * Create `.png` files from `.dat` files using `plotcount.py`.
> * Add the `zip_test.py` script as dependency of the `results.txt` file
> * Remove all auto-generated files (`.dat`, `.png`,
>   `results.txt`).
>
> Finally, many Makefiles define a default [phony
> target]({{ page.root }}/reference/#phony-target) called `all` as first target,
> that will build what the Makefile has been written to build (e.g. in
> our case, the `.png` files and the `results.txt` file). As others
> may assume your Makefile confirms to convention and supports an
> `all` target, add an `all` target to your Makefile (Hint: this rule
> has the `results.txt` file and the `.png` files as dependencies, but
> no actions).  With that in place, instead of running `make
> results.txt`, you should now run `make all`, or just simply
> `make`. By default, `make` runs the first target it finds in the
> Makefile, in this case your new `all` target.
>
> > ## Solution
> > [This Makefile]({{ page.root }}/code/09-conclusion-challenge-1/Makefile)
> > and [this `config.mk`]({{ page.root }}/code/09-conclusion-challenge-1/config.mk)
> > contain a solution to this challenge.
> {: .solution}
{: .challenge}

The following figure shows the dependencies involved in building the `all` target, once we've added support for images:

![results.txt dependencies once images have been added](../fig/09-conclusion-challenge-1.png "results.txt dependencies once images have been added")

> ## Creating an Archive
>
> Add new rules, update existing rules, and add new macros to:
>
>  * Define the name of a directory, `zipf_analysis`, to hold all our
>    code, data, plots and the Zipf summary table.
> * Copy all our code, data, plots and the Zipf summary table to this
>   directory.
> * Create an archive, `zipf_analysis.tar.gz`, of this directory. The
>   bash command `tar` can be used, as follows:
>
> ~~~
> $ tar -czf zipf_analysis.tar.gz zipf_analysis
> ~~~
> {: .bash}
>
> * Update `all` to create `zipf_analysis.tar.gz`.
> * Remove `zipf_analysis` and `zipf_analysis.tar.gz` when `make
>   clean` is called.
> * Print the values of any additional variables you have defined when
>   `make variables` is called.
> > ## Solution
> > [This Makefile]({{ page.root }}/code/09-conclusion-challenge-2/Makefile)
> > and [this `config.mk`]({{ page.root }}/code/09-conclusion-challenge-2/config.mk)
> > contain a solution to this challenge.
> {: .solution}
{: .challenge}

> ## Archiving the Makefile
>
> Why do we add the Makefile to our archive of code, data, plots and Zipf summary table?
>
> > ## Solution
> > Our code (`wordcount.py`, `plotcount.py`, `zipf_test.py`) implement
> > the individual parts of our workflow. They allow us to create `.dat`
> > files from `.txt` files, `.png` files from `.dat` files and
> > `results.txt`. Our Makefile, however, documents dependencies between
> > our code, raw data, derived data, and plots, as well as implementing
> > our workflow as a whole.
> {: .solution}
{: .challenge}
