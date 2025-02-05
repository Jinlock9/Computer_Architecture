# Basic Compiler Techniques for Exposing ILP
A compiler's ability to perform scheduling depends:
- the amount of ILP available in the program
- the latencies of the functional units in the pipeline

#### For technical aspects:
see *Computer Architecture: A Quantative Approach 6th Edition* by John L. Hennessy & David A. Patterson chapter 3.2

### Loop Unrolling:
Replicating loop body multiple times to increase the number of instructions relative to the branch and overheads.

#### Key Conditions and Points:
- Loop iterations are independent
- Use different registers to avoid unnecessary constraints
- Eliminate the extra test and branch & adjust loop termination and iteration
- Load and Store inside the unrolled loop can be interchangable
    - Loads and Stores from different iterations are independent
- Preserve any dependencies

### Factors limiting the gains for loop unrolling
1. Decrease in the amount of overhead amortized with each unroll
2. Code side limitation
    - Larger code side could cause an increase in the instruction cache miss rate
    - Can cause **register pressure** -> it may not be possible to allocate all the live values to the registers
3. Compiler limitation

    > The use of sophisticated high-level transformations, whose potential improvements are difficult to measure before detailed code generation, has led to significant increases in the complexity of modern compilers.

