include config.mk

TXT_FILES=$(wildcard books/*.txt)
DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))
JPG_FILES=$(patsubst books/%.txt, %.jpg, $(TXT_FILES))

# Count words.
%.dat : books/%.txt $(COUNT_SRC)
	$(COUNT_EXE) $< $*.dat

# Plot word counts.
%.jpg : %.dat $(PLOT_SRC)
	$(PLOT_EXE) $*.dat $*.jpg

.PHONY : clean
clean :
	rm -f $(DAT_FILES)
	rm -f $(JPG_FILES)
	rm -f analysis.tar.gz

.PHONY : dats
dats : $(DAT_FILES)

.PHONY : jpgs
jpgs : $(JPG_FILES)

analysis.tar.gz : $(DAT_FILES) $(JPG_FILES) $(COUNT_SRC) $(PLOT_SRC)
	tar -czf $@ $^

.PHONY : variables
variables:
	@echo TXT_FILES: $(TXT_FILES)
	@echo DAT_FILES: $(DAT_FILES)
	@echo JPG_FILES: $(JPG_FILES)
