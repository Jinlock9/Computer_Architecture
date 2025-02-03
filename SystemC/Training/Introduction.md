# Introduction

### What is SystemC?
- Not a language
- Library of C++ classes
- Hardware aware
    - Concurrency
    - Bit accuracy
    - Simulation time advancement

### How to make Module
- and2
```
          +--------+
    a --->|  and2  |---> f
    b --->|        |
          +--------+
```
```cpp
#include <systemc.h>

SC_MODULE ( and2 ) {               // SC_MODULE ( <MODULE_NAME> )
    sc_in< sc_uint<1> >  a, b;     // sc_in<DT>   a, b;
    sc_out< sc_uint<1> > f;        // DT: Data Type
    sc_in<bool>          clk;      // bool -> single wire

    void func() {
        f.write( a.read() & b.read() );
    }

    SC_CTOR ( and2 ) {             // Constructor
        /* ADD func to THREAD */
        SC_METHOD( func );         /* ADD Sensitivity */
        // sensitive << a << b;    // Now SC_METHOD is sensitive to changes of a and b.
        // sensitive << clk.pos(); // Sensitive to positive clock edge
        sensitive << clk.neg();    // Sensitive to negative clock edge

    }
}
```

### Port I/O
- SystemC uses functions to read from sc_in<> or write to sc_out<>
    - `.read()`
    - `.write()`
- Example:
    - `x = inp.read()`
    - `outp.write(val)`

### Threads
- A **thread** is a function made to act like a hardware process
    - Run concurrently
    - Sensitive to signal, clock edges or fixed amounts of simulation time
    - Not called by the user, always active
- SystemC supprots three kinds of threads:
    - `SC_METHOD()`
    - `SC_THREAD()`
    - `SC_CTHREAD()`

#### `SC_METHOD()`
- Execute once every sensitivity event
- Run continuously
- Analogous to a Verilog `@always` block
- Synthesizable
    - Useful for combinational expressions or simple sequential logic

#### `SC_THREAD()`
- Runs once at start of simulation, then suspends itself when done
- Can contain an infinite loop to execute code at a fixed rate of time
- Similar to a Verilog `@initial` block
- NOT Synthesizable
    - Useful in testbenches to describe clocks or inital startup signal sequences

#### `SC_CTHREAD()`
- `C` means `Clock`
- Means "clocked thread"
- Runs continuously
- References a clock edge
- Synthesizable
- Can take one or more clock cycles to execute a signal iteration
- Used in 99% of all high-level behavioral designs


### Integer Datatypes
- SystemC has bit-accurate versions of the integer datatype
    - Datatypes have a fixed width
    - Unlike C int type, always 32 bits
- Unsigned and signed
    - `sc_uint<N>`
    - `sc_int<N>`

#### Unsigned Integers
- `sc_uint<N>`
    - N is the bitwidth
    - ex. `sc_uint<3> x;`
     
        |  X  | Value |
        |:---:|:-----:|
        | 000 |   0   |
        | 001 |   1   |
        | 010 |   2   |
        | 011 |   3   |
        | 100 |   4   |
        | 101 |   5   |
        | 110 |   6   |
        | 111 |   7   |

#### Signed Integers
- `sc_int<N>`
    - N is the bitwidth
    - ex. `sc_int<3> x;`
     
        |  X  | Value |
        |:---:|:-----:|
        | 000 |   0   |
        | 001 |   1   |
        | 010 |   2   |
        | 011 |   3   |
        | 100 |  -4   |
        | 101 |  -3   |
        | 110 |  -2   |
        | 111 |  -1   |