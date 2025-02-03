#include <systemc.h>

// Testbench Module
SC_MODULE(tb) {
    sc_in<bool>     clk;
    sc_out<bool>    rst;
    sc_out<sc_int<16>>      inp;
    sc_in<sc_int<16>>       outp;

    void source(); // Produce output values (rst, inp)
    void sink();   // Read input values

    SC_CTOR(tb) {
        SC_CTHREAD(source, clk.pos());
        SC_CTHREAD(sink, clk.pos());
    }
};