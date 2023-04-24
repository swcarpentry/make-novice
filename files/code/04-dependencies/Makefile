# Generate summary table.
results.txt : testzipf.py isles.dat abyss.dat last.dat
	python $^ > $@

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

isles.dat : books/isles.txt countwords.py
	python countwords.py $< $@

abyss.dat : books/abyss.txt countwords.py
	python countwords.py $< $@

last.dat : books/last.txt countwords.py
	python countwords.py $< $@

.PHONY : clean
clean :
	rm -f *.dat
	rm -f results.txt
