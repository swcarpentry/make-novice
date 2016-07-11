## ----------------------------------------
MAKE2PNG = make2graph | grep -v Makefile | grep -v config.mk | grep -v commands.mk | dot -Tpng -o
FIGS = 02-makefile 02-makefile-challenge 04-dependencies 07-functions 09-conclusion-challenge-1
PNGS = $(patsubst %,fig/%.png,$(FIGS))

.PHONY: $(PNGS)

## diagrams       : rebuild diagrams of Makefiles.
diagrams: $(PNGS)

fig/02-makefile.png: build
	cp code/02-makefile/* $<
	cd build && make -Bnd dats | $(MAKE2PNG) $(CURDIR)/$@

fig/02-makefile-challenge.png: build
	cp code/02-makefile-challenge/* $<
	cd build && make dats && make -Bnd results.txt | $(MAKE2PNG) $(CURDIR)/$@

fig/04-dependencies.png: build
	cp code/04-dependencies/* $<
	cd build && make dats && make -Bnd results.txt | $(MAKE2PNG) $(CURDIR)/$@

fig/07-functions.png: build
	cp code/07-functions/* $<
	cd build && make -Bnd results.txt | $(MAKE2PNG) $(CURDIR)/$@

fig/09-conclusion-challenge-1.png: build
	cp code/09-conclusion-challenge-1/* $<
	cd build && make -Bnd | $(MAKE2PNG) $(CURDIR)/$@ 

build:
	mkdir -p $@
	cp code/*.py $@
	cp -r data/books $@
