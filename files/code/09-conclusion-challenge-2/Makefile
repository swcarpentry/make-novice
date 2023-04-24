include config.mk

TXT_DIR=books
TXT_FILES=$(wildcard $(TXT_DIR)/*.txt)
DAT_FILES=$(patsubst $(TXT_DIR)/%.txt, %.dat, $(TXT_FILES))
PNG_FILES=$(patsubst $(TXT_DIR)/%.txt, %.png, $(TXT_FILES))
RESULTS_FILE=results.txt
ZIPF_DIR=zipf_analysis
ZIPF_ARCHIVE=$(ZIPF_DIR).tar.gz

## all         : Generate archive of code, data, plots, summary table, Makefile, and config.mk.
.PHONY : all
all : $(ZIPF_ARCHIVE)

$(ZIPF_ARCHIVE) : $(ZIPF_DIR)
	tar -czf $@ $<

$(ZIPF_DIR): Makefile config.mk $(RESULTS_FILE) \
             $(DAT_FILES) $(PNG_FILES) $(TXT_DIR) \
             $(COUNT_SRC) $(PLOT_SRC) $(ZIPF_SRC)
	mkdir -p $@
	cp -r $^ $@
	touch $@

## results.txt : Generate Zipf summary table.
$(RESULTS_FILE) : $(ZIPF_SRC) $(DAT_FILES)
	$(LANGUAGE) $^ > $@

## dats        : Count words in text files.
.PHONY : dats
dats : $(DAT_FILES)

%.dat : $(COUNT_SRC) $(TXT_DIR)/%.txt
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
	rm -f $(RESULTS_FILE)
	rm -rf $(ZIPF_DIR)
	rm -f $(ZIPF_ARCHIVE)

## variables   : Print variables.
.PHONY : variables
variables:
	@echo TXT_DIR: $(TXT_DIR)
	@echo TXT_FILES: $(TXT_FILES)
	@echo DAT_FILES: $(DAT_FILES)
	@echo PNG_FILES: $(PNG_FILES)
	@echo ZIPF_DIR: $(ZIPF_DIR)
	@echo ZIPF_ARCHIVE: $(ZIPF_ARCHIVE)

.PHONY : help
help : Makefile
	@sed -n 's/^##//p' $<
