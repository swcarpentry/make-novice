Automation and Make
===================

Question: what are the problems with this?

    cc -o scheduler main.o schedule.o optimise.o io.o utils.o -I./include -L./lib -lm -lblas -llapack -lrng

Answer: we need to

* Type a lot.
* Remember syntax, flags, inputs, libraries, dependencies.
* Ensure .o files have been created.

Automation allows us to:

* "write once, run many" instead of typing the same commands over and over. 
* Document syntax, flags, inputs, libraries, dependencies.
* Recreate files (e.g. binaries, output data, graphs) only when needed.
  - Input files => process => output files.
  - Source code => compiler => library or executable.
  - Configuration and data files => analysis program => data files.
  - Data files => visualisation program => images.

Make:

* A widely-used, fast, free, well-documented, build tool.
* Developed by Stuart Feldman:
  - Bell Labs summer intern, 1977.
  - Vice President of Computer Science at IBM Research and Google ACM
    Software System Award winner, 2003. 

Other build tools:

* Apache ANT designed for Java.
* Python doit.
* CMake and Autoconf/Automake generate platform-dependent build
  scripts e.g. Make, Visual Studio project files etc. 

Which is best?

* Depends on your requirements, intended usage, operating system etc.

Data processing pipeline
------------------------

Suppose we have scripts that implement a workflow to:

* Read data files e.g. a text file.
* Perform an analysis e.g. count the number of occurrences of each
  word in the file. 
* Write the results to a file e.g. a file with each word and its
  number of occurrences. 
* Plot the data e.g. a graph of the most frequently occurring words.
* Save the graph as an image e.g. a PDF or a JPG.

Count words in a text file:

    python wordcount.py books/isles.txt isles.dat
    head isles.dat
    python wordcount.py books/abyss.txt abyss.dat
    head abyss.dat

Count words in a text file, whose length is >= 12 characters:

    python wordcount.py books/isles.txt isles.dat 12
    head isles.dat

Plot top 10 most frequently occuring words:

    python plotcount.py isles.dat show
    python plotcount.py abyss.dat show

Aside: note how the most frequent word occurs approximately twice as often as the second most frequent word - this is [Zipf's Law](http://en.wikipedia.org/wiki/Zipf%27s_law).

Plot top 5 most frequently occuring words:

    python plotcount.py isles.dat show 5
    python plotcount.py abyss.dat show 5

Plot top 5 most frequently occuring words and save as a JPG:

    python plotcount.py isles.dat isles.jpg 5

    python wordcount.py books/isles.txt isles.dat
    head isles.dat

Let's pretend we update one of the input files. We can use `touch` to update its timestamp:

    touch books/isles.txt
    ls -l books/isles.txt isles.dat

Output file `isles.dat` is now older than input `books/isles.txt`, so we need to recreate it.

Question: we could write a shell script but what might be the problems?

Answer: if we have many source files to compile or data files to analyse, we don't want to recreate everything, just those outputs that depend on the changed files.

We'll use make!
