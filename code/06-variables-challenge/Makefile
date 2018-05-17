LANGUAGE=python
COUNT_SRC=countwords.py
COUNT_EXE=$(LANGUAGE) $(COUNT_SRC)
ZIPF_SRC=testzipf.py
ZIPF_EXE=$(LANGUAGE) $(ZIPF_SRC)

# Generate summary table.
results.txt : $(ZIPF_SRC) isles.dat abyss.dat last.dat
	$(ZIPF_EXE) *.dat > $@

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

%.dat : books/%.txt $(COUNT_SRC)
	$(COUNT_EXE) $< $*.dat

.PHONY : clean
clean :
	rm -f *.dat
	rm -f results.txt
