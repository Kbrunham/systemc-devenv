THIS_MK_ABSPATH := $(abspath $(lastword $(MAKEFILE_LIST)))
THIS_MK_DIR := $(dir $(THIS_MK_ABSPATH))

# Enable pipefail for all commands
SHELL=/bin/bash -o pipefail

# Enable second expansion
.SECONDEXPANSION:

# Clear all built in suffixes
.SUFFIXES:

##############################################################################
# Special use variables
##############################################################################
NULL :=
SPACE := $(NULL) $(NULL)
INFO_INDENT := $(SPACE)$(SPACE)$(SPACE)

##############################################################################
# Environment check
##############################################################################
REPO_ROOT_DIR := $(THIS_MK_DIR)
WORK_ROOT_DIR := $(THIS_MK_DIR)/work

VENV_DIR := $(REPO_ROOT_DIR)/venv
VENV_PIP := $(VENV_DIR)/bin/pip
ifneq ($(https_proxy),)
PIP_PROXY := --proxy $(https_proxy)
else
PIP_PROXY :=
endif
VENV_PIP_INSTALL := $(VENV_PIP) install $(PIP_PROXY) --timeout 90
VENV_PYTHON := $(VENV_DIR)/bin/python
VENV_CLANG_FORMAT := $(VENV_DIR)/bin/clang-format

BOOST_VERSION ?= 1.86.0
BOOST_VERSION_MOD := $(subst .,_,$(BOOST_VERSION))
BOOST_ROOTDIR ?= $(REPO_ROOT_DIR)/boost
export BOOST_ROOTDIR
export BOOST_ROOT=$(BOOST_ROOTDIR)

SYSTEMC_VERSION ?= 3.0.2
SYSTEMC_HOME ?= $(REPO_ROOT_DIR)/systemc
export SYSTEMC_HOME

BUILD_DIR ?= build
CMAKE ?= cmake
CTEST ?= ctest

# Explicit stamp files — each prep recipe must touch its stamp on success.
STAMPS_DIR := $(REPO_ROOT_DIR)/.stamps
VENV_STAMP := $(STAMPS_DIR)/venv.done
BOOST_STAMP := $(STAMPS_DIR)/boost.done
SYSTEMC_STAMP := $(STAMPS_DIR)/systemc.done
BUILD_PREP_STAMP := $(STAMPS_DIR)/build-prep.done
BUILD_PREP_INPUTS := Makefile requirements.txt

