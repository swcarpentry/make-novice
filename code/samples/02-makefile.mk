# Count words.
isles.dat : books/isles.txt
	python wordcount.py books/isles.txt isles.dat

abyss.dat : books/abyss.txt
	python wordcount.py books/abyss.txt abyss.dat

.PHONY : clean
clean : 
	rm -f *.dat

.PHONY : dats
dats : isles.dat abyss.dat
