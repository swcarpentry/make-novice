---
layout: reference
root: .
---

## Running Make

To run Make:

~~~
$ make
~~~
{: .bash}

Make will look for a Makefile called `Makefile` and will build the
default target, the first target in the Makefile.

To use a Makefile with a different name, use the `-f` flag e.g.

~~~
$ make -f build-files/analyze.mk
~~~
{: .bash}

To build a specific target, provide it as an argument e.g.

~~~
$ make isles.dat
~~~
{: .bash}

If the target is up-to-date, Make will print a message like:

~~~
make: `isles.dat' is up to date.
~~~
{: .output}

To see the actions Make will run when building a target, without
running the actions, use the `--dry-run` flag e.g.

~~~
$ make --dry-run isles.dat
~~~
{: .bash}

Alternatively, use the abbreviation `-n`.

~~~
$ make -n isles.dat
~~~
{: .bash}

## Trouble Shooting

If Make prints a message like,

~~~
Makefile:3: *** missing separator.  Stop.
~~~
{: .error}

then check that all the actions are indented by TAB characters and not
spaces.

If Make prints a message like,

~~~
No such file or directory: 'books/%.txt'
make: *** [isles.dat] Error 1
~~~
{: .error}

then you may have used the Make wildcard, `%`, in an action in a
pattern rule. Make wildcards cannot be used in actions.

## Makefiles

Rules:

~~~
target : dependency1 dependency2 ...
	action1
	action2
        ...
~~~
{: .make}

* Each rule has a target, a file to be created, or built.
* Each rule has zero or more dependencies, files that are needed to
  build the target.
* `:` separates the target and the dependencies.
* Dependencies are separated by spaces.
* Each rule has zero or more actions, commands to run to build the
  target using the dependencies.
* Actions are indented using the TAB character, not 8 spaces.

Dependencies:

* If any dependency does not exist then Make will look for a rule to
  build it.
* The order of rebuilding dependencies is arbitrary. You should not
  assume that they will be built in the order in which they are listed.
* Dependencies must form a directed acyclic graph. A target cannot
  depend on a dependency which, in turn depends upon, or has a
  dependency which depends upon, that target.

Comments:

~~~
# This is a Make comment.
~~~
{: .make}

Line continuation character:

~~~
ARCHIVE = isles.dat isles.png \
          abyss.dat abyss.png \
          sierra.dat sierra.png
~~~
{: .make}

* If a list of dependencies or an action is too long, a Makefile can
  become more difficult to read.
* Backslash,`\`, the line continuation character, allows you to split
  up a list of dependencies or an action over multiple lines, to make
  them easier to read.
* Make will combine the multiple lines into a single list of dependencies
  or action.

Phony targets:

~~~
.PHONY : clean
clean :
       rm -f *.dat
~~~
{: .make}

* Phony targets are a short-hand for sequences of actions.
* No file with the target name is built when a rule with a phony
  target is run.

Automatic variables:

* `$<` denotes 'the first dependency of the current rule'.
* `$@` denotes 'the target of the current rule'.
* `$^` denotes 'the dependencies of the current rule'.
* `$*` denotes 'the stem with which the pattern of the current rule matched'.

Pattern rules:

~~~
%.dat : books/%.txt $(COUNT_SRC)
        $(COUNT_EXE) $< $@
~~~
{: .make}

* The Make wildcard, `%`, specifies a pattern.
* If Make finds a dependency matching the pattern, then the pattern is
  substituted into the target.
* The Make wildcard can only be used in targets and dependencies.
* e.g. if Make found a file called `books/abyss.txt`, it would set the
  target to be `abyss.dat`.

Defining and using variables:

~~~
COUNT_SRC=wordcount.py
COUNT_EXE=python $(COUNT_SRC)
~~~
{: .make}

* A variable is assigned a value. For example, `COUNT_SRC`
  is assigned the value `wordcount.py`.
* `$(...)` is a reference to a variable. It requests that
  Make substitutes the name of a variable for its value.

Suppress printing of actions:

~~~
.PHONY : variables
variables:
        @echo TXT_FILES: $(TXT_FILES)
~~~
{: .make}

* Prefix an action by `@` to instruct Make not to print that action.

Include the contents of a Makefile in another Makefile:

~~~
include config.mk
~~~
{: .make}

wildcard function:

~~~
TXT_FILES=$(wildcard books/*.txt)
~~~
{: .make}

* Looks for all files matching a pattern e.g. `books/*.txt`, and
  return these in a list.
* e.g. `TXT_FILES` is set to `books/abyss.txt books/isles.txt
  books/last.txt books/sierra.txt`.

patsubst ('path substitution') function:

~~~
DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))
~~~
{: .make}

* Every string that matches `books/%.txt` in `$(TXT_FILES)` is
  replaced by `%.dat` and the strings are returned in a list.
* e.g. if `TXT_FILES` is `books/abyss.txt books/isles.txt
  books/last.txt books/sierra.txt` this sets `DAT_FILES` to `abyss.dat
  isles.dat last.dat sierra.dat`.

Default targets:

* In Make version 3.79 the default target is the first target in the
  Makefile.
* In Make 3.81, the default target can be explicitly set using the
  special variable `.DEFAULT_GOAL` e.g.

~~~
.DEFAULT_GOAL := all
~~~
{: .make}

## Manuals

[GNU Make Manual][gnu-make-manual]. Reference sections include:

* [Summary of Options][options-summary] for the `make` command.
* [Quick Reference][quick-reference] of Make directives, text manipulation functions, and special variables.
* [Automatic Variables][automatic-variables].
* [Special Built-in Target Names][special-targets]

## Glossary

{:auto_ids}
action
:   The steps a [build manager](#build-manager) must take to create or
    update a file or other object.

assignment
:   A request that [Make](#make) stores something in a
    [variable](#variable).

automatic variable
:   A variable whose value is automatically redefined for each
    [rule](#rule). [Make](#make)'s automatic variables include `$@`,
    which holds the rule's [target](#target), `$^`, which holds its
    [dependencies](#dependency), and, `$<`, which holds the first of
    its dependencies, and `$*`, which holds the [stem](#stem) with which
    the pattern was matched. Automatic variables are typically used in
    [pattern rules](#pattern-rule).

build file
:   A description of [dependencies](#dependency) and [rules](#rule)
    for a [build manager](#build-manager).

build manager
:   A program, such as [Make](#make), whose main purpose is to build or
    update software, documentation, web sites, data files, images, and
    other things.

default rule
:   The [rule](#rule) that is executed if no [target](#target) is
    specified when a [build manager](#build-manager) is run.

default target
:   The [target](#target) of the [default rule](#default-rule).

dependency
:   A file that a [target](#target) depends on. If any of a target's
    [dependencies](#dependency) are newer than the target itself, the
    target needs to be updated. A target's dependencies are also
    called its prerequisites. If a target's dependencies do not exist,
    then they need to be built first.

false dependency
:   This can refer to a [dependency](#dependency) that is artificial.
    e.g. a false dependency is introduced if a data analysis script
    is added as a dependency to the data files that the script
    analyses.

function
:   A built-in [Make](#make) utility that performs some operation, for
    example gets a list of files matching a pattern.

incremental build
:   The feature of a [build manager](#build-manager) by
    which it only rebuilds files that, either directory
    or indirectly, depend on a file that was changed.

macro
:   Used as a synonym for [variable](#variable) in certain versions of
    [Make](#make).

Make
:   A popular [build manager](#build-manager), from GNU, created in 1977.

Makefile
:   A [build file](#build-file) used by [Make](#make), which, by
    default, are named `Makefile`.

pattern rule
:   A [rule](#rule) that specifies a general way to build or update an
    entire class of files that can be managed the same way. For
    example, a pattern rule can specify how to compile any C file
    rather than a single, specific C file, or, to analyze any data
    file rather than a single, specific data file. Pattern rules
    typically make use of [automatic variables](#automatic-variable)
    and [wildcards](#wildcard).

phony target
:   A [target](#target) that does not correspond to a file or other
    object. Phony targets are usually symbolic names for sequences of
    [actions](#action).

prerequisite
:   A synonym for [dependency](#dependency).

reference
:   A request that [Make](#make) substitutes the name of a
    [variable](#variable) for its value.

rule
:   A specification of a [target](#target)'s
    [dependencies](#dependency) and what [actions](#action) need to be
    executed to build or update the target.

stem
:   The part of the target that was matched by the pattern rule. If
    the target is `file.dat` and the target pattern was `%.dat`, then
    the stem `$*` is `file`.

target
:   A thing to be created or updated, for example a file. Targets can
    have [dependencies](#dependency) that must exist, and be
    up-to-date, before the target itself can be built or updated.

variable
:   A symbolic name for something in a [Makefile](#makefile).

wildcard
:   A pattern that can be specified in [dependencies](#dependency) and
    [targets](#target). If [Make](#make) finds a dependency] matching
    the pattern, then the pattern is substituted into the
    target. wildcards are often used in [pattern
    rules](#pattern-rule). The Make wildcard is `%`.

[automatic-variables]: https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html
[gnu-make-manual]: https://www.gnu.org/software/make/manual/
[options-summary]: https://www.gnu.org/software/make/manual/html_node/Options-Summary.html
[quick-reference]: https://www.gnu.org/software/make/manual/html_node/Quick-Reference.html
[special-targets]: https://www.gnu.org/software/make/manual/html_node/Special-Targets.html
