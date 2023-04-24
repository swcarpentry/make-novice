include config.mk

TXT_FILES=$(wildcard books/*.txt)
DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))

# Generate summary table.
results.txt : $(ZIPF_SRC) $(DAT_FILES)
	$(LANGUAGE) $^ > $@

# Count words.
.PHONY : dats
dats : $(DAT_FILES)

%.dat : $(COUNT_SRC) books/%.txt
	$(LANGUAGE) $^ $@

.PHONY : clean
clean :
	rm -f $(DAT_FILES)
	rm -f results.txt

.PHONY : variables
variables:
	@echo TXT_FILES: $(TXT_FILES)
	@echo DAT_FILES: $(DAT_FILES)
