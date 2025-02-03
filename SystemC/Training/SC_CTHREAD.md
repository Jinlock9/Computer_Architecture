# `SC_CTHREAD()` Clocked Threads
#### Threads
- `SC_METHOD()`
    - Executes in one cycle
- `SC_CTHREAD()`
    - Executes in one or more cycles

## `SC_CTHREAD()`
- `SC_METHOD()` s
    - Limited to one cycle
    - Fine for counters or simple sequential designs
    - Not much different than hand coded RTL
    - Can't handle multicycle algorithms
- `SC_CTHREAD()`s
    - Not limited to one cycle
    - Can contain continuous loops
    - Can contain large blocks of code with operations or control
    - Great for behavioral synthesis



### FIR Filter
```
             +---------+
    input--->|         |
             |         |---> output
    clock--->|         |
    reset--->|   fir   |
             +---------+
```
```
         +------------------------------------------+
inp ---> |  [SR] -> [SR] -> [SR] -> [SR] -> [SR]    |
         |    |       |       |       |       |     |
         |   [*]:18  [*]:77  [*]:107 [*]:77  [*]:18 |
         |    |       |       |       |       |     |
clk ---> |   [+]-----[+]-----[+]-----[+]-----[+]-->[+]--> outp
rst ---> |                              FIR         |
         +------------------------------------------+

```
```cpp
/*
 * SC_CTHREAD ( [Name of the Clock Thread func],
 *              [Edge of clock we want to be sensitive to] );
 * reset_signal_is ( [Name of reset signal], [Initial Value]);
 */

#include <systemc.h>
SC_MODULE ( fir ) {
    sc_in<bool>        clk;
    sc_in<bool>        rst;
    sc_in<sc_int<16>>  in;
    sc_out<sc_int<16>> out;

    void fir_main();

    SC_CTOR( fir ) {
        SC_CTHREAD ( fir_main, clk.pos() );
        reset_signal_is( rst, true ); // 
    }
}
```
```cpp
// Coefficients for each FIR
const sc_uint<8> coef[5] = {
    18,
    77,
    107,
    77,
    18
};

// FIR Main thread
void fir::fir_main(void) {
    sc_int<16> taps[5]; // Shift Registers
    // Reset
    out.write(0);
    wait();

    while (true) {
        // Shift!
        for (int i = 4; i > 0; i--) {
            taps[i] = taps[i - 1];
        }
        taps[0] = in.read();

        sc_int<16> val;
        for (int i = 0; i < 5; i++) {
            val += coef[i] * taps[i];
        }
        out.write(val);
        wait();
    }
}

/*
 * void fir::fir_main(void) {
 *     // Reset code
 *     // Reset internal variables
 *     // Reset outputs
 *     wait();
 *
 *     while(true) {
 *         // Read inputs
 *         // Algorithm code
 *         // Write outputs    
 *     }
 * } 
```

