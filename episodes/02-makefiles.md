---
title: "Makefiles"
teaching: 30
exercises: 10
questions:
- "How do I write a simple Makefile?"
objectives:
- "Recognize the key parts of a Makefile, rules, targets, dependencies and actions."
- "Write a simple Makefile."
- "Run Make from the shell."
- "Explain when and why to mark targets as `.PHONY`."
- "Explain constraints on dependencies."
keypoints:
- "Use `#` for comments in Makefiles."
- "Write rules as `target: dependencies`."
- "Specify update actions in a tab-indented block under the rule."
- "Use `.PHONY` to mark targets that don't correspond to files."
---

Create a file, called `Makefile`, with the following content:

~~~
# Count words.
isles.dat : books/isles.txt
	python countwords.py books/isles.txt isles.dat
~~~
{: .make}

This is a [build file]({{ page.root }}/reference#build-file), which for
Make is called a [Makefile]({{ page.root }}/reference#makefile) - a file executed
by Make. Note how it resembles one of the lines from our shell script.

Let us go through each line in turn:

* `#` denotes a *comment*. Any text from `#` to the end of the line is
  ignored by Make.
* `isles.dat` is a [target]({{ page.root }}/reference#target), a file to be
  created, or built.
* `books/isles.txt` is a [dependency]({{ page.root }}/reference#dependency), a
  file that is needed to build or update the target. Targets can have
  zero or more dependencies.
* A colon, `:`, separates targets from dependencies.
* `python countwords.py books/isles.txt isles.dat` is an
  [action]({{ page.root }}/reference#action), a command to run to build or update
  the target using the dependencies. Targets can have zero or more
  actions. These actions form a recipe to build the target
  from its dependencies and can be considered to be
  a shell script.
* Actions are indented using a single TAB character, *not* 8 spaces. This
  is a legacy of Make's 1970's origins. If the difference between
  spaces and a TAB character isn’t obvious in your editor, try moving
  your cursor from one side of the TAB to the other. It should jump
  four or more spaces.
* Together, the target, dependencies, and actions form a
  [rule]({{ page.root }}/reference#rule).

Our rule above describes how to build the target `isles.dat` using the
action `python countwords.py` and the dependency `books/isles.txt`.

Information that was implicit in our shell script - that we are
generating a file called `isles.dat` and that creating this file
requires `books/isles.txt` - is now made explicit by Make's syntax.

Let's first ensure we start from scratch and delete the `.dat` and `.png`
files we created earlier:

~~~
$ rm *.dat *.png
~~~
{: .bash}

By default, Make looks for a Makefile, called `Makefile`, and we can
run Make as follows:

~~~
$ make
~~~
{: .bash}

By default, Make prints out the actions it executes:

~~~
python countwords.py books/isles.txt isles.dat
~~~
{: .output}

If we see,

~~~
Makefile:3: *** missing separator.  Stop.
~~~
{: .error}

then we have used a space instead of a TAB characters to indent one of
our actions.

Let's see if we got what we expected.

~~~
head -5 isles.dat
~~~
{: .bash}

The first 5 lines of `isles.dat` should look exactly like before.

> ## Makefiles Do Not Have to be Called `Makefile`
>
> We don't have to call our Makefile `Makefile`. However, if we call it
> something else we need to tell Make where to find it. This we can do
> using `-f` flag. For example, if our Makefile is named `MyOtherMakefile`:
>
> ~~~
> $ make -f MyOtherMakefile
> ~~~
> {: .bash}
>
>
> Sometimes, the suffix `.mk` will be used to identify Makefiles that
> are not called `Makefile` e.g. `install.mk`, `common.mk` etc.
{: .callout}

When we re-run our Makefile, Make now informs us that:

~~~
make: `isles.dat' is up to date.
~~~
{: .output}

This is because our target, `isles.dat`, has now been created, and
Make will not create it again. To see how this works, let's pretend to
update one of the text files. Rather than opening the file in an
editor, we can use the shell `touch` command to update its timestamp
(which would happen if we did edit the file):

~~~
$ touch books/isles.txt
~~~
{: .bash}

If we compare the timestamps of `books/isles.txt` and `isles.dat`,

~~~
$ ls -l books/isles.txt isles.dat
~~~
{: .bash}

then we see that `isles.dat`, the target, is now older
than`books/isles.txt`, its dependency:

~~~
-rw-r--r--    1 mjj      Administ   323972 Jun 12 10:35 books/isles.txt
-rw-r--r--    1 mjj      Administ   182273 Jun 12 09:58 isles.dat
~~~
{: .output}

If we run Make again,

~~~
$ make
~~~
{: .bash}

then it recreates `isles.dat`:

~~~
python countwords.py books/isles.txt isles.dat
~~~
{: .output}

When it is asked to build a target, Make checks the 'last modification
time' of both the target and its dependencies. If any dependency has
been updated since the target, then the actions are re-run to update
the target. Using this approach, Make knows to only rebuild the files
that, either directly or indirectly, depend on the file that
changed. This is called an [incremental
build]({{ page.root }}/reference#incremental-build).

> ## Makefiles as Documentation
>
> By explicitly recording the inputs to and outputs from steps in our
> analysis and the dependencies between files, Makefiles act as a type
> of documentation, reducing the number of things we have to remember.
{: .callout}

Let's add another rule to the end of `Makefile`:

~~~
abyss.dat : books/abyss.txt
	python countwords.py books/abyss.txt abyss.dat
~~~
{: .make}

If we run Make,

~~~
$ make
~~~
{: .bash}

then we get:

~~~
make: `isles.dat' is up to date.
~~~
{: .output}

Nothing happens because Make attempts to build the first target it
finds in the Makefile, the [default
target]({{ page.root }}/reference#default-target), which is `isles.dat` which is
already up-to-date. We need to explicitly tell Make we want to build
`abyss.dat`:

~~~
$ make abyss.dat
~~~
{: .bash}

Now, we get:

~~~
python countwords.py books/abyss.txt abyss.dat
~~~
{: .output}

> ## "Up to Date" Versus "Nothing to be Done"
>
> If we ask Make to build a file that already exists and is up to
> date, then Make informs us that:
>
> ~~~
> make: `isles.dat' is up to date.
> ~~~
> {: .output}
>
> If we ask Make to build a file that exists but for which there is
> no rule in our Makefile, then we get message like:
>
> ~~~
> $ make countwords.py
> ~~~
> {: .bash}
>
> ~~~
> make: Nothing to be done for `countwords.py'.
> ~~~
> {: .output}
>
> `up to date` means that the Makefile has a rule with one or more actions
> whose target is the name of a file (or directory) and the file is up to date.
>
> `Nothing to be done` means that
> the file exists but either :
> - the Makefile has no rule for it, or
> - the Makefile has a rule for it, but that rule has no actions
{: .callout}


We may want to remove all our data files so we can explicitly recreate
them all. We can introduce a new target, and associated rule, to do
this. We will call it `clean`, as this is a common name for rules that
delete auto-generated files, like our `.dat` files:

~~~
clean :
	rm -f *.dat
~~~
{: .make}

This is an example of a rule that has no dependencies. `clean` has no
dependencies on any `.dat` file as it makes no sense to create these
just to remove them. We just want to remove the data files whether or
not they exist. If we run Make and specify this target,

~~~
$ make clean
~~~
{: .bash}

then we get:

~~~
rm -f *.dat
~~~
{: .output}

There is no actual thing built called `clean`. Rather, it is a
short-hand that we can use to execute a useful sequence of
actions. Such targets, though very useful, can lead to problems. For
example, let us recreate our data files, create a directory called
`clean`, then run Make:

~~~
$ make isles.dat abyss.dat
$ mkdir clean
$ make clean
~~~
{: .bash}

We get:

~~~
make: `clean' is up to date.
~~~
{: .output}

Make finds a file (or directory) called `clean` and, as its `clean`
rule has no dependencies, assumes that `clean` has been built and is
up-to-date and so does not execute the rule's actions. As we are using
`clean` as a short-hand, we need to tell Make to always execute this
rule if we run `make clean`, by telling Make that this is a
[phony target]({{ page.root }}/reference#phony-target), that it does not build
anything. This we do by marking the target as `.PHONY`:

~~~
.PHONY : clean
clean :
        rm -f *.dat
~~~
{: .make}

If we run Make,

~~~
$ make clean
~~~
{: .bash}

then we get:

~~~
rm -f *.dat
~~~
{: .output}

We can add a similar command to create all the data files. We can put
this at the top of our Makefile so that it is the [default
target]({{ page.root }}/reference#default-target), which is executed by default
if no target is given to the `make` command:

~~~
.PHONY : dats
dats : isles.dat abyss.dat
~~~
{: .make}

This is an example of a rule that has dependencies that are targets of
other rules. When Make runs, it will check to see if the dependencies
exist and, if not, will see if rules are available that will create
these. If such rules exist it will invoke these first, otherwise
Make will raise an error.

> ## Dependencies
>
> The order of rebuilding dependencies is arbitrary. You should not
> assume that they will be built in the order in which they are
> listed.
>
> Dependencies must form a directed acyclic graph. A target cannot
> depend on a dependency which itself, or one of its dependencies,
> depends on that target.
{: .callout}

This rule is also an example of a rule that has no actions. It is used
purely to trigger the build of its dependencies, if needed.

If we run,

~~~
$ make dats
~~~
{: .bash}

then Make creates the data files:

~~~
python countwords.py books/isles.txt isles.dat
python countwords.py books/abyss.txt abyss.dat
~~~
{: .output}

If we run `dats` again, then Make will see that the dependencies (isles.dat
and abyss.dat) are already up to date. 
Given the target `dats` has no actions, there is `nothing to be done`:
~~~
$ make dats
~~~
{: .bash}

~~~
make: Nothing to be done for `dats'.
~~~
{: .output}


Our Makefile now looks like this:

~~~
# Count words.
.PHONY : dats
dats : isles.dat abyss.dat

isles.dat : books/isles.txt
	python countwords.py books/isles.txt isles.dat

abyss.dat : books/abyss.txt
	python countwords.py books/abyss.txt abyss.dat

.PHONY : clean
clean :
	rm -f *.dat
~~~
{: .make}

The following figure shows a graph of the dependencies embodied within
our Makefile, involved in building the `dats` target:

![Dependencies represented within the Makefile](../fig/02-makefile.png "Dependencies represented within the Makefile")

> ## Write Two New Rules
>
> 1. Write a new rule for `last.dat`, created from `books/last.txt`.
> 2. Update the `dats` rule with this target.
> 3. Write a new rule for `results.txt`, which creates the summary
>    table. The rule needs to:
>    * Depend upon each of the three `.dat` files.
>    * Invoke the action `python testzipf.py abyss.dat isles.dat last.dat > results.txt`.
> 4. Put this rule at the top of the Makefile so that it is the default target.
> 5. Update `clean` so that it removes `results.txt`.
>
> The starting Makefile is [here]({{ page.root }}/code/02-makefile/Makefile).
>
> > ## Solution
> > See [this file]({{ page.root }}/code/02-makefile-challenge/Makefile) for a solution.
> {: .solution}
{: .challenge}

The following figure shows the dependencies embodied within our
Makefile, involved in building the `results.txt` target:

![results.txt dependencies represented within the Makefile](../fig/02-makefile-challenge.png "results.txt dependencies represented within the Makefile")
