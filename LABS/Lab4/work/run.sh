#!/bin/bash

# Output file
OUTPUT_FILE="output.txt"

# Clear the output file if it exists
> $OUTPUT_FILE

# Define the tag arrays
CPU_TYPES=("RiscvO3CPU" "RiscvTimingSimpleCPU")
L1D_SIZES=("1kB" "2kB" "4kB")
L1I_SIZES=("1kB" "2kB" "4kB")
L2_SIZES=("16kB" "32kB" "16kB" "32kB")
L1D_ASSOCS=("1" "2" "4" "8")
BP_TYPES=("TournamentBP" "LTAGE")

# Iterate over all combinations
for cpu in "${CPU_TYPES[@]}"; do
  for l1d in "${L1D_SIZES[@]}"; do
    for l1i in "${L1I_SIZES[@]}"; do
      for l2 in "${L2_SIZES[@]}"; do
        for assoc in "${L1D_ASSOCS[@]}"; do
          for bp in "${BP_TYPES[@]}"; do
            COMMAND="build/RISCV/gem5.opt configs/example/se.py \
            --param system.cpu[0].workload[:].release=\"99.99.99\" \
            --cmd=lab4/part2_test \
            --cpu-type=${cpu} \
            --l1d_size=${l1d} \
            --l1i_size=${l1i} \
            --l2_size=${l2} \
            --l1d_assoc=${assoc} \
            --bp-type=${bp} \
            --caches --l2cache"

            echo "Executing: $COMMAND"
            echo "Results for --cpu-type=${cpu} --l1d_size=${l1d} --l1i_size=${l1i} --l2_size=${l2} --l1d_assoc=${assoc} --bp-type=${bp}" >> $OUTPUT_FILE
            $COMMAND >> $OUTPUT_FILE 2>&1
            echo -e "\n" >> $OUTPUT_FILE
          done
        done
      done
    done
  done
done
