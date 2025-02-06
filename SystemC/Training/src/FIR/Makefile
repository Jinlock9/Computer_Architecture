# This makefile assumes SYSTEMC is set to the SystemC
# installation. The SystemC installation should have an include 
# directory for the header files and a lib-linux directory for the
# compiled kernel library. For other platforms, chage SYSTEMC_ARCH to
# the appropriate value.

SYSTEMC=/home/jinlock/LIB/systemc-3.0.1/

SYSTEMC_ARCH=linux64
#SYSTEMC_ARCH=linux
LIB_DIRS=$(SYSTEMC)/lib-$(SYSTEMC_ARCH)

# Include directories
INCLUDE_DIRS=-I. -I$(SYSTEMC)/include

# header files used, for dependency checking
HEADERS= fir.h tb.h

# source files used, for dependency checking
SOURCES= main.cc fir.cc tb.cc

DEPENDENCIES= \
		Makefile \
		$(HEADERS) \
		$(SOURCES)

LIBS= -lsystemc -lstdc++ -lm

TESTS= main

all: $(TESTS)
		./$(TESTS)
		@make cmp_result

$(TESTS): $(DEPENDENCIES)
		gcc -g -o $@ $(SOURCES) $(INCLUDE_DIRS) -L$(LIB_DIRS) $(LIBS)

clean:
		rm -f $(TESTS) *.dat

# The cmp_result target compares the simulation results with the
# golden results. The testbench writes out the results file (output.dat)
# in the simulation configuration directory. The cmp_result target is 
# automatically run at the end of each simulation.

GOLD_DIR = ./golden
GOLD_FILE = $(GOLD_DIR)/ref_output.dat

cmp_result:
	@echo "****************************************"
	@if diff -w $(GOLD_FILE) ./output.dat ; then \
		echo "SIMULATION PASSED"; \
	else \
		echo "SIMULATION FAILED"; \
	fi
	@echo "****************************************"

# diff -w : ignore white space difference