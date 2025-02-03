#include "fir.h"

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