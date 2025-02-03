#include <systemc.h>
#include "fir.h"
#include "tb.h"

// SYSTEM module
SC_MODULE( SYSTEM ) {
    tb      *tb0;
    fir     *fir0;

    sc_signal<bool>         rst_sig;
    sc_signal<sc_int<16>>   inp_sig;
    sc_signal<sc_int<16>>   outp_sig;

    sc_clock    clk_sig;

    SC_CTOR( SYSTEM ) 
        : clk_sig ("clk_sig", 10, SC_NS)
    {
        tb0 = new tb("tb0");
        tb0->clk( clk_sig );
        tb0->rst( rst_sig );
        tb0->inp( inp_sig );
        tb0->outp( outp_sig );

        fir0 = new fir("fir0");
        fir0->clk( clk_sig );
        fir0->rst( rst_sig );
        fir0->inp( inp_sig );
        fir0->outp( outp_sig ); 
    }

    ~SYSTEM() {
        delete tb0;
        delete fir0;
    }
};


// TOP module
SYSTEM *top = nullptr;

int sc_main(int argc, char** argv) {
    top = new SYSTEM("top");
    sc_start();
    return 0;
}