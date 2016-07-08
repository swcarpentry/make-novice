# Generate summary table.
results.txt : *.dat zipf_test.py
	python zipf_test.py *.dat > $@

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

%.dat : books/%.txt wordcount.py
	python wordcount.py $< $*.dat

.PHONY : clean
clean :
	rm -f *.dat
	rm -f results.txt
