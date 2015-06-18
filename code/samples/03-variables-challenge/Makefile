# Count words.
isles.dat : books/isles.txt
	python wordcount.py $< $@

abyss.dat : books/abyss.txt
	python wordcount.py $< $@

last.dat : books/last.txt
	python wordcount.py $< $@

.PHONY : clean
clean :
	rm -f *.dat
	rm -f analysis.tar.gz

.PHONY : dats
dats : isles.dat abyss.dat last.dat

analysis.tar.gz : *.dat
	tar -czf $@ $^
