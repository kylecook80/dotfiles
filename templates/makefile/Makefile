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
all:

.PHONY: clean
clean:
