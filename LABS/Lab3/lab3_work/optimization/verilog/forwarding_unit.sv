`ifndef __FORWARD_V__
`define __FORWARD_v__

module forwarding_unit (
    input [4:0] id_ex_rs1,
    input [4:0] id_ex_rs2,
    // EX HAZARD
    input [4:0] ex_mem_rd,
    // MEM HAZARD
    input [4:0] mem_wb_rd

    // FORWARD
    output FORWARD forward1,
    output FORWARD forward2
);

    // FORWARD 1
    always_comb begin
        if ((ex_mem_rd != `ZERO_REG) && (ex_mem_rd == id_ex_rs1)) begin
            forward1 = `EX_MEM_FORWARD;
        end
        else if ((mem_wb_rd != `ZERO_REG) && (mem_wb_rd == id_ex_rs1)) begin
            forward1 = `MEM_WB_FORWARD;
        end
        else begin
            forward1 = `NO_FORWARD;
        end
    end

     // FORWARD 2
    always_comb begin
        if ((ex_mem_rd != `ZERO_REG) && (ex_mem_rd == id_ex_rs2)) begin
            forward2 = `EX_MEM_FORWARD;
        end
        else if ((mem_wb_rd != `ZERO_REG) && (mem_wb_rd == id_ex_rs2)) begin
            forward2 = `MEM_WB_FORWARD;
        end
        else begin
            forward2 = `NO_FORWARD;
        end
    end

endmodule : forwarding_unit

`endif // __FORWARD_V__