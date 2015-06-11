Automatic variables
-------------------

Let's add a rule to create an archive with all the data files:

    analysis.tar.gz : isles.dat abyss.dat last.dat
            tar -czf analysis.tar.gz isles.dat abyss.dat last.dat

And, run our rule:

    make analysis.tar.gz

Makefiles are code. Repeated code can lead to maintainability problems (e.g. we fix a typo in one repeated chunk of code but forget to fix it in another). So let's rewrite the rule as:

    tar -czf $@ isles.dat abyss.dat last.dat

`$@` is a Make 'special macro' which means 'the target of the current rule'.

We still have duplication - the name of the target within the rule. So let's rewrite the rule further:

    tar -czf $@ $^

`$^` is a Make special macro which means 'all the dependencies of the current rule'.
 
Let's re-run our rule:

    rm analysis.tar.gz
    make analysis.tar.gz

We can use the bash wild-card in our dependency list:

    analysis.tar.gz : *.dat

Now, let's check it still works:

    make analysis.tar.gz
    touch *.dat
    make analysis.tar.gz

Now let's delete the data files and recreate them:

    rm *.dat
    make analysis.tar.gz

Question: any guesses as to why this now fails?

Answer: there are no files that match the pattern `*.dat` so the name `*.dat` is used as-is as a file name.

We need to explicitly recreate the .dat files:

    make dats

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
