# Handshaking

## Test Environment
```
    +----------------------------------------------+
    |                   SYSTEM                     |
    |       tb0                         fir0       |
    |  +------------+             +--------------+ | 
    |  | +--------+ |   inp_sig   |  +---------+ | |  
    |  | |source()|---------------->|          | | |     
    |  | +--------+ |             | |fir_main()| | | 
    |  | +--------+ |   outp_sig  | |          | | |
    |  | | sink() |<----------------|          | | |
    |  | +--------+ |             | +----------+ | |            
    |  +------------+             +--------------+ |
    |                                              |
    +----------------------------------------------+
```
```
    +------------------------------------------+
    |                 SYSTEM                   |
    |                                          |
    |                                          |
    |      tb0                        fir0     |
    |  +--------+                  +--------+  |
    |  |     inp|-----inp_sig----->|inp     |  |
    |  | inp_vld|---inp_vld_sig--->|inp_vld |  |
    |  | inp_rdy|<--inp_rdy_sig----|inp_rdy |  |
    |  |        |                  |        |  |
    |  |    outp|<---outp_sig------|outp    |  |
    |  |outp_vld|<--outp_vld_sig---|outp_vld|  |
    |  |outp_rdy|---outp_rdy_sig-->|outp_rdy|  |
    |  |        |                  |        |  |
    |  |   tb   |                  |  fir   |  |
    |  +--------+                  +--------+  | 
    |                                          | 
    +------------------------------------------+ 
```
- Valid(`vld`): check whether the signal is valid
- Ready(`rdy`): check whether the signal is ready

## Handshaking
#### Ready/Valid protocol
- Companion bool signals to I/O
- Asserting `valid`, wait for `ready`
- Asserting `ready`, wait for `valid`
    - `do/while` loops
- No data loss
- Simulations pass