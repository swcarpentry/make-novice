# Generate summary table.
results.txt : isles.dat abyss.dat last.dat
	python testzipf.py $^ > $@

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

isles.dat : books/isles.txt
	python countwords.py $< $@

abyss.dat : books/abyss.txt
	python countwords.py $< $@

last.dat : books/last.txt
	python countwords.py $< $@

.PHONY : clean
clean :
	rm -f *.dat
	rm -f results.txt