# Re-run cmake configure when root CMake inputs change.
CMAKE_INPUTS := CMakeLists.txt $(wildcard extern/cmake_helpers/*.cmake)

##############################################################################
# Set default goal before any targets. The default goal here is "test"
##############################################################################
DEFAULT_TARGET := test

.DEFAULT_GOAL := default
.PHONY: default
default: $(DEFAULT_TARGET)

##############################################################################
# Makefile starts here
##############################################################################

$(WORK_ROOT_DIR):
	mkdir -p $(WORK_ROOT_DIR)

$(STAMPS_DIR):
	mkdir -p $(STAMPS_DIR)

$(VENV_STAMP): requirements.txt Makefile | $(STAMPS_DIR)
	python3 -m venv $(VENV_DIR)
	$(VENV_PIP_INSTALL) --upgrade pip
	$(VENV_PIP_INSTALL) -r requirements.txt
	@touch $@

.PHONY: venv
venv: $(VENV_STAMP)

$(BOOST_STAMP): Makefile | $(WORK_ROOT_DIR) $(STAMPS_DIR)
	cd $(WORK_ROOT_DIR) && wget https://archives.boost.io/release/$(BOOST_VERSION)/source/boost_$(BOOST_VERSION_MOD).tar.bz2
	cd $(WORK_ROOT_DIR) && tar --bzip2 -xf boost_$(BOOST_VERSION_MOD).tar.bz2
	cd $(WORK_ROOT_DIR)/boost_$(BOOST_VERSION_MOD) && ./bootstrap.sh --prefix=$(BOOST_ROOTDIR)
	cd $(WORK_ROOT_DIR)/boost_$(BOOST_VERSION_MOD) && ./b2 install \
		--with-filesystem \
		--with-regex \
		--build-type=minimal \
		--link=static
	rm -rf $(WORK_ROOT_DIR)/boost_$(BOOST_VERSION_MOD) $(WORK_ROOT_DIR)/boost_$(BOOST_VERSION_MOD).tar.bz2
	@touch $@

.PHONY: boost
boost: $(BOOST_STAMP)

$(SYSTEMC_STAMP): Makefile | $(WORK_ROOT_DIR) $(STAMPS_DIR)
	cd $(WORK_ROOT_DIR) && wget -q https://github.com/accellera-official/systemc/archive/refs/tags/$(SYSTEMC_VERSION).tar.gz -O systemc-$(SYSTEMC_VERSION).tar.gz
	cd $(WORK_ROOT_DIR) && tar -xzf systemc-$(SYSTEMC_VERSION).tar.gz
	cd $(WORK_ROOT_DIR)/systemc-$(SYSTEMC_VERSION) && cmake -B build \
		-DCMAKE_INSTALL_PREFIX=$(SYSTEMC_HOME) \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_CXX_STANDARD=17 \
		-DBUILD_SHARED_LIBS=OFF
	cd $(WORK_ROOT_DIR)/systemc-$(SYSTEMC_VERSION)/build && cmake --build . -j$$(nproc) && cmake --install .
	rm -rf $(WORK_ROOT_DIR)/systemc-$(SYSTEMC_VERSION) $(WORK_ROOT_DIR)/systemc-$(SYSTEMC_VERSION).tar.gz
	@touch $@

.PHONY: systemc
systemc: $(SYSTEMC_STAMP)

.PHONY: clean
clean:
	rm -rf venv boost systemc $(WORK_ROOT_DIR) $(STAMPS_DIR)

# Deep clean using git
.PHONY: dev-clean
dev-clean :
	git clean -dfx --exclude=/.vscode --exclude=.lfsconfig

# Using git
.PHONY: dev-update
dev-update :
	git pull
	git submodule update --init --recursive

.PHONY: prepare-tools
prepare-tools: $(BUILD_PREP_STAMP)

$(BUILD_PREP_STAMP): $(BUILD_PREP_INPUTS) $(VENV_STAMP) $(BOOST_STAMP) $(SYSTEMC_STAMP)
	@mkdir -p $(STAMPS_DIR)
	@touch $@

.PHONY: build-prep
build-prep: $(BUILD_PREP_STAMP)

.PHONY: build
build: $(BUILD_PREP_STAMP) $(CMAKE_INPUTS)
	$(CMAKE) -B $(BUILD_DIR)
	$(CMAKE) --build $(BUILD_DIR)

.PHONY: test
test: build
	$(CTEST) --test-dir $(BUILD_DIR)

.PHONY: all
all: test

##############################################################################
# Style checks
##############################################################################
CLANG_CHECK_FILES := $(shell git ls-files *.c *.cpp *.h *.hpp)

.PHONY: style-check-clang
style-check-clang: $(VENV_STAMP)
	$(VENV_CLANG_FORMAT) --dry-run --Werror  $(CLANG_CHECK_FILES)

.PHONY: style-format-clang
style-format-clang: $(VENV_STAMP)
	$(VENV_CLANG_FORMAT) -style=file -i $(CLANG_CHECK_FILES)


###############################################################################
#                    Optional Confluence spec import
###############################################################################
.PHONY: import-spec-images
import-spec-images:
	python3 tools/import_confluence_images.py


###############################################################################
#                                HELP
###############################################################################
.PHONY: help
help:
	$(info Common targets)
	$(info --------------)
	$(info build-prep     Ensure deps (venv, boost, systemc); reruns if Makefile/requirements change)
	$(info prepare-tools  Same as build-prep (legacy alias))
	$(info build          build-prep + cmake configure/compile ($(BUILD_DIR)/))
	$(info test           Build then run ctest (default goal))
	$(info all            Same as test)
	$(info)
	$(info import-spec-images   Optional: download Confluence diagrams (needs API env + manifest))
	$(info style-format-clang   Apply .clang-format)
	$(info style-check-clang    Verify formatting (CI))
	$(info clean                Remove venv, boost, systemc, work/, .stamps/)
	$(info dev-clean            git clean -dfx (destructive))
