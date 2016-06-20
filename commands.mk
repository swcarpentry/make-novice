## ----------------------------------------
MAKE2PNG = make2graph | grep -v Makefile | dot -Tpng -o
FIGS = 02-makefile 02-makefile-challenge 04-dependencies 07-functions 09-conclusion-challenge
PNGS = $(patsubst %,fig/%.png,$(FIGS))

.PHONY: $(PNGS)

## diagrams       : rebuild diagrams of Makefiles.
diagrams: $(PNGS)

fig/02-makefile.png: build
	cp code/samples/02-makefile/* $<
	cd build && make -Bnd dats | $(MAKE2PNG) $(CURDIR)/$@

fig/02-makefile-challenge.png: build
	cp code/samples/02-makefile-challenge/* $<
	cd build && make dats && make -Bnd results.txt | $(MAKE2PNG) $(CURDIR)/$@

fig/04-dependencies.png: build
	cp code/samples/04-dependencies/* $<
	cd build && make dats && make -Bnd results.txt | $(MAKE2PNG) $(CURDIR)/$@

fig/07-functions.png: build
	cp code/samples/07-functions/* $<
	cd build && make -Bnd results.txt | $(MAKE2PNG) $(CURDIR)/$@

fig/09-conclusion-challenge.png: $<
	cp code/samples/09-conclusion-challenge/* build
	cd build && make -Bnd | $(MAKE2PNG) $(CURDIR)/$@ 
