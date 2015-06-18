#!/usr/bin/env python
 
import string
import sys

DELIMITERS = [".", ",", ";", ":", "?", "$", "@", "^", "<", ">", "#", "%", "`", "!", "*", "-", "=", "(", ")", "[", "]", "{", "}", "/", "\"", "\'"]

"""
Load lines from a plain-text file and return these as a list, with
trailing newlines stripped.
"""
def load_text(file):
  text = ""
  with open(file) as f:
    lines = f.read().splitlines()
  return lines

"""
Save a list of [word, count, percentage] lists to a file, in the form
"word count percentage", one tuple per line.
"""
def save_word_counts(file, counts):
  f = open(file, 'w')
  for count in counts:
    f.write("%s\n" % " ".join(map(str, count)))
  f.close()

"""
Load a list of (word, count, percentage) tuples from a file where each
line is of the form "word count percentage". Lines starting with # are
ignored.
"""
def load_word_counts(file):
  counts = []
  f = open(file, "r")
  for line in f:
    if (not line.startswith("#")):
      fields = line.split()
      counts.append((fields[0], int(fields[1]), float(fields[2])))
  f.close()
  return counts

"""
Given a string, parse the string and update a dictionary of word
counts (mapping words to counts of their frequencies). DELIMITERS are
removed before the string is parsed. The function is case-insensitive
and words in the dictionary are in lower-case.
"""
def update_word_counts(line, counts):
  for purge in DELIMITERS:
    line = line.replace(purge, " ")
  words = line.split()
  for word in words:
    word = word.lower().strip()
    if word in counts:
      counts[word] += 1
    else:
      counts[word] = 1

"""
Given a list of strings, parse each string and create a dictionary of
word counts (mapping words to counts of their frequencies). DELIMITERS
are removed before the string is parsed. The function is
case-insensitive and words in the dictionary are in lower-case.
"""
def calculate_word_counts(lines):
  counts = {}
  for line in lines:
    update_word_counts(line, counts)
  return counts

"""
Given a dictionary of word counts (mapping words to counts of their
frequencies), convert this into an ordered list of tuples (word,
count). The list is ordered by decreasing count, unless increase is
True.
"""
def word_count_dict_to_tuples(counts, decrease = True):
  return sorted(counts.iteritems(), key=lambda (key,value): value, \
    reverse = decrease)

"""
Given a list of (word, count) tuples, create a new list with only
those tuples whose word is >= min_length.
"""
def filter_word_counts(counts, min_length = 1):
  stripped = []
  for (word, count) in counts:
    if (len(word) >= min_length):
      stripped.append((word, count))
  return stripped

"""
Given a list of (word, count) tuples, create a new list (word, count,
percentage) where percentage is the percentage number of occurrences
of this word compared to the total number of words.
"""
def calculate_percentages(counts):
  total = 0
  for count in counts:
    total += count[1]
  tuples = [(word, count, (float(count) / total) * 100.0) 
    for (word, count) in counts]
  return tuples

"""
Load a file, calculate the frequencies of each word in the file and
save in a new file the words, counts and percentages of the total  in
descending order. Only words whose length is >= min_length are
included.
"""
def word_count(input_file, output_file, min_length = 1):
  lines = load_text(input_file)
  counts = calculate_word_counts(lines)
  sorted_counts = word_count_dict_to_tuples(counts)
  sorted_counts = filter_word_counts(sorted_counts, min_length)
  percentage_counts = calculate_percentages(sorted_counts)
  save_word_counts(output_file, percentage_counts)

if  __name__ =='__main__':
  input_file = sys.argv[1]
  output_file = sys.argv[2]
  min_length = 1
  if (len(sys.argv) > 3):
    min_length = int(sys.argv[3])
  word_count(input_file, output_file, min_length)
