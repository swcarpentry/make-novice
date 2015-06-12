# Count words.
isles.dat : books/isles.txt wordcount.py
	python wordcount.py books/isles.txt isles.dat

abyss.dat : books/abyss.txt wordcount.py
	python wordcount.py books/abyss.txt abyss.dat

last.dat : books/last.txt wordcount.py
	python wordcount.py books/last.txt last.dat

.PHONY : clean
clean :
	rm -f *.dat
	rm -f analysis.tar.gz

.PHONY : dats
dats : isles.dat abyss.dat last.dat

analysis.tar.gz : *.dat wordcount.py
	tar -czf $@ $^
