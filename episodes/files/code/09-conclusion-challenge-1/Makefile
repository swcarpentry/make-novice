include config.mk

TXT_FILES=$(wildcard books/*.txt)
DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))
PNG_FILES=$(patsubst books/%.txt, %.png, $(TXT_FILES))

## all         : Generate Zipf summary table and plots of word counts.
.PHONY : all
all : results.txt $(PNG_FILES)

## results.txt : Generate Zipf summary table.
results.txt : $(ZIPF_SRC) $(DAT_FILES)
	$(LANGUAGE) $^ > $@

## dats        : Count words in text files.
.PHONY : dats
dats : $(DAT_FILES)

%.dat : $(COUNT_SRC) books/%.txt
	$(LANGUAGE) $^ $@

## pngs        : Plot word counts.
.PHONY : pngs
pngs : $(PNG_FILES)

%.png : $(PLOT_SRC) %.dat
	$(LANGUAGE) $^ $@

## clean       : Remove auto-generated files.
.PHONY : clean
clean :
	rm -f $(DAT_FILES)
	rm -f $(PNG_FILES)
	rm -f results.txt

## variables   : Print variables.
.PHONY : variables
variables:
	@echo TXT_FILES: $(TXT_FILES)
	@echo DAT_FILES: $(DAT_FILES)
	@echo PNG_FILES: $(PNG_FILES)

.PHONY : help
help : Makefile
	@sed -n 's/^##//p' $<
