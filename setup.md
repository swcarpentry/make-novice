---
layout: page
title: "Setup"
root: .
---

## Files

You need to download some files to follow this lesson:

1. Download [make-lesson.zip][zip-file].

2. Move `make-lesson.zip` into a directory which you can access via your bash shell.

3. Open a Bash shell window.

4. Navigate to the directory where you downloaded the file.

5. Unpack `make-lesson.zip`:

   ~~~
   $ unzip make-lesson.zip
   ~~~
   {: .source}

6. Change into the `make-lesson` directory:

   ~~~
   $ cd make-lesson
   ~~~
   {: .source}

## Software

You also need to have the following software installed on your computer to
follow this lesson:

### GNU Make

#### Linux

Make is a standard tool on most Linux systems and should already be available.
Check if you already have Make installed by typing `make -v` into a terminal.

One exception is Debian, and you should install Make from the terminal using
`sudo apt-get install make`.

#### OSX

You will need to have Xcode installed (download from the
[Apple website](https://developer.apple.com/xcode/)).
Check if you already have Make installed by typing `make -v` into a terminal. 

#### Windows
Use the Software Carpentry
[Windows installer](https://github.com/swcarpentry/windows-installer).

### Python

Python2 or Python3, Numpy and Matplotlib are required.
They can be installed separately, but the easiest approach is to install 
[Anaconda](https://www.anaconda.com/distribution/) which includes all of the
necessary python software.

[zip-file]: {{ page.root }}/files/make-lesson.zip
