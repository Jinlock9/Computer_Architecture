# Test benches

## Verification
- Hierarchical test environment
    - Top level test structure
        - Instance of FIR module (DUT)
        - Instance of testbench module
        - Connectivity
    - Testbench module
        - Stimulus thread
        - Sink thread

#### FIR
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
## Test Environment
```
    +------------------------------------------+
    |                   SYSTEM                 |
    |                                          |
    |             sc_clock clk_sig             |
    |      tb0           |            fir0     |
    |  +--------+        |         +--------+  |
    |  |     clk|<---------------->|clk     |  |
    |  |        |                  |        |  |
    |  |     rst|---- rst_sig ---->|rst     |  | 
    |  |        |                  |        |  |
    |  |     inp|---- inp_sig ---->|inp     |  |
    |  |        |                  |        |  |
    |  |    outp|--- outp_sig ---->|outp    |  | 
    |  |        |                  |        |  |
    |  |   tb   |                  |  fir   |  |
    |  +--------+                  +--------+  | 
    |                                          | 
    +------------------------------------------+ 
```

#### `main.cc`
```cpp
SC_MODULE( SYSTEM ) {
    // Module declaration

    // Local signal declarations

    SC_CTOR( SYSTEM ) {
        // Module instance signal connections
    }

    ~SYSTEM() // Desctructor
};
```
- Copy constructor for clock signal:
```cpp
SC_CTOR( ... ) : clk_sig ("clk_sig", [Number of Unit], [Actual Time Unit])
```