# Don't use implicit rules
MAKEFLAGS += -rR
.SUFFIXES:

# Avoid character set stuff
unexport LC_ALL
LC_COLLATE=C
LC_NUMERIC=C
export LC_COLLATE LC_NUMERIC

# Avoid shell env settings
unexport GREP_OPTIONS

.PHONY: all
all: article_template.pdf

%.pdf: %.tex
	latexmk -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error -pdf $<

.PHONY: clean
clean:
	latexmk -C
