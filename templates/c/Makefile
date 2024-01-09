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

# OS Detection
OS := $(shell uname -s)

CC := cc
CXX := c++

TARGETS := main

main_DEPS :=
ifeq ($(OS),Linux)
	main_DEPS += strlcat strlcpy
endif

EXTRA_FILES :=

#---------------------------------------------------
# CONFIGURATION OPTIONS
#---------------------------------------------------

include config.mk

DEBUG ?= FALSE

BUILD_DIR ?= src

CSTD ?= c17
CXXSTD ?= c++20

CFLAGS ?= -O2 -march=native --std=$(CSTD) -fno-strict-aliasing -D_FORTIFY_SOURCE=2
CFLAGS_DEBUG ?= -g -Wall -pedantic -O0

CXXFLAGS ?= -O2 -march=native --std=$(CXXSTD) -fno-strict-aliasing -D_FORTIFY_SOURCE=2
CXXFLAGS_DEBUG ?= -g -Wall -pedantic -O0

INCLUDES += -Iinclude/
CPPFLAGS += $(INCLUDES)

LDFLAGS +=
LDLIBS +=

#---------------------------------------------------
# DO NOT EDIT
#---------------------------------------------------

define DEPS_template =
$(1)_DEPS := $$(addprefix $$(BUILD_DIR)/, $$($(1)_DEPS))
$(1)_DEPS := $$(addsuffix .o, $$($(1)_DEPS))
endef

$(foreach target,$(TARGETS),$(eval $(call DEPS_template,$(target))))

ifeq ($(OS),Darwin)
	CFLAGS += -DDARWIN
	CXXFLAGS += -DDARWIN
endif

ifeq ($(OS),Linux)
	CFLAGS += -DLINUX
	CXXFLAGS += -DLINUX
endif

ifeq ($(DEBUG),TRUE)
	CFLAGS += -DDEBUG
endif

SRC_DIR := src

SRC := $(wildcard $(SRC_DIR)/*.c)
DEP := $(addprefix $(BUILD_DIR)/, $(notdir $(SRC:%.c=%.d)))

VPATH := $(SRC_DIR)/

include mk/signature

#---------------------------------------------------
# RULES
#---------------------------------------------------

# Tracer Support
ifdef TRACE
.PHONY: _trace _value
_trace: ; @$(MAKE) --no-print-directory TRACE= \
	$(TRACE)='$$(warning TRACE $(TRACE))$(shell $(MAKE) TRACE=$(TRACE) _value)'
_value: ; @echo '$(value $(TRACE))'
endif

ifeq ($(DEBUG),TRUE)
.PHONY: all
all: debug
else
.PHONY: all
all: rel
endif

.PHONY: rel
rel: $(TARGETS)

.PHONY: debug
debug: CFLAGS += $(CFLAGS_DEBUG)
debug: $(TARGETS)

define TARGETS_template =
$(1): %: $$(BUILD_DIR)/%.o $$($(1)_DEPS)
	$$(CC) $$(LDFLAGS) $$^ $$(LDLIBS) -o $$@
endef

$(foreach target,$(TARGETS),$(eval $(call TARGETS_template,$(target))))

-include $(DEP)

$(BUILD_DIR)/%.o : %.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -MMD -c $< -o $@

$(BUILD_DIR)/%.o : %.cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -MMD -c $< -o $@

doc:
	doxygen

.PHONY: clean
clean:
	-rm -f $(BUILD_DIR)/*.o
	-rm -rf $(BUILD_DIR)/*.dSYM/
	-rm -f $(BUILD_DIR)/*.d

.PHONY: distclean
distclean: clean
	-rm -f $(TARGETS)
	-rm -f $(EXTRA_FILES)
	-rm -rf doc/

#---------------------------------------------------
# UTILITIES
#---------------------------------------------------

print-%: ; @echo $* = '$($*)' from $(origin $*)

.PHONY: printvars
printvars:
	@$(foreach V,$(sort $(.VARIABLES)), \
		$(if $(filter-out environ% default automatic, \
			$(origin $V)),$(info $V=$($V) ($(value $V)))))
