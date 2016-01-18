include config.mk

TXT_FILES=$(wildcard books/*.txt)
DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))
JPG_FILES=$(patsubst books/%.txt, %.jpg, $(TXT_FILES))

# Generate archive file.
analysis.tar.gz : $(DAT_FILES) $(JPG_FILES) $(COUNT_SRC) $(PLOT_SRC)
	tar -czf $@ $^

# Count words.
.PHONY : dats
dats : $(DAT_FILES)

%.dat : books/%.txt $(COUNT_SRC)
	$(COUNT_EXE) $< $*.dat

# Plot word counts.
.PHONY : jpgs
jpgs : $(JPG_FILES)

%.jpg : %.dat $(PLOT_SRC)
	$(PLOT_EXE) $*.dat $*.jpg

.PHONY : clean
clean :
	rm -f $(DAT_FILES)
	rm -f $(JPG_FILES)
	rm -f analysis.tar.gz

.PHONY : variables
variables:
	@echo TXT_FILES: $(TXT_FILES)
	@echo DAT_FILES: $(DAT_FILES)
	@echo JPG_FILES: $(JPG_FILES)
