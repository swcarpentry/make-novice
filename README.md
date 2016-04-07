# make-novice

> Please see 
> [https://github.com/swcarpentry/lesson-example](https://github.com/swcarpentry/lesson-example)
> for instructions on formatting, building, and submitting lessons,
> or run `make` in this directory for a list of helpful commands.

## A note on Makefile dependency images

Some of these pages use images of Makefile dependencies, in the [img](./img) directory.

These are created using [makefile2graph](https://github.com/lindenb/makefile2graph), which is assumed to be in the `PATH`. This tool, in turn, needs the `dot` tool, part of [GraphViz](http://www.graphviz.org/).

To install GraphViz on Scientific Linux 6:

```
$ sudo yum install graphviz
$ dot -V
dot - graphviz version 2.26.0 (20091210.2329)
```

To install GraphViz on Ubuntu 14.04.3 and 15.10:

```
$ sudo apt-get install graphviz
$ dot -V
dot - graphviz version 2.38.0 (20140413.2041)
```

To download and build makefile2graph on Linux:

```
$ cd
$ git clone https://github.com/lindenb/makefile2graph
$ cd makefile2graph/
$ make
$ export PATH=~/makefile2graph/:$PATH
$ cd
$ which makefile2graph
/home/ubuntu/makefile2graph//makefile2graph
```

To create the image files for the lesson:

```
$ cd make-novice
$ make imgs
```

See [Makefile](./Makefile)'s `imgs` target.
