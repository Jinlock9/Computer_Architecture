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
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= state_next;
        end
    end
    
    always_comb begin
        case (state)
            IDLE: begin
                state_next = request[2] ? GRANT_2 : (request[1] ? GRANT_1 : (request[0] ? GRANT_0 : IDLE));
            end
            GRANT_2: state_next = request[1] ? GRANT_1 : (request[0] ? GRANT_0 : GRANT_2);
            GRANT_1: state_next = request[0] ? GRANT_0 : (request[2] ? GRANT_2 : GRANT_1);
            GRANT_0: state_next = request[2] ? GRANT_2 : (request[1] ? GRANT_1 : GRANT_0);
            default: state_next = IDLE;
        endcase
    end

    assign grant[2] = (((state == GRANT_2) & request[2])) ? 1'b1 : 1'b0;
    assign grant[1] = (((state == GRANT_1) & request[1])) ? 1'b1 : 1'b0;
    assign grant[0] = (((state == GRANT_0) & request[0])) ? 1'b1 : 1'b0;
    
endmodule
