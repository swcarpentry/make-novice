---
layout: page
title: Automation and Make
subtitle: Reference
---

## Running Make

~~~ {.bash}
$ make
~~~

Make assumes the Makefile is called `Makefile` and runs the default target.

To use a Makefile with a different name, use `-f` e.g.

~~~ {.bash}
$ make -f analyse.mk
~~~

To build a specific target, provide it as an argument e.g.

~~~ {.make}
$ make isles.dat
~~~

To see actions Make will run when building a target, without running those actions, use `-n` e.g.

~~~ {.make}
$ make -n isles.dat
~~~

If the target is up-to-date, Make will print a message like:

~~~ {.output}
make: `isles.dat' is up to date.
~~~

If Make prints:

~~~ {.error}
Makefile:3: *** missing separator.  Stop.
~~~

then check your actions are indented by TAB characters and not spaces.

## Makefiles

Rules:

~~~ {.make}
target : dependency1 dependency2 ...
	action1
	action2
        ...
~~~

* Each rule has a target, a file to be created, or built.
* Each rule has zero or more dependencies, files that are needed to build the target.
* `:` separates targets from dependencies.
* Dependencies are separated by spaces.
* Each rule has zero or more actions, commands to run to build the target using the dependencies.
* Actions are indented using the TAB character, *not* 8 spaces.

Comments:

~~~ {.make}
# This is a comment!
~~~

Phony targets:

~~~ {.make}
.PHONY : clean
clean :
       rm -f *.dat
~~~

* Phony targets are a short-hand for sequences of actions. 
* In this example, no thing called `clean` is built.

Automatic variables:

* `$<` - the first dependency of the current rule.
* `$@` - the target of the current rule.
* `$^` - the dependencies of the current rule.

Pattern rules:

~~~ {.make}
%.dat : books/%.txt $(COUNT_SRC)
        $(COUNT_EXE) $< $@
~~~

* Pattern rules use the Make wild-card `%`.
* The wild-card can only be used in targets and dependencies.

Defining and using variables:

~~~ {.make}
COUNT_SRC=wordcount.py
COUNT_EXE=python $(COUNT_SRC)
~~~

Suppress printing of actions:

~~~ {.make}
.PHONY : variables
variables:
        @echo TXT_FILES: $(TXT_FILES)
~~~

* Prefix an action by `@` to instruct Make not to print that action.

Include the contents of a Makefile in another Makefile:

~~~ {.make}
include config.mk
~~~

wildcard function:

~~~ {.make}
TXT_FILES=$(wildcard books/*.txt)
~~~

* Looks for all files matching a pattern e.g. `books/*.txt`, and return these in a list.
* e.g. `TXT_FILES` is set to `books/abyss.txt books/isles.txt books/last.txt books/sierra.txt`.

patsubst ('path substitution') function:

~~~ {.make}
DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))
~~~

* Every string that matches `books/%.txt` in `$(TXT_FILES)` is replaced by %.dat and the strings are returned in a list.
* e.g. if `TXT_FILES` is `books/abyss.txt books/isles.txt books/last.txt books/sierra.txt` this sets `DAT_FILES` to `abyss.dat isles.dat last.dat sierra.dat`.

## Manuals

* [GNU Make Manual](https://www.gnu.org/software/make/manual/)
  - [Quick Reference](https://www.gnu.org/software/make/manual/html_node/Quick-Reference.html)
  - [Automatic Variables](https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html) - summary of automatic variables.

## Glossary

action
:   The steps a **build manager** must take to bring a file or other
    object up to date.

automatic variable
:   A variable whose value is automatically redefined for each rule.
    Automatic variables include `$@`, which holds the rule's
    **target**, `$^`, which holds its **prerequisites**, and, `$<`,
    which holds the first of its **prerequisites**.
    Automatic variables are typically used in **pattern rules**.

build file
:   A description of dependencies and rules for a **build manager**.

build manager
:   A program such as Make whose main purpose is to rebuild software,
    documentation, web sites, and other things after changes have been
    made.

default rule
:   The rule that is executed if no other rule is specified.

dependency
:   A file that some other file depends on. If any of a file's
    dependencies are newer than the file itself, the file must be
    updated. A file's dependencies are also called its
    **prerequisites**.

false dependency
:   A **dependency** used to trigger some other action.

function
:   A built-in Make utility that performs some operation, for example 
    gets a list of files matching a pattern.    

macro
:   Used as a synonym for **variable** in certain versions of Make.

Makefile
:   The default build file used by Make. The term is also used
    for any **build file** that Make understands.

pattern rule
:   A rule that specifies a general way to manage an entire class of
    files. For example, a pattern rule might specify how to compile
    any C file, rather than just a particular C file. Pattern rules
    typically make use of **automatic variables**.

phony target
:   A **target** that does not correspond to a file or other object.
    Phony targets are usually just symbolic names for sequences of
    actions.

prerequisites
:   A file that some other file depends on. If any of a file's
    prerequisites are newer than the file itself, the file must be
    updated. A file's prerequisites are also called its
    **dependencies**.

rule
:   In a build system, a specification of a **target**'s
    **prerequisites** and what **actions** to take to bring the
    target up to date.

target
:   A thing that may be created or updated. Targets typically have
    **prerequisites** that must be up to date before the target itself
    can be updated.

variable
:   A symbolic name for something in a **Makefile**.

wild-card
:   A single file name that specifies many files. For example `%.dat`
    specifies all files ending in `.dat`. Wild-cards are often used
    in **pattern rules**.
