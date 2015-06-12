---
layout: page
title: Automation and Make
subtitle: Makefiles
minutes: TBC
---

> ## Learning Objectives {.objectives}
>
> * Recognise the key parts of a Makefile, rules, targets, dependencies and actions.
> * Write a simple Makefile.
> * Run Make from the shell.
> * Know when and why to mark targets as .PHONY.

Create a file, called `Makefile`, with the following content:

~~~ {.make}
# Count words.
isles.dat : books/isles.txt
        python wordcount.py books/isles.txt isles.dat
~~~

This is a simple *Makefile* - a file executed by Make. Let us go through each line in turn:

* `#` denotes a *comment*. Any text from `#` to the end of the line is ignored by Make.
* `isles.dat` is a *target*, a file to be created, or built.
* `books/isles.dat` is a *dependency*, a file that is needed to build the target. Targets can have zero or more dependencies.
* `:` separates targets from dependencies.
* `python wordcount.py books/isles.txt isles.dat` is an *action*, a command to run to build the target using the dependencies. Targets can have zero or more actions.
* Actions are indented using the TAB character, *not* 8 spaces. This is a legacy of Make's 1970's origins.
* Together, the target, prerequisites, and actions form a *rule*.

By default, Make looks for a Makefile, called `Makefile`, and we can run Make as follows:

~~~ {.bash}
$ make
~~~

Make prints out the actions it executes:

~~~ {.output}
python wordcount.py books/isles.txt isles.dat
~~~

If you see:

~~~ {.error}
Makefile:3: *** missing separator.  Stop.
~~~

Then you have used spaces instead of a TAB to indent your actions.

We don't have to call our Makefile `Makefile`. However, if we call it something else we need to tell Make where to find it. This we can do using `-f` flag. For example:

~~~ {.bash}
$ make -f Makefile
~~~

As we have rerun our Makefile, Make now informs us that:

~~~ {.output}
make: `isles.dat' is up to date.
~~~

This is because our target, `isles.dat`, has now been created, and Make will not create it again. To see how this works, let's pretend to update one of the text files. Rather than opening the file in an editor, we can use the shell `touch` command to update its timestamp (which would happen if we did edit the file):

~~~ {.bash}
$ touch books/isles.txt
~~~

If we compare the timestamps of `isles.txt` and `isles.dat`,

~~~ {.bash}
$ ls -l books/isles.txt isles.dat
~~~

we see that `isles.dat`, the target, is now older than`books/isles.txt`, its dependency:

~~~ {.output}
-rw-r--r--    1 mjj      Administ   323972 Jun 12 10:35 books/isles.txt
-rw-r--r--    1 mjj      Administ   182273 Jun 12 09:58 isles.dat
~~~

If we run Make again:

~~~ {.bash}
$ make
~~~

It recreates `isles.dat`.

~~~ {.output}
python wordcount.py books/isles.txt isles.dat
~~~

When it is asked to build a target, Make checks the 'last modification time' of both the target and its dependencies. If any dependency has been updated since the target, then the actions are re-run to update the target.

Let's add another rule to the end of `Makefile`:

~~~ {.make}
abyss.dat : books/abyss.txt
        python wordcount.py books/abyss.txt abyss.dat
~~~

And, run Make:

~~~ {.bash}
$ make
~~~

We get:

~~~ {.output}
make: `isles.dat' is up to date.
~~~

Nothing happens because Make attempts to rebuild the first, default, target in the Makefile, which is `isles.dat` which is already up-to-date. We need to explicitly tell Make we want to build `abyss.dat`:

~~~ {.bash}
$ make abyss.dat
~~~

We get:

~~~ {.output}
python wordcount.py books/abyss.txt abyss.dat
~~~

We may want to remove all our data files so we can explicitly recreate them all. We can introduce a new target, and associated rule, `clean`:

~~~ {.make}
clean : 
        rm -f *.dat
~~~

This is an example of a rule that has no dependencies. `clean` has no dependencies on any `.dat` file as it makes no sense to create these just to remove them. We just want to remove the data files whether or not they exist. If we run this target:

~~~ {.bash}
$ make clean
~~~

We get:

~~~ {.output}
rm -f *.dat
~~~

There is no actual thing built called `clean`. Rather, it is a short-hand that we can use to execute a useful sequence of actions. Such targets, though very useful, can lead to problems. For example, let us recreate our data files, create a directory called `clean`, then run Make:

~~~ {.bash}
$ make isles.txt abyss.dat
$ mkdir clean
$ make clean
~~~

We get:

~~~ {.outputs}
make: `clean' is up to date.
~~~

Make finds a file (or directory) called `clean` and, as its `clean` rule has no dependencies, assumes that `clean` has been built and is up-to-date and so does not execute its actions. As we are using `clean` as a short-hand, we need to tell Make to always execute its rule, by marking the target as `.PHONY`:

~~~ {.make}
.PHONY : clean
clean : 
        rm -f *.dat
~~~

If we run Make:

~~~ {.bash}
$ make clean
~~~

We get:

~~~ {.outputs}
rm -f *.dat
~~~

We can add a similar command to create all the data files:

~~~ {.make}
.PHONY : dats
dats : isles.dat abyss.dat
~~~

This is an example of a rule that has dependencies that are targets of other rules. When Make runs, it will check to see if the dependencies exist and, if not, will see if rules are available that will create these. If such rules exist it will invoke these first. 

> ## Dependencies {.callout}
>
> The order of rebuilding dependencies is arbitrary. You should not assume that they will be built in the order in which they are listed.
>
> Dependencies must form a directed acyclic graph. A target cannot depend on a dependency which itself, or one of its dependencies, depends on that target.

This rule is also an example of a rule that has no actions. It is used purely to trigger the build of its dependencies, if needed.

If we run:

~~~ {.bash}
$ make dats
~~~

Make creates the data files:

~~~ {.output}
python wordcount.py books/isles.txt isles.dat
python wordcount.py books/abyss.txt abyss.dat
~~~

If we run `dats` again:

~~~ {.bash}
$ make dats
~~~

Make sees that the data files exist:

~~~ {.output}
make: Nothing to be done for `dats'.
~~~

> ## Write two new rules {.challenge}
>
> Write a new rule for `last.dat`, created from `books/last.txt`.
>
> Update the `dats` rule with this target.
>
> Write a new rule for `analysis.tar.gz`, which creates an archive of the data files. The rule needs to:
> 
> * Depend upon each of the three `.dat` files.
> * Invokes the action `tar -czf analysis.tar.gz isles.dat abyss.dat last.dat`
>
> Update `clean` to remove `analysis.tar.gz`.
