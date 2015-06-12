---
layout: page
title: Automation and Make
subtitle: Pattern rules
minutes: TBC
---

> ## Learning Objectives {.objectives}
>
> * Write Make pattern rules.
> * Use the Make wild-card `%` in targets and dependencies.

Our Makefile still has repeated content. The rules for each `.dat` file are identical apart from the text and data file names. We can replace these rules with a single *pattern rule*.

~~~ {.make}
%.dat : books/%.txt wordcount.py
        python wordcount.py books/%.txt %.dat
~~~

`%` is a Make *wild-card*.

However, if we remove `isles.dat` and try to recreate it:

~~~ {.bash}
$ rm isles.dat
$ make isles.dat
~~~

We get:

~~~ {.output}
$ make last.dat
python wordcount.py books/%.txt %.dat
Traceback (most recent call last):
  File "wordcount.py", line 126, in <module>
    word_count(input_file, output_file, min_length)
  File "wordcount.py", line 113, in word_count
    lines = load_text(input_file)
  File "wordcount.py", line 14, in load_text
    with open(file) as f:
IOError: [Errno 2] No such file or directory: 'books/%.txt'
make: *** [last.dat] Error 1
~~~

This does **not** work. 

We can use `-n` to see what make would do - the actions it will run - without it actually running them:

~~~ {.bash}
$ touch books/last.txt
$ make -n last.dat
~~~

We get:

~~~ {.output}
python wordcount.py books/%.txt %.dat
~~~

It is treating `%.dat` as an actual file name in the action. The Make `%` wild-card can only be used in a target and in its dependencies. It cannot be used in actions.

We need to rewrite the action and, for that, we will need the Make automatic variable, `$@` (the target of the current rule). We will also need `$<`, which means 'the first dependency of the current rule'.

> ## Write an action for a pattern rule {.challenge}
>
> Rewrite the action of the `%.dat` rule, using automatic variables `$@` and `$<`, so that the pattern rule works.
