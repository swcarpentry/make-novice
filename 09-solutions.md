---
layout: page
title: Automation and Make
subtitle: Solutions
minutes: 0
---

> ## Learning Objectives {.objectives}
>
> * To verify the solutions to the challenges presented within the lessons.


###02-makefiles
> Write two new rules

~~~ {.bash}
# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

isles.dat : books/isles.txt
    	python wordcount.py books/isles.txt isles.dat

abyss.dat : books/abyss.txt
    	python wordcount.py books/abyss.txt abyss.dat

last.dat: books/last.txt
    	python wordcount.py books/last.txt last.dat

analysis.tar.gz: isles.dat abyss.dat last.dat
    	tar -czf analysis.tar.gz isles.dat abyss.dat last.dat

.PHONY : clean
clean :
    	rm -f *.dat
    	rm -f analysis.tar.gz
~~~

###03-variables
>Update Dependencies

~~~
	ANSWER: only analysis.tar.gz recreated
~~~
> Rewrite .dat rules to use automatic variables

~~~ {.bash}
# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

isles.dat : books/isles.txt
    	python wordcount.py $< $@

abyss.dat : books/abyss.txt
    	python wordcount.py $< $@

last.dat: books/last.txt
    	python wordcount.py $< $@

analysis.tar.gz: *.dat
    	tar -czf $@ $^

.PHONY : clean
clean :
    	rm -f *.dat
    	rm -f analysis.tar.gz
~~~


###06-variables
> Use variables

~~~ {.bash}
# Count words.
COUNT_SRC=wordcount.py
COUNT_EXE=python $(COUNT_SRC)

.PHONY : dats
dats : isles.dat abyss.dat last.dat

%.dat : books/%.txt COUNT_SRC
    $(COUNT_EXE) $< $@

# Generate archive file.
analysis.tar.gz : *.dat COUNT_SRC
    tar -czf $@ $^

.PHONY : clean
clean :
        rm -f *.dat
        rm -f analysis.tar.gz
~~~