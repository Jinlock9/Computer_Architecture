`timescale 1ns/100ps

module ISR(
    input               reset,
    input        [63:0] value,
    input               clock,
    output logic [31:0] result,
    output logic        done
);

    parameter INIT = 2'b00, ASGN = 2'b01, MULT = 2'b10, DONE = 2'b11;

    logic start, done_reg;
    logic [1:0] state, state_next;

    logic [4:0] count;

    logic [63:0] prod_reg;
    logic [63:0] value_reg;

    mult m0(    .clock(clock),
			    .reset(reset),
				.mcand({32'b0, result}),
				.mplier({32'b0, result}),
				.start(start),
				.product(prod_reg),
				.done(done_reg)
    );

    always_comb begin
        case (state)
            INIT: begin
                result = 32'b0;
                start = 1'b0;
                count = 5'd31;
                state_next = ASGN;
            end
            ASGN: begin // ASSIGN
                start = 1'b1;
                result[count] = 1'b1;
                state_next = MULT;
            end
            MULT: begin
                start = 1'b0;
                if (done_reg) state_next = DONE;
                else state_next = state;
            end
            DONE: begin
                if (prod_reg > value_reg) begin
                    result[count] = 1'b0;
                    count = count - 1;
                    state_next = ASGN;
                end
                else begin
                    done = 1'b1;
                    state_next = INIT;
                end
            end
            default: begin
                state_next = INIT;
                count = 5'd31;
                start = 1'b0;
                done = 1'b0;
                result = 32'b0;
            end
        endcase
    end

    always_ff @(posedge clock) begin
        if (reset) begin
            value_reg <= value;
            state <= INIT;
        end
        else begin
            value_reg <= value_reg;
            state <= state_next;
        end
    end

endmodule