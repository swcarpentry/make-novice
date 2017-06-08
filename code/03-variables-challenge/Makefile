# Generate summary table.
results.txt : isles.dat abyss.dat last.dat
	python zipf_test.py $^ > $@

# Count words.
.PHONY : dats
dats : isles.dat abyss.dat last.dat

isles.dat : books/isles.txt
	python wordcount.py $< $@

abyss.dat : books/abyss.txt
	python wordcount.py $< $@

last.dat : books/last.txt
	python wordcount.py $< $@

.PHONY : clean
clean :
	rm -f *.dat
	rm -f results.txt
