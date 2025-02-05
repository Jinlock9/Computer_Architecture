# Testbench Measurement
- Add measurements
    - Did our simulation pass or fail?
    - DUT performance metrics
        - Latency?
        - Throughput?
- Hanging simulation prevention

### Pass/Fail Criteria
```
                       +----------------------------------------------+
                       |                   SYSTEM                     |
                       |       tb0                         fir0       |
                       |  +------------+             +--------------+ | 
                       |  | +--------+ |   inp_sig   |  +---------+ | |  
                       |  | |source()|---------------->|          | | |     
   GOLDEN   output.dat |  | +--------+ |             | |fir_main()| | | 
  +------+ ? +------+  |  | +--------+ |   outp_sig  | |          | | |
  |      | = |      |<=|  | | sink() |<----------------|          | | |
  +------+   +------+  |  | +--------+ |             | +----------+ | |            
                       |  +------------+             +--------------+ |
                       |                                              |
                       +----------------------------------------------+
```
- Compare GOLDEN and output.dats

### Latency
The number of clock cycle from the time input is valid to the time output is valid
- `start time`: when input data sent
- `end time`: when output data received

### Time Stamps in SystemC
- `sc_time`: `start_time`, `end_time`
- `sc_time_stamp()`
- `sc_clock*`

```cpp
void tb::source() {
    inp.write(tmp);
    start_time = sc_time_stamp();
}

void tb::sink() {
    indata = outp.read();
    end_time sc_time_stamp();
}
```

### Throughput
- `Avg Throughput` = (`start[N-1]` - `start[0]`) / (`clock period` * `(N - 1)`) = `cycle` / `input`

### Guard condition
    - Source thread timeout code
    - Hanging simulation prevention