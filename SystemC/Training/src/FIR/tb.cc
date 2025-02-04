#include "tb.h"

void tb::source() {
    // Reset
    inp.write(0);
    inp_vld.write(0);
    rst.write(1);
    wait();
    rst.write(0);
    wait();

    sc_int<16> tmp;

    // Send stimulus to FIR
    for (int i = 0; i < 64; i++) {
        if (i > 23 && i < 29) tmp = 256;
        else tmp = 0;

        inp_vld.write(1);
        inp.write(tmp);
        do {
            wait();
        } while (!inp_rdy.read()); // Wait until the input is ready
        inp_vld.write(0);
    }
}

void tb::sink() {
    sc_int<16> indata;

    char output_file[256];
    sprintf(output_file, "wb");
    if (outfp == NULL) {
        printf("Couldn't open output.dat for writing.\n");
        exit(0);
    }

    // Initialize port
    outp_rdy.write(0);

    // Read output coming from DUT
    for (int i = 0; i < 64; i++) {
        outp_rdy.write(1);
        do {
            wait();
        } while (!outp_vld.read());
        indata = outp.read();
        outp_rdy.write(0);
        
        fprintf(outfp, "%g\n", indata.to_double());
        cout << i << " :\t" << indata.to_double() << endl;
    }

    // End simulation
    fclose(outfp);
    sc_stop();
}
