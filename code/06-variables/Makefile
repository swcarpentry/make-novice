include config.mk

# Generate summary table.
results.txt : *.dat $(ZIPF_SRC)
	$(ZIPF_EXE) $< > $@

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

%.dat : books/%.txt $(COUNT_SRC)
	$(COUNT_EXE) $< $*.dat

.PHONY : clean
clean :
	rm -f *.dat
	rm -f results.txt
