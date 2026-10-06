# Generate summary table.
results.txt : testzipf.py isles.dat abyss.dat last.dat
	python $^ > $@

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

%.dat : countwords.py books/%.txt
	python $^ $@

.PHONY : clean
clean :
	rm -f *.dat
	rm -f results.txt
