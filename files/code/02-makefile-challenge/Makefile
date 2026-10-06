# Generate summary table.
results.txt : isles.dat abyss.dat last.dat
	python testzipf.py abyss.dat isles.dat last.dat > results.txt

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

isles.dat : books/isles.txt
	python countwords.py books/isles.txt isles.dat

abyss.dat : books/abyss.txt
	python countwords.py books/abyss.txt abyss.dat

last.dat : books/last.txt
	python countwords.py books/last.txt last.dat

.PHONY : clean
clean :
	rm -f *.dat
	rm -f results.txt
