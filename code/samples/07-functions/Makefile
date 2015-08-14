include config.mk

TXT_FILES=$(wildcard books/*.txt)
DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))

# Count words.
%.dat : books/%.txt $(COUNT_SRC)
	$(COUNT_EXE) $< $*.dat

.PHONY : clean
clean :
	rm -f $(DAT_FILES)
	rm -f analysis.tar.gz

.PHONY : dats
dats : $(DAT_FILES)

analysis.tar.gz : $(DAT_FILES) $(COUNT_SRC)
	tar -czf $@ $^

.PHONY : variables
variables:
	@echo TXT_FILES: $(TXT_FILES)
	@echo DAT_FILES: $(DAT_FILES)
