LIB_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
BOOK_DIR := $(shell pwd)
UTILS := $(LIB_DIR)/util.sh
TYPE ?= normal

CHAPTERS := $(sort $(shell $(UTILS) find_chapters $(BOOK_DIR)))
GIT_HASH := $(shell git rev-parse --short HEAD)

CHAPTER_OUTPUTS := $(addsuffix .pdf, $(addprefix build/, $(CHAPTERS)))
CHAPTER_INPUTS := $(addsuffix /doc.typ, $(CHAPTERS))


TYPST_ARGS := 
TYPST_ARGS += --root /
TYPST_ARGS += --input lib_dir='$(LIB_DIR)'
TYPST_ARGS += --input book_dir='$(BOOK_DIR)'
TYPST_ARGS += --input chapters='$(CHAPTERS)'
TYPST_ARGS += --input type='$(TYPE)'
TYPST_ARGS += --input git_hash='$(GIT_HASH)'

.PHONY: info
info:
	@echo Library dir: $(LIB_DIR)
	@echo Book dir: $(BOOK_DIR)
	@echo Chapters: $(CHAPTERS)
	@echo Git hash: $(GIT_HASH)
	@echo Arguments passed to typst: $(TYPST_ARGS)


###
### Build chapters in watch mode when editing
###
.PHONY: $(CHAPTER_OUTPUTS)
$(CHAPTER_OUTPUTS) : build/%.pdf : %/doc.typ
	@mkdir -p build
	typst watch $< $@ $(TYPST_ARGS) --input "file=$<" --input 'mode=chapter' --open

###
### Compile main PDF file
###
build/main.pdf : book.typ $(CHAPTER_INPUTS)
	@mkdir -p build
	typst compile $< $@ $(TYPST_ARGS) --input "file=$<" --input 'mode=book'

.PHONY: build/preview.pdf
build/preview.pdf : book.typ $(CHAPTER_INPUTS)
	@mkdir -p build
	typst watch $< $@ $(TYPST_ARGS) --input "file=$<" --input 'mode=book' --open


###
### Clean PDF-s
###
.PHONY: clean
clean:
	rm -rf build/

.PHONY: open-result
open-result: build/main.pdf
	xdg-open $<
