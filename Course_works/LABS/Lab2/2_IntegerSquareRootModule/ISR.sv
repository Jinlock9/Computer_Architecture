`timescale 1ns/100ps

module ISR(
    input               reset,
    input        [63:0] value,
    input               clock,
    output logic [31:0] result,
    output logic        done
);

    logic start, flag;
    logic done_reg;
    logic [5:0] count; // 32 ~ 1

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

    always_ff @(posedge clock) begin
        if (reset) begin
            value_reg <= value;
            result <= 32'b0;
            count <= 6'd32;
            start <= 1'b0;
            done <= 1'b0;
            flag <= 1'b1;
        end
        else begin
            value_reg <= value_reg;
            if (count > 0 && ~done) begin
                if (flag) begin
                    start <= 1'b1;
                    flag <= 1'b0;
                    result[count-1] <= 1'b1;
                end
                else begin
                    if (done_reg) begin
                        if (prod_reg > value_reg) begin
                            result[count-1] <= 1'b0;
                        end
                        flag <= 1'b1;
                        count <= count-1;
                    end
                    else start <= 1'b0;
                end
            end
            else begin
                done <= 1'b1;
            end
        end
    end

endmodule