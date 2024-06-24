# Computer_Architecture

Course works of 2024SU **ECE4700J: Computer Architecture** course at University of Michigan - Shanghai Jiaotong University Joint Institute.

**HONOR CODE**  
> In the event that similar course content is assigned going forward, it is the duty of JI students to avoid copying or adjusting these codes, or MD/PDF documents, in adherence to the Honor Code. The repository owner disclaims any liability for the actions of others.

## PROJECT
Scalar Intel P6 Style Out-of-Order Pipeline
- P6 Microarchitecture
- Tomasulo Algorithm
- Re-order Buffer

## LABS
### LAB 1: Getting Started with Vivado and SystemVerilog
1. Arbiter: Design a Round Robin Bus Arbiter
2. Debugging: Debugging of SystemVerilog Design
### LAB 2: A Pipelined Integer Square Root Module
1. Designing the Pipelined Multiplier
2. Designing the Integer Square Root Module
3. CORDIC Implementation - *optional -> incomplete*
### LAB 3: RISC-V Five-Stage Pipeline Optimization
1. RISC-V Five-Stage Pipeline Optimization
    - Simple RISC-V Five-Stage Pipeline Processor
    - Hazard Control: Structural, Control, and Data
    - LAB3\lab3\lab3_work\optimization
### LAB 4: First Try with Architectural Simulation Tools
1. Getting Started with gem5
    - gem5 Installation
    - `build/RISCV/gem5.opt configs/example/se.py --param 'system.cpu[0].workload[:].release = "99.99.99"' --cmd=lab4/part1_test | tee file_to_submit_a.txt`
    - work/file_to_submit_a.txt
2. Play with Configurations
    - Using the default configuration scripts  
    - `build/RISCV/gem5.opt configs/example/se.py --param 'system.cpu[0].workload[:].release = "99.99.99"' --cmd=lab4/part2_test --cpu-type=RiscvO3CPU --l1d_size=4kB --l1i_size=4kB --l2_size=32kB --l1d_assoc=4 --bp-type=TournamentBP --caches --l2cache | tee file_to_submit_b.txt`
    - work/file_to_submit_b.txt
    - work/m5out:
        - config.ini
        - config.json
        - stats.txt

## Author

### Jinlock Choi
- University of Michigan - Shanghai Jiaotong University Joint Institute
- jinlock99@sjtu.edu.cn
- teampoclain@gmail.com
- Location:
    - *Seoul, Korea*
    - *Shanghai, China (2023 ~)*