`timescale 1ns/100ps

`define DEBUG_OUT 1'b1

module arbiterFSM(
        input clock, reset,
        input [2:0] request,
        output [2:0] grant
        `ifdef DEBUG_OUT
        , output [1 : 0] state_out
        `endif
    );
    // parameter definition for the four states, please do not modify
    parameter IDLE = 2'b00, GRANT_0 = 2'b01, GRANT_1 = 2'b10, GRANT_2 = 2'b11;
    logic [1:0] state;
    logic [1:0] state_next;
    
    `ifdef DEBUG_OUT
	assign state_out = state;
	`endif

    always_ff @(posedge clock, posedge reset) begin
        //////////////////////////////////////////////////////
        // TODO: Update the state here                      //
        //////////////////////////////////////////////////////
        
    end
    
    always_comb begin
        //////////////////////////////////////////////////////
        // TODO: Calculate the next state here              //
        //////////////////////////////////////////////////////

    end
    
    //////////////////////////////////////////////////////
    // TODO: Caculate the output (grant) here           //
    //////////////////////////////////////////////////////
    assign grant[2] = 
    assign grant[1] =
    assign grant[0] =
endmodule
