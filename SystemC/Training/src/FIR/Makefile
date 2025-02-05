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