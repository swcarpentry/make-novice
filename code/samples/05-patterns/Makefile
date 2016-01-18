# Generate archive file.
analysis.tar.gz : *.dat wordcount.py
	tar -czf $@ $^

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

%.dat : books/%.txt wordcount.py
	python wordcount.py $< $*.dat

.PHONY : clean
clean :
	rm -f *.dat
	rm -f analysis.tar.gz
