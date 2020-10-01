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

CC := gcc
CBPF := clang

#---------------------------------------------------
# CONFIGURATION OPTIONS
#---------------------------------------------------

CFLAGS := -O2 -Wall

INCLUDES += -Iinclude/
CPPFLAGS += $(INCLUDES)

LDFLAGS += -L$$HOME/kernels/linux-5.8.12/tools/lib/bpf
LDLIBS += -lbpf

SRC_DIR := .
BUILD_DIR := .

SRC := $(wildcard $(SRC_DIR)/*.c)
DEP := $(addprefix $(BUILD_DIR)/, $(notdir $(SRC:%.c=%.d)))

VPATH := $(SRC_DIR)/

include mk/signature

#---------------------------------------------------
# RULES
#---------------------------------------------------

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
