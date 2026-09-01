#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt
import sys
try:
    from collections.abc import Sequence
except ImportError:
    from collections import Sequence

from countwords import load_word_counts


def plot_word_counts(counts, limit=10):
    """
    Given a list of (word, count, percentage) tuples, plot the counts as a
    histogram. Only the first limit tuples are plotted.
    """
    limited_counts = counts[0:limit]
    word_data = [word for (word, _, _) in limited_counts]
    count_data = [count for (_, count, _) in limited_counts]
    position = np.arange(len(word_data))
    width = 1.0
    ax = plt.axes()
    ax.set_xticks(position)
    ax.set_xticklabels(word_data)
    plt.bar(position, count_data, width, color='b')
    plt.title("Word Counts")
    ax.set_ylabel("Counts")
    ax.set_xlabel("Word")
    try:
       plt.margins(x=0)
    except ValueError:
       return


def typeset_labels(labels=None, gap=5):
    """
    Given a list of labels, create a new list of labels such that each label
    is right-padded by spaces so that every label has the same width, then
    is further right padded by ' ' * gap.
    """
    if not isinstance(labels, Sequence):
        labels = list(range(labels))
    labels = [str(i) for i in labels]
    label_lens = [len(s) for s in labels]
    label_width = max(label_lens)
    output = []
    for label in labels:
        label_string = label + ' ' * (label_width - len(label)) + (' ' * gap)
        output.append(label_string)
    assert len(set(len(s) for s in output)) == 1  # Check all have same length.
    return output


def get_ascii_bars(values, truncate=True, maxlen=10, symbol='#'):
    """
    Given a list of values, create a list of strings of symbols, where each
    strings contains N symbols where N = ()(value / minimum) /
    (maximum - minimum)) * (maxlen / len(symbol)).
    """
    maximum = max(values)
    if truncate:
        minimum = min(values) - 1
    else:
        minimum = 0
    
    # Type conversion to floats is required for compatibility with python 2,
    # because it doesn't do integer division correctly (it does floor divison
    # for integers).
    value_range=float(maximum - minimum)
    prop_values = [(float(value - minimum) / value_range) for value in values]
    
    # Type conversion to int required for compatibility with python 2
    biggest_bar = symbol * int(round(maxlen / len(symbol)))
    bars = [biggest_bar[:int(round(prop * len(biggest_bar)))]
            for prop in prop_values]
    
    return bars


def plot_ascii_bars(values, labels=None, screenwidth=80, gap=2, truncate=True):
    """
    Given a list of values and labels, create right-padded labels for each
    label and strings of symbols representing the associated values.
    """
    if not labels:
        try:
            values, labels = list(zip(*values))
        except TypeError:
            labels = len(values)
    labels = typeset_labels(labels=labels, gap=gap)
    bars = get_ascii_bars(values, maxlen=screenwidth - gap - len(labels[0]),
                          truncate=truncate)
    return [s + b for s, b in zip(labels, bars)]


if __name__ == '__main__':
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    limit = 10
    if len(sys.argv) > 3:
        limit = int(sys.argv[3])
    counts = load_word_counts(input_file)
    plot_word_counts(counts, limit)
    if output_file == "show":
        plt.show()
    elif output_file == 'ascii':
        words, counts, _ = list(zip(*counts))
        for line in plot_ascii_bars(counts[:limit], words[:limit],
                                    truncate=False):
            print(line)
    else:
        plt.savefig(output_file)
