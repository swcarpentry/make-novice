---
layout: page
title: Automation and Make
subtitle: Conclusion
minutes: TBC
---

Parallel jobs
-------------

Make can run on multiple cores if available:

    make -j 4 analysis.tar.gz

Conclusion
----------

See [the purpose of Make](MakePurpose.png).

Why use Make if it is so old?

* It is still very prevalent.
* It runs on Unix/Linux, Windows and Mac.
* The concepts - targets, dependencies, actions, rules - are common to
  most build tools.

Automated build scripts help us in a number of ways. They:

* Automate repetitive tasks.
* Reduce errors that we might make if typing commands manually.
* Document how software is built, data is created, graphs are plotted, papers are composed.
* Document dependencies between code, scripts, tools, inputs, configurations, outputs.

Automated scripts are code so:

* Use meaningful variable names.
* Provide comments to explain anything that is not clear.
* Separate configuration from computation via the use of configuration files.
* Keep under revision control.
