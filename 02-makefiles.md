---
layout: page
title: Automation and Make
subtitle: Makefiles
minutes: 0
---

> ## Learning Objectives {.objectives}
>
> * Recognise the key parts of a Makefile, rules, targets,
>   dependencies and actions. 
> * Write a simple Makefile.
> * Run Make from the shell.
> * Explain when and why to mark targets as `.PHONY`.
> * Explain constraints on dependencies.

Create a file, called `Makefile`, with the following content:

~~~ {.make}
# Count words.
isles.dat : books/isles.txt
        python wordcount.py books/isles.txt isles.dat
~~~

This is a simple [build file](reference.html#build-file), which for
Make is called a [Makefile](reference.html#makefile) - a file executed
by Make. Let us go through each line in turn:

* `#` denotes a *comment*. Any text from `#` to the end of the line is
  ignored by Make.
* `isles.dat` is a [target](reference.html#target), a file to be
  created, or built.
* `books/isles.txt` is a [dependency](reference.html#dependency), a
  file that is needed to build or update the target. Targets can have
  zero or more dependencies.
* `:` separates targets from dependencies.
* `python wordcount.py books/isles.txt isles.dat` is an
  [action](reference.html#action), a command to run to build or update
  the target using the dependencies. Targets can have zero or more
  actions.
* Actions are indented using the TAB character, *not* 8 spaces. This
  is a legacy of Make's 1970's origins.
* Together, the target, dependencies, and actions form a
  [rule](reference.html#rule). 

Our rule above describes how to build the target `isles.dat` using the
action `python wordcount.py` and the dependency `books/isles.txt`.

Let's first sure we start from scratch and delete the `.dat` and `.jpg`
files we created:

~~~ {.bash}
$ rm *.dat *.jpg
~~~

By default, Make looks for a Makefile, called `Makefile`, and we can
run Make as follows:

~~~ {.bash}
$ make
~~~

Make prints out the actions it executes:

~~~ {.output}
python wordcount.py books/isles.txt isles.dat
~~~

If we see,

~~~ {.error}
Makefile:3: *** missing separator.  Stop.
~~~

then we have used a space instead of a TAB characters to indent one of
our actions.

We don't have to call our Makefile `Makefile`. However, if we call it
something else we need to tell Make where to find it. This we can do
using `-f` flag. For example:

~~~ {.bash}
$ make -f Makefile
~~~

As we have re-run our Makefile, Make now informs us that:

~~~ {.output}
make: `isles.dat' is up to date.
~~~

This is because our target, `isles.dat`, has now been created, and
Make will not create it again. To see how this works, let's pretend to
update one of the text files. Rather than opening the file in an
editor, we can use the shell `touch` command to update its timestamp
(which would happen if we did edit the file):

~~~ {.bash}
$ touch books/isles.txt
~~~

If we compare the timestamps of `books/isles.txt` and `isles.dat`,

~~~ {.bash}
$ ls -l books/isles.txt isles.dat
~~~

then we see that `isles.dat`, the target, is now older
than`books/isles.txt`, its dependency:

~~~ {.output}
-rw-r--r--    1 mjj      Administ   323972 Jun 12 10:35 books/isles.txt
-rw-r--r--    1 mjj      Administ   182273 Jun 12 09:58 isles.dat
~~~

If we run Make again,

~~~ {.bash}
$ make
~~~

then it recreates `isles.dat`:

~~~ {.output}
python wordcount.py books/isles.txt isles.dat
~~~

When it is asked to build a target, Make checks the 'last modification
time' of both the target and its dependencies. If any dependency has
been updated since the target, then the actions are re-run to update
the target.

Let's add another rule to the end of `Makefile`:

~~~ {.make}
abyss.dat : books/abyss.txt
        python wordcount.py books/abyss.txt abyss.dat
~~~

If we run Make,

~~~ {.bash}
$ make
~~~

then we get:

~~~ {.output}
make: `isles.dat' is up to date.
~~~

Nothing happens because Make attempts to build the first target it
finds in the Makefile, the [default
target](reference.html#default-target), which is `isles.dat` which is
already up-to-date. We need to explicitly tell Make we want to build
`abyss.dat`: 

~~~ {.bash}
$ make abyss.dat
~~~

Now, we get:

~~~ {.output}
python wordcount.py books/abyss.txt abyss.dat
~~~

We may want to remove all our data files so we can explicitly recreate
them all. We can introduce a new target, and associated rule, `clean`:

~~~ {.make}
clean : 
        rm -f *.dat
~~~

This is an example of a rule that has no dependencies. `clean` has no
dependencies on any `.dat` file as it makes no sense to create these
just to remove them. We just want to remove the data files whether or
not they exist. If we run Make and specify this target,

~~~ {.bash}
$ make clean
~~~

then we get:

~~~ {.output}
rm -f *.dat
~~~

There is no actual thing built called `clean`. Rather, it is a
short-hand that we can use to execute a useful sequence of
actions. Such targets, though very useful, can lead to problems. For
example, let us recreate our data files, create a directory called
`clean`, then run Make:

~~~ {.bash}
$ make isles.dat abyss.dat
$ mkdir clean
$ make clean
~~~

We get:

~~~ {.outputs}
make: `clean' is up to date.
~~~

Make finds a file (or directory) called `clean` and, as its `clean`
rule has no dependencies, assumes that `clean` has been built and is
up-to-date and so does not execute the rule's actions. As we are using
`clean` as a short-hand, we need to tell Make to always execute this
rule if we run `make clean`, by telling Make that this is a
[phony target](#reference.html#phony-target), that it does not build
anything. This we do by marking the target as `.PHONY`:

~~~ {.make}
.PHONY : clean
clean : 
        rm -f *.dat
~~~

If we run Make,

~~~ {.bash}
$ make clean
~~~

then we get:

~~~ {.outputs}
rm -f *.dat
~~~

We can add a similar command to create all the data files:

~~~ {.make}
.PHONY : dats
dats : isles.dat abyss.dat
~~~

This is an example of a rule that has dependencies that are targets of
other rules. When Make runs, it will check to see if the dependencies
exist and, if not, will see if rules are available that will create
these. If such rules exist it will invoke these first, otherwise
Make will raise an error.

> ## Dependencies {.callout}
>
> The order of rebuilding dependencies is arbitrary. You should not
> assume that they will be built in the order in which they are
> listed.  
>
> Dependencies must form a directed acyclic graph. A target cannot
> depend on a dependency which itself, or one of its dependencies,
> depends on that target. 

This rule is also an example of a rule that has no actions. It is used
purely to trigger the build of its dependencies, if needed.

If we run,

~~~ {.bash}
$ make dats
~~~

then Make creates the data files:

~~~ {.output}
python wordcount.py books/isles.txt isles.dat
python wordcount.py books/abyss.txt abyss.dat
~~~

If we run `dats` again,

~~~ {.bash}
$ make dats
~~~

then Make sees that the data files exist:

~~~ {.output}
make: Nothing to be done for `dats'.
~~~

Our Makefile now looks like this:

~~~ {.make}
# Count words.
.PHONY : dats
dats : isles.dat abyss.dat

isles.dat : books/isles.txt
        python wordcount.py books/isles.txt isles.dat

abyss.dat : books/abyss.txt
        python wordcount.py books/abyss.txt abyss.dat

.PHONY : clean
clean :
        rm -f *.dat
~~~



> ## Write two new rules {.challenge}
>
> Write a new rule for `last.dat`, created from `books/last.txt`.
>
> Update the `dats` rule with this target.
>
> Write a new rule for `analysis.tar.gz`, which creates an archive of
> the data files. The rule needs to: 
> 
> * Depend upon each of the three `.dat` files.
> * Invoke the action `tar -czf analysis.tar.gz isles.dat abyss.dat
>   last.dat` 
>
> Update `clean` to remove `analysis.tar.gz`.
