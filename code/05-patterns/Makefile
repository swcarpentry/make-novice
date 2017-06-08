# Generate summary table.
results.txt : zipf_test.py isles.dat abyss.dat last.dat
	python $< *.dat > $@

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

%.dat : books/%.txt wordcount.py
	python wordcount.py $< $*.dat

.PHONY : clean
clean :
	rm -f *.dat
	rm -f results.txt
