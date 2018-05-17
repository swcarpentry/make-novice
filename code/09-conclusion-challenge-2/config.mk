# Count words script.
LANGUAGE=python
COUNT_SRC=wordcount.py
COUNT_EXE=$(LANGUAGE) $(COUNT_SRC)

# Plot word counts script.
PLOT_SRC=plotcount.py
PLOT_EXE=$(LANGUAGE) $(PLOT_SRC)

# Test Zipf's rule.
ZIPF_SRC=zipf_test.py
ZIPF_EXE=$(LANGUAGE) $(ZIPF_SRC)
