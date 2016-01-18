include config.mk

# Generate archive file.
analysis.tar.gz : *.dat $(COUNT_SRC)
	tar -czf $@ $^

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

%.dat : books/%.txt $(COUNT_SRC)
	$(COUNT_EXE) $< $*.dat

.PHONY : clean
clean :
	rm -f *.dat
	rm -f analysis.tar.gz
