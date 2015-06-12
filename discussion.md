---
layout: page
title: Automation and Make
subtitle: Discussion
---

## Parallel execution

Make can build dependencies in parallel sub-processes, via its `-j` flag which specifies the number of sub-processes to use e.g.

~~~ {.bash}
$ make -j 4 analysis.tar.gz
~~~

For more information see the GNU Make manual chapter on [Parallel Execution](https://www.gnu.org/software/make/manual/html_node/Parallel.html).
