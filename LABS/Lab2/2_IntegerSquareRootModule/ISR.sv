`timescale 1ns/100ps

module ISR(
    input               reset,
    input        [63:0] value,
    input               clock,
    output logic [31:0] result,
    output logic        done
)

    logic start;
    logic [63:0] prod_reg;
    logic [63:0] value_reg;

    // mult m0(    .clock(clock),
	// 		    .reset(reset),
	// 			.mcand({32'b0, result}),
	// 			.mplier({32'b0, result}),
	// 			.start(start),
	// 			.product(prod_reg),
	// 			.done(done)
    // );

    always_comb begin : ISR
        for (int i = 31; i >= 0; i--) begin
            result[i] = 1'b1;
            if (prod_reg > value_reg) begin
                result[i] = 1'b0;
            end
        end
    end

    generate
        genvar i;
        for (i = 31; i >= 0; i--) begin
            assign start = 1'b1;
            assign result[i] = 1'b1;
            @negedge(clock);
            assign start = 1'b0;
            mult (  .clock(clock),
			        .reset(reset),
				    .mcand({32'b0, result}),
				    .mplier({32'b0, result}),
				    .start(start),
				    .product(prod_reg),
				    .done(done)
            );
            if (prod_reg > value_reg) begin
                assign result[i] = 1'b0;
            end
        end
    endgenerate

    always_ff @(posedge clock) begin
        if (reset) begin
            
            value_reg <= value;
        end
        else begin
        end
    end

endmodule